output "ec2_role" {
  value = aws_iam_role.ec2_role.name
}

output "bucket_domain_name" {
  value = aws_s3_bucket.prodioslabsbucket.bucket_domain_name
}