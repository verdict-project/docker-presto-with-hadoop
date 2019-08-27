FROM ubuntu:18.04

RUN apt update
RUN apt install -y openjdk-8-jre
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Setup Hadoop
COPY hadoop/hadoop-2.9.2.tar.gz /root/hadoop-2.9.2.tar.gz
RUN tar xzf /root/hadoop-2.9.2.tar.gz -C /root
RUN mkdir /root/hadoop-2.9.2/dfs
COPY hadoop/hadoop-env.sh /root/hadoop-2.9.2/etc/hadoop/hadoop-env.sh
COPY hadoop/core-site.xml /root/hadoop-2.9.2/etc/hadoop/core-site.xml
COPY hadoop/hdfs-site.xml /root/hadoop-2.9.2/etc/hadoop/hdfs-site.xml

## ssh without password
RUN ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN chmod 0600 /root/.ssh/authorized_keys

RUN /root/hadoop-2.9.2/bin/hdfs namenode -format

ENV HADOOP_HOME /root/hadoop-2.9.2


# Setup Hive
COPY hive/apache-hive-2.3.6-bin.tar.gz /root/apache-hive-2.3.6-bin.tar.gz
RUN tar xzf /root/apache-hive-2.3.6-bin.tar.gz -C /root
COPY hive/postgresql-42.2.6.jar /root/apache-hive-2.3.6-bin/lib/postgresql-42.2.6.jar

## Postgres
RUN DEBIAN_FRONTEND=noninteractive apt install -y postgresql postgresql-contrib
USER postgres
RUN /usr/lib/postgresql/10/bin/initdb -D /var/lib/postgresql/10/main2 --auth-local peer --auth-host md5
RUN /usr/lib/postgresql/10/bin/pg_ctl -D /var/lib/postgresql/10/main2 start & sleep 1
RUN psql -U postgres -c "CREATE USER hiveuser WITH PASSWORD 'hiveuser';"
RUN psql -U postgres -c "CREATE DATABASE metastore;"


# Setup Presto
COPY presto/presto-server-317.tar.gz /root/presto-server-317.tar


# Copy setup script
COPY start_services.sh /root/start_services.sh
RUN chown root:root /root/start_services.sh
RUN chmod 700 /root/start_services.sh

# Start services
CMD ['/root/start_services.sh']

EXPOSE 8080
