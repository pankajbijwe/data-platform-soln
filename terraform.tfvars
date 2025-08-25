# terraform.tfvars — Production Environment Configuration

aws_region               = "ap-south-1"
env                      = "prod"
cidr_block               = "10.0.0.0/16"
execution_role_arn       = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
container_image          = "123456789012.dkr.ecr.ap-south-1.amazonaws.com/data-processor:prod"
db_credentials_secret_name = "prod-db-credentials"

# Optional: Add these if you're using extended modules
raw_data_bucket_name     = "enterprise-prod-raw-data"
dynamodb_table_name      = "prod-high-tps-table"
kms_key_alias            = "alias/prod-data-key"
log_retention_days       = 30
autoscaling_min_capacity = 2
autoscaling_max_capacity = 10