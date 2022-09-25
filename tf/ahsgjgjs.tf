terraform {
  required_providers {
    port-labs = {
      source  = "port-labs/port-labs"
      version = "~> 0.4.0"
    }
  }
}
provider "port-labs" {}

provider "aws" {
  alias  = "bucket_region"
  region = "eu-west-1"
}

resource "aws_s3_bucket" "example" {
  provider = aws.bucket_region
  bucket   = "ahsgjgjs"
}

resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"
}

resource "port-labs_entity" "bucket_port_entity" {
  identifier = "ahsgjgjs"
  title      = "ahsgjgjs"
  blueprint  = "S3Bucket"
  properties {
    name  = "acl"
    value = "private"
  }
  properties {
    name  = "awsRegion"
    value = "eu-west-1"
  }
  properties {
    name  = "createdDate"
    value = timestamp()
  }
  properties {
    name  = "S3Link"
    value = "https://s3.console.aws.amazon.com/s3/buckets/ahsgjgjs"
  }
  depends_on = [aws_s3_bucket.example, aws_s3_bucket_acl.example_bucket_acl]
}