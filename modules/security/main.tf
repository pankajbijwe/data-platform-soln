resource "aws_kms_key" "data_key" {
  description = "KMS key for data encryption"
  enable_key_rotation = true
}

resource "aws_secretsmanager_secret" "db_creds" {
  name = "db-credentials"
}