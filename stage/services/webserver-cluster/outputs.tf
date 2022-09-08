# output variable for the public ip address
output "alb_dns_name" {
  value = aws_lb.oneinfra.dns_name
  description = "The domain name of the load balancer"
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