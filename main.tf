terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.27"
        }
    }
}
provider "aws" {
  region = "ap-south-1
  shared_credentials_file = "C:\\Users\\pankaj\\.aws\\credentials"
}
resource "aws_iam_user" "new_user" {
  name = "Terraform-user"
}

resource "aws_iam_user_policy" "iam" {
  name = "ListAllBuckets"
  user = aws_iam_user.new_user.name
  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOT
}


resource "aws_iam_access_key" "AccK" {
  user = aws_iam_user.new_user.name
}
output "secret_key" {
  value = aws_iam_access_key.AccK.secret
  sensitive = true

}

output "access_key" {
  value = aws_iam_access_key.AccK.id
}


