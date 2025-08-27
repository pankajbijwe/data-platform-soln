variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "env" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "execution_role_arn" {
  description = "IAM role ARN for ECS task execution"
  type        = string
}

variable "container_image" {
  description = "Docker image for ECS task"
  type        = string
  default     = "your-ecr-repo/data-processor:latest"
}

variable "db_credentials_secret_name" {
  description = "Secrets Manager name for DB credentials"
  type        = string
  default     = "db-credentials"
}

variable "autoscaling_min_capacity" {
  default = 10
}
variable "autoscaling_max_capacity" {
  default = 100
}
variable "dynamodb_table_name" {
  default = "prod-high-tps-table"
}
variable "kinesis_stream_name" {
  default = "prod-data-stream"
}
