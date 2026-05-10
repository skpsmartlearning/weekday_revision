from ingestion_framework.utils.reader import read_data
from ingestion_framework.utils.validator import validate_schema
from ingestion_framework.utils.transformer import transform_data
from ingestion_framework.utils.writer import write_data


def run_pipeline(spark, config):

    # Ensure correct context
    spark.sql("USE CATALOG workspace")
    spark.sql("USE SCHEMA default")

    # Step 1: Read
    df = read_data(spark, config)
    print(" Data Loaded")
    df.show()

    # Step 2: Validate
    is_valid, missing = validate_schema(df, config["expected_columns"])
    if not is_valid:
        raise Exception(f" Missing columns: {missing}")

    print(" Schema Valid")

    # Step 3: Transform
    df = transform_data(df)
    print(" Transformation Done")
    df.show()

    # Step 4: Write
    write_data(df, config)
    print("Data Written to Table:", config["target_table"])