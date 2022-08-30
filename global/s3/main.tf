terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "filling_status" {
  bucket = "amfilling"

    lifecycle {
        create_before_destroy = true
    }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.filling_status.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "gap_locks" {
  name             = "filling-up-locks"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"
  #stream_enabled = true

  attribute {
    name = "LockID"
    type = "S"
  }

}

terraform {
    backend "s3" {
    key = "global/s3/terraform.tfstate"
    }
}

# prints out the Amazon resource name of the S3 bucket

output "s3_bucket_arn" {
  value = aws_s3_bucket.filling_status.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.gap_locks.name
    description = "The name of the DynamoDB table" 
}