# base image
FROM leonardorocha1990/raspberry-pi-64-alpine-jdk11:1.0.0-SNAPSHOT

# define spark and hadoop versions
ENV SPARK_VERSION=3.2.0 \
    HADOOP_VERSION=3.3.1

# download and install hadoop
RUN cd /opt \
    && wget https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar -zxvf ./hadoop-${HADOOP_VERSION}.tar.gz \
    && rm hadoop-${HADOOP_VERSION}.tar.gz \
    && ln -s hadoop-${HADOOP_VERSION} hadoop \
    && echo Hadoop ${HADOOP_VERSION} native libraries installed in /opt/hadoop/lib/native \
    && wget http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz \
    && tar -xzvf spark-${SPARK_VERSION}-bin-hadoop2.7.tgz \
    && rm spark-${SPARK_VERSION}-bin-hadoop2.7.tgz \
    && ln -s spark-${SPARK_VERSION}-bin-hadoop2.7 spark

# add scripts and update spark default config
ADD ./docker/common.sh ./docker/spark-master ./docker/spark-worker /
ADD ./docker/spark-defaults.conf /opt/spark/conf/spark-defaults.conf
ENV PATH $PATH:/opt/spark/bin