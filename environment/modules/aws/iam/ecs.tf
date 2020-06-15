resource "aws_iam_role" "pj-task-exec-role" {
  name = "pj-${terraform.workspace}-task-exec-role"
  path = "/system/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "1",
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "pj-task-exec-policy" {
  name = "pj-${terraform.workspace}-task-exec-policy"
  role = aws_iam_role.pj-task-exec-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents",

        "ssm:GetParameters",
        "secretsmanager:GetSecretValue",
        "kms:Decrypt",

        "s3:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
