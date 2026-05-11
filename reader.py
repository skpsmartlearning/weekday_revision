def read_data(spark, config):
    reader = spark.read.format(config["file_type"])

    for k, v in config.get("options", {}).items():
        reader = reader.option(k, v)

    df = reader.load(config["path"])

    return df