variable "sqs-params" {
  type = map(string)
  default = {
    "jobrequest.max-receive-count"          = 10
    "jobrequest.delay-seconds"              = 0
    "jobrequest.max-message-size"           = 2048
    "jobrequest.receive-wait-time-seconds"  = 10
    "jobrequest.visibility-timeout-seconds" = 30
    "jobrequest.message-retention-seconds"  = 1209600
  }
}
