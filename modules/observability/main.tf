resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/data-processing"
  retention_in_days = 30
}

resource "aws_cloudtrail" "main" {
  name                          = "data-trail"
  s3_bucket_name                = aws_s3_bucket.raw_data.id
  include_global_service_events = true
  is_multi_region_trail         = true
}