resource "aws_s3_bucket" "state" {
  bucket = "${data.aws_caller_identity.caller.account_id}.terraform"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "locking" {
  name         = "${data.aws_caller_identity.caller.account_id}.terraform"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${data.aws_caller_identity.caller.account_id}.terraform"
  }
}
