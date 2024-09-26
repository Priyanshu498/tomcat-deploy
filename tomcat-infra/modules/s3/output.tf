output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

output "bucket_versioning_status" {
  value = aws_s3_bucket_versioning.bucket_versioning.versioning_configuration[0].status
}
