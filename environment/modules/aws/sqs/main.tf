resource "aws_sqs_queue" "pj-jobrequest-sqs" {
  name                        = "pj-${terraform.workspace}-jobrequest.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  delay_seconds              = var.sqs-params["jobrequest.delay-seconds"]
  max_message_size           = var.sqs-params["jobrequest.max-message-size"]
  message_retention_seconds  = var.sqs-params["jobrequest.message-retention-seconds"]
  receive_wait_time_seconds  = var.sqs-params["jobrequest.receive-wait-time-seconds"]
  visibility_timeout_seconds = var.sqs-params["jobrequest.visibility-timeout-seconds"]

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.pj-jobrequest-sqs-deadletter.arn
    maxReceiveCount     = tonumber(var.sqs-params["jobrequest.max-receive-count"])
  })

  tags = {
    Environment = terraform.workspace
    Workspace   = terraform.workspace
  }
}

resource "aws_sqs_queue" "pj-jobrequest-sqs-deadletter" {
  // queue type should be the same with source queue
  name                        = "pj-${terraform.workspace}-jobrequest-deadletter.fifo"
  fifo_queue                  = true
  content_based_deduplication = true

  delay_seconds              = 0
  max_message_size           = 2048
  message_retention_seconds  = 1209600 // 14days. max value
  receive_wait_time_seconds  = 10
  visibility_timeout_seconds = 5

  tags = {
    Environment = terraform.workspace
    Workspace   = terraform.workspace
  }
}
