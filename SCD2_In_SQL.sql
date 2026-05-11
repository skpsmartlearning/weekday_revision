-------------------------------------------------------------------
-- STEP 1: Create Bronze Table (Raw Layer)
-------------------------------------------------------------------
IF OBJECT_ID('dbo.bronze_customer') IS NOT NULL DROP TABLE dbo.bronze_customer;
CREATE TABLE dbo.bronze_customer (
    customer_id INT PRIMARY KEY,
    name NVARCHAR(100),
    email NVARCHAR(100),
    updated_at DATETIME
);

-------------------------------------------------------------------
-- STEP 2: Create Silver Table (SCD2 Layer)
-------------------------------------------------------------------
IF OBJECT_ID('dbo.silver_customer') IS NOT NULL DROP TABLE dbo.silver_customer;
CREATE TABLE dbo.silver_customer (
    surrogate_key INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    name NVARCHAR(100),
    email NVARCHAR(100),
    start_date DATETIME,
    end_date DATETIME,
    is_current BIT
);

-------------------------------------------------------------------
-- STEP 3: Load Sample Bronze Data
-------------------------------------------------------------------
INSERT INTO dbo.bronze_customer (customer_id, name, email, updated_at)
VALUES
(1, 'John Doe', 'john.doe@example.com', GETDATE()),
(2, 'Jane Smith', 'jane.smith@example.com', GETDATE());

-------------------------------------------------------------------
-- STEP 4: Stored Procedure for SCD Type-2 Upsert
-------------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.usp_upsert_customer_scd2
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @current_ts DATETIME = GETDATE();

    BEGIN TRAN;

    ----------------------------------------------------------------
    -- 1️⃣ Close (expire) records in Silver that changed in Bronze
    ----------------------------------------------------------------
    UPDATE s
    SET
        s.end_date = @current_ts,
        s.is_current = 0
    FROM dbo.silver_customer s
    INNER JOIN dbo.bronze_customer b
        ON s.customer_id = b.customer_id
    WHERE s.is_current = 1
      AND (
            ISNULL(s.name,'') <> ISNULL(b.name,'')
         OR ISNULL(s.email,'') <> ISNULL(b.email,'')
      );

    ----------------------------------------------------------------
    -- 2️⃣ Insert new records (new or changed)
    ----------------------------------------------------------------
    INSERT INTO dbo.silver_customer (customer_id, name, email, start_date, end_date, is_current)
    SELECT
        b.customer_id,
        b.name,
        b.email,
        @current_ts AS start_date,
        NULL AS end_date,
        1 AS is_current
    FROM dbo.bronze_customer b
    LEFT JOIN dbo.silver_customer s_cur
        ON b.customer_id = s_cur.customer_id AND s_cur.is_current = 1
    WHERE
        s_cur.customer_id IS NULL
        OR ISNULL(s_cur.name,'') <> ISNULL(b.name,'')
        OR ISNULL(s_cur.email,'') <> ISNULL(b.email,'');

    COMMIT TRAN;
END;
GO

-------------------------------------------------------------------
-- STEP 5: Initial Load
-------------------------------------------------------------------
EXEC dbo.usp_upsert_customer_scd2;

-------------------------------------------------------------------
-- STEP 6: Simulate Update in Bronze
-------------------------------------------------------------------
UPDATE dbo.bronze_customer
SET name = 'SKP - Updated Firsttime',
    updated_at = GETDATE()
WHERE customer_id = 3;

INSERT INTO dbo.bronze_customer (customer_id, name, email, updated_at)
VALUES
(4, 'Sam', 'Sam.doe@example.com', GETDATE())

-------------------------------------------------------------------
-- STEP 7: Re-Run Upsert
-------------------------------------------------------------------
EXEC dbo.usp_upsert_customer_scd2;

-------------------------------------------------------------------
-- STEP 8: View Full SCD2 History
-------------------------------------------------------------------
SELECT * FROM dbo.silver_customer ORDER BY customer_id, start_date;

SELECT * FROM dbo.bronze_customer;
SELECT * FROM dbo.silver_customer;

--Current Record
select * from silver_customer where customer_id = 1 and is_current = 1
--History Record
select * from silver_customer where customer_id = 1 and is_current = 0