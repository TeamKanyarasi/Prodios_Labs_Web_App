# Create S3 bucket for storing uploaded files
resource "aws_s3_bucket" "prodioslabsbucket" {
  bucket = "my-tf-example-bucket"

    tags = {
    Name = "App Uploaded Files"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.prodioslabsbucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "pl-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.prodioslabsbucket.id
  acl    = "private"
}

# IAM role for EC2 instance with access to S3 bucket
resource "aws_iam_role" "ec2_role" {
  name = "app-ec2-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.ec2_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}