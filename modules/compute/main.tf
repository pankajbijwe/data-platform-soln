resource "aws_ecs_cluster" "main" {
  name = "data-processing-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "data-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn
  container_definitions    = file("${path.module}/container_definitions.json")
}