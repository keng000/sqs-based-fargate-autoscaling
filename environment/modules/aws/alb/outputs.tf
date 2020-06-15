output "pj-job-tg" {
  value = aws_alb_target_group.job
}

output "pj-alb" {
  value = aws_alb.pj
}
