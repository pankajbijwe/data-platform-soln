output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.network.public_subnets
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.compute.ecs_cluster_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for raw data"
  value       = module.storage.raw_data_bucket
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for high TPS"
  value       = module.storage.dynamodb_table_name
}

output "kms_key_id" {
  description = "KMS key ID used for encryption"
  value       = module.security.kms_key_id
}

output "cloudwatch_log_group" {
  description = "CloudWatch log group for ECS tasks"
  value       = module.observability.ecs_log_group
}