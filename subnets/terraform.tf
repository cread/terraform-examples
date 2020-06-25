/*
# Use this if you're storing state in S3

terraform {
  backend "s3" {
    dynamodb_table = "${data.aws_caller_identity.caller.account_id}.terraform"
    bucket         = "${data.aws_caller_identity.caller.account_id}.terraform"
    key            = "<repo>/<region>/ec2-spot-autoscale.tfstate"
    region         = "us-east-2"
  }
}
*/
