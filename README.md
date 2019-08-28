# How to run

For connection to regular Hive:

```bash
docker run -d --name presto-with-hadoop yongjoopark/presto-with-hadoop
```

For additional connection to S3:

```bash
docker run -d --name presto-with-hadoop \
-e AWS_ACCESS_KEY_ID={YourAccessKey} \
-e AWS_SECRET_ACCESS_KEY={YourSecretAccessKey} \
yongjoopark/presto-with-hadoop
```


# Versions

Presto: 318
Hadoop: hadoop-2.9.2
PostgreSQL (for Hive Metastore): 10
