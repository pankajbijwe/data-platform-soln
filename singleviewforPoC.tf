terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# -------------------------------
# VPC and Networking
# -------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.env}-public-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}

# -------------------------------
# ECS Cluster and Task Definition
# -------------------------------
resource "aws_ecs_cluster" "main" {
  name = "${var.env}-ecs-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.env}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.container_image
      essential = true
      environment = [
        {
          name  = "ENV"
          value = var.env
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.env}-logs"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "${var.env}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    subnets         = aws_subnet.public[*].id
    assign_public_ip = true
    security_groups = [aws_security_group.ecs.id]
  }

  depends_on = [aws_ecs_task_definition.app]
}

# -------------------------------
# Security Group
# -------------------------------
resource "aws_security_group" "ecs" {
  name        = "${var.env}-ecs-sg"
  description = "Allow HTTP and HTTPS"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -------------------------------
# Variables
# -------------------------------
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "cidr_block" {
  description = "CIDR block for VPC"
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
}

variable "db_credentials_secret_name" {
  description = "Secrets Manager name for DB credentials"
  type        = string
}

# -------------------------------
# Outputs
# -------------------------------
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the created VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "List of public subnet IDs"
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "Name of the ECS cluster"
}

output "ecs_service_name" {
  value       = aws_ecs_service.app.name
  description = "Name of the ECS service"
}