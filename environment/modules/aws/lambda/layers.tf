# Archive
data "archive_file" "layers-awscli" {
  type        = "zip"
  source_dir  = "${path.module}/functions/sqs-custom-metrics-per-minute/build/layer"
  output_path = "${path.module}/zip/layers/awscil.zip"
}

# Layer
resource "aws_lambda_layer_version" "awscli" {
  layer_name       = "pj-${terraform.workspace}-awscli"
  filename         = data.archive_file.layers-awscli.output_path
  source_code_hash = data.archive_file.layers-awscli.output_base64sha256
}
