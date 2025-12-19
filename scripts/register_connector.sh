#!/bin/bash

CONNECT_URL=http://localhost:8083/connectors

curl -X POST \
  -H "Content-Type: application/json" \
  --data @debezium/postgres-cdc-connector.json \
  $CONNECT_URL
