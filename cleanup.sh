#!/bin/bash

S3_BUCKET_NAME="twotier-s3-backend"
DB_TABLE_NAME="twotier-db-backend"

terraform destroy -auto-approve

# empty bucket
aws s3 rb s3://$S3_BUCKET_NAME \
    --force

aws dynamodb delete-table \
    --table-name $DB_TABLE_NAME