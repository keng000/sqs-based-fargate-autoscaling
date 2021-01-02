variable "region" {
  type = map(string)
  default = {
    "development" = "ap-northeast-2"
    "production"  = "ap-northeast-1"
    "staging"     = "ap-southeast-1"
  }
}

variable "availability-zone" {
  type = map(string)
  default = {
    "development.a" = "ap-northeast-2a"
    "development.c" = "ap-northeast-2c"

    "production.a" = "ap-northeast-1a"
    "production.c" = "ap-northeast-1c"

    "staging.a" = "ap-southeast-1a"
    "staging.c" = "ap-southeast-1c"
  }
}

variable "sqs-params" {
  type = map(string)
  default = {
    "jobrequest.max-receive-count"          = 10
    "jobrequest.delay-seconds"              = 0
    "jobrequest.max-message-size"           = 2048
    "jobrequest.receive-wait-time-seconds"  = 20
    "jobrequest.visibility-timeout-seconds" = 90
    "jobrequest.message-retention-seconds"  = 1209600
  }
}

variable "load-balancer-rule" {
  type = map(string)
  default = {
    // sqs message count based autoscaling
    "job.enable-autoscale"      = true
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
