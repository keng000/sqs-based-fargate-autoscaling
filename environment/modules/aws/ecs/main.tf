resource "aws_ecs_cluster" "pj-job-cluster" {
  name = "job"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "job"
    Environment = terraform.workspace
  }
}
