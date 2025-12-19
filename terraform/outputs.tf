output "s3_bucket" {
  value = aws_s3_bucket.data.bucket
}

output "postgres_endpoint" {
  value = aws_db_instance.postgres.endpoint
}


output "alb_dns_name" {
  value = aws_lb.main.dns_name
}