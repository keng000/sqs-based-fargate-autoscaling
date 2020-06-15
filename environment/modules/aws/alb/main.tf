resource "aws_alb" "pj" {
  name            = "pj-fargate-alb"
  security_groups = [var.sg-pj-alb-id]

  subnets = [
    var.vpc-subnet-pj-public-a-id,
    var.vpc-subnet-pj-public-c-id,
  ]

  internal                   = false
  enable_deletion_protection = false

  tags = {
    Environment = terraform.workspace
  }
}

