from airflow import DAG
from airflow.providers.amazon.aws.operators.ecs import ECSOperator
from airflow.utils.dates import days_ago
from airflow.sensors.base import PokeReturnValue
from airflow.operators.python import PythonSensor
from datetime import timedelta
import socket

default_args = {
    "owner": "data-platform",
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}

def check_kafka():
    try:
        socket.create_connection(("kafka", 9092), timeout=5)
        return True
    except:
        return False

with DAG(
    dag_id="cdc_pipeline_dag",
    default_args=default_args,
    start_date=days_ago(1),
    schedule_interval=None,
    catchup=False,
    tags=["cdc", "iceberg", "production"],
) as dag:

    kafka_sensor = PythonSensor(
        task_id="wait_for_kafka",
        python_callable=check_kafka,
        poke_interval=30,
        timeout=600
    )

    spark_job = ECSOperator(
        task_id="run_spark_cdc_job",
        cluster="cdc-iceberg-cluster",
        task_definition="spark-cdc-task",
        launch_type="FARGATE",
        overrides={
            "containerOverrides": [
                {
                    "name": "spark",
                    "command": [
                        "spark-submit",
                        "/app/kafka_to_iceberg.py"
                    ]
                }
            ]
        },
        network_configuration={
            "awsvpcConfiguration": {
                "subnets": ["subnet-xxxx", "subnet-yyyy"],
                "securityGroups": ["sg-xxxx"],
                "assignPublicIp": "ENABLED"
            }
        },
        aws_conn_id="aws_default"
    )

    kafka_sensor >> spark_job
