resource "aws_s3_bucket" "raw_data" {
  bucket = "data-raw-${var.env}"
  lifecycle_rule {
    enabled = true
    expiration {
      days = 30
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "high_tps" {
  name           = "transactions"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "txn_id"
  attribute {
    name = "txn_id"
    type = "S"
  }
}