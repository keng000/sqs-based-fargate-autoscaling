variable "ecs-pj-cluster" {}

variable "iam-ecs-service-autoscaling" {}

variable "sg-pj-alb-id" {}

variable "vpc-vpc-pj-id" {}
variable "vpc-subnet-pj-public-a-id" {}
variable "vpc-subnet-pj-public-c-id" {}

variable "load-balancer-rule" {
  type = map(string)
  default = {
    "job.enable_autoscale"      = true
    "job.health-check-interval" = 20
    "job.health-check-timeout"  = 19
    "job.healthy-threshold"     = 2
    "job.unhealthy-threshold"   = 2
    "job.min-capacity"          = 1
    "job.max-capacity"          = 10
    "job.scale-out-cooldown"    = 300
    "job.scale-in-cooldown"     = 300
    "job.deregistration-delay"  = 15
    "job.backlog-per-instance"  = 30
  }
}

