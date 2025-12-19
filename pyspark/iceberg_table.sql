CREATE TABLE IF NOT EXISTS iceberg_db.orders_iceberg (
    order_id INT,
    customer_name STRING,
    product STRING,
    amount DECIMAL(10,2),
    created_at TIMESTAMP
)
USING iceberg
PARTITIONED BY (days(created_at))
LOCATION 's3://cdc-iceberg-data-bucket/iceberg/orders/';
