terraform {
  backend "s3" {
    dynamodb_table = "${data.aws_caller_identity.caller.account_id}.terraform"
    bucket         = "${data.aws_caller_identity.caller.account_id}.terraform"
    key            = "<repo>/<region>/<system>.tfstate"
    region         = "us-east-2"
  }
}
