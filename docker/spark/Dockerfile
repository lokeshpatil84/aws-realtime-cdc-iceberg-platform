FROM bitnami/spark:3.5

USER root

RUN pip install pyspark==3.5.0

ENV SPARK_HOME=/opt/bitnami/spark

CMD ["spark-submit", "/app/kafka_to_iceberg.py"]
