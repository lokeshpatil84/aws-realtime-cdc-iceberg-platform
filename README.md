# AWS Real-Time CDC Iceberg Platform

This project implements a full production-grade real-time data platform on AWS using:
- PostgreSQL (RDS)
- Kafka + Debezium (CDC)
- PySpark
- Apache Iceberg
- AWS S3 + Glue Catalog
- Apache Airflow
- AWS ECS (Fargate)
- Terraform
- GitHub Actions

## Architecture
PostgreSQL → Debezium → Kafka → PySpark → Iceberg (S3) → Glue → Athena

## Prerequisites
- AWS Account (Admin access)
- Terraform >= 1.5
- Docker
- GitHub Account
- AWS CLI configured

## Step-by-Step Run

### 1. Clone Repo
```bash
git clone <your-repo>
cd aws-realtime-cdc-iceberg-platform
