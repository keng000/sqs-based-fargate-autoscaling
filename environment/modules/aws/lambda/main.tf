# Archive
data "archive_file" "function-sqs-custom-metrics-per-minute" {
  type        = "zip"
  source_dir  = "${path.module}/functions/sqs-custom-metrics-per-minute/build/function"
  output_path = "${path.module}/zip/functions/sqs-custom-metrics-per-minute.zip"
}

# Function
resource "aws_lambda_function" "sqs-custom-metrics-per-minute" {
  function_name = "pj-${terraform.workspace}-sqs-custom-metrics-per-minute"

  handler          = "src/function.handler"
  filename         = data.archive_file.function-sqs-custom-metrics-per-minute.output_path
  runtime          = "python3.7"
  timeout          = 15
  role             = var.iam-sqs-custom-metrics-per-minute-role.arn
  source_code_hash = data.archive_file.function-sqs-custom-metrics-per-minute.output_base64sha256
  layers           = [aws_lambda_layer_version.awscli.arn]
}


resource "aws_lambda_permission" "sqs-custom-metrics-per-minute-attributes-permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sqs-custom-metrics-per-minute.function_name
  principal     = "events.amazonaws.com"
  statement_id  = aws_cloudwatch_event_rule.sqs-custom-metrics-per-minute-attributes-rule.name
  source_arn    = aws_cloudwatch_event_rule.sqs-custom-metrics-per-minute-attributes-rule.arn
}

resource "aws_cloudwatch_event_rule" "sqs-custom-metrics-per-minute-attributes-rule" {
  name                = "pj-${terraform.workspace}-sqs-custom-metrics-per-minute-rule"
  description         = "pj-${terraform.workspace}-sqs-custom-metrics-per-minute-rule triggers lambda in every minute"
  schedule_expression = "cron(* * * * ? *)"
}

resource "aws_cloudwatch_event_target" "sqs-custom-metrics-per-minute-event-target" {
  rule  = aws_cloudwatch_event_rule.sqs-custom-metrics-per-minute-attributes-rule.name
  arn   = aws_lambda_function.sqs-custom-metrics-per-minute.arn
  input = <<INPUT
{
  "cluster_name": "${var.ecs-pj-job-cluster.name}",
  "workspace": "${terraform.workspace}",
  "queue": {
    "jobrequest": {
      "url": "${var.sqs-pj-jobrequest.id}",
      "name": "${var.sqs-pj-jobrequest.name}"
    }
  },
  "backlog_per_instance": ${jsonencode(var.autoscaling-pj-backlog-per-instance)}
}
INPUT
}
