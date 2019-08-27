#!/bin/bash
/etc/init.d/ssh start

# Prepare Postgres for Hive Metastore
su postgres -c '/usr/lib/postgresql/10/bin/pg_ctl -D /var/lib/postgresql/10/main2 start'
sleep 2
psql -U postgres -c "CREATE USER hiveuser WITH PASSWORD 'hiveuser';"
psql -U postgres -c "CREATE DATABASE metastore;"
/root/apache-hive-2.3.6-bin/bin/schematool -dbType postgres -initSchema

# Start HDFS
/root/hadoop-2.9.2/sbin/start-all.sh

# Start Metastore
/root/apache-hive-2.3.6-bin/bin/hive --service metastore

# Keep running
tail -f /dev/null
