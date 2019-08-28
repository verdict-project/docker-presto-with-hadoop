This image offers Presto with other necessary components in a single image. This image is only
useful for quick tests since the metadata (e.g., schemas, tables) will be gone when the container is
removed.


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


# More memeory for Presto?

Provide the following environment variables. The startup script picks those variables and set
configuration files accordingly.

```bash
docker run -d --name presto-with-hadoop \
-e AWS_ACCESS_KEY_ID={YourAccessKey} \
-e AWS_SECRET_ACCESS_KEY={YourSecretAccessKey} \
-e QUERY_MAX_MEMORY='50GB' \
-e QUERY_MAX_MEMORY_PER_NODE='40GB' \
-e QUERY_MAX_TOTAL_MEMORY_PER_NODE='40GB' \
-e JAVA_HEAP_SIZE='60G'
yongjoopark/presto-with-hadoop
```


# Versions

- Hadoop: hadoop-2.9.2
- PostgreSQL (for Hive Metastore): 10
- Hive: 2.3.6
- Presto: 318

Presto is only compatible with Hadoop2 (not Hadoop3).
