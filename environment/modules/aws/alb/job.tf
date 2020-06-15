resource "aws_alb_target_group" "job" {
  name                 = "pj-job-tg"
  port                 = 8000
  protocol             = "HTTP"
  vpc_id               = var.vpc-vpc-pj-id
  target_type          = "ip"
  deregistration_delay = var.load-balancer-rule["job.deregistration-delay"]

  health_check {
    interval            = var.load-balancer-rule["job.health-check-interval"]
    path                = "/health"
    port                = 8000
    protocol            = "HTTP"
    timeout             = var.load-balancer-rule["job.health-check-timeout"]
    healthy_threshold   = var.load-balancer-rule["job.healthy-threshold"]
    unhealthy_threshold = var.load-balancer-rule["job.unhealthy-threshold"]
    matcher             = 200
  }
}

resource "aws_alb_listener" "pj-job-http" {
  load_balancer_arn = aws_alb.pj.arn
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.job.arn
  }
}

## Auto Scaling
resource "aws_appautoscaling_target" "autoscale-job" {
  count = var.load-balancer-rule["job.enable_autoscale"] ? 1 : 0

  service_namespace  = "ecs"
  resource_id        = "service/${var.ecs-pj-cluster.name}/job"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = var.iam-ecs-service-autoscaling.arn
  min_capacity       = var.load-balancer-rule["job.min-capacity"]
  max_capacity       = var.load-balancer-rule["job.max-capacity"]
}

resource "aws_appautoscaling_policy" "job-scale" {
  count = var.load-balancer-rule["job.enable_autoscale"] ? 1 : 0

  name               = "job-scale"
  service_namespace  = aws_appautoscaling_target.autoscale-job[count.index].service_namespace
  resource_id        = aws_appautoscaling_target.autoscale-job[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.autoscale-job[count.index].scalable_dimension
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    scale_in_cooldown  = var.load-balancer-rule["job.scale-in-cooldown"]
    scale_out_cooldown = var.load-balancer-rule["job.scale-out-cooldown"]
    target_value       = var.load-balancer-rule["job.backlog-per-instance"]

    customized_metric_specification {
      dimensions {
        name  = "Service"
        value = "job"
      }

      metric_name = "BacklogPerInstance"
      namespace   = "Custom/${workspace}/SQS-Based-Metrics"
      statistic   = "Average"
    }
  }
}
