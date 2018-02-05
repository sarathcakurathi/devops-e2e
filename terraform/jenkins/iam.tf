resource "aws_iam_instance_profile" "w6-profile" {
  name = "devops_profile"
  role = "${aws_iam_role.w6-role.name}"
}

resource "aws_iam_role" "w6-role" {
  name = "devops_role"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
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

resource "aws_iam_role_policy" "s3-policy" {
  name = "aws-full-access"
  role = "${aws_iam_role.w6-role.id}"
  policy = <<EOF
{
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "*"
    ],
    "Resource": "*"
  }]
}
EOF
}
