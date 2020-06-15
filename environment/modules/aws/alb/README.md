## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ecs-pj-cluster | n/a | `any` | n/a | yes |
| iam-ecs-service-autoscaling | n/a | `any` | n/a | yes |
| load-balancer-rule | n/a | `map(string)` | <pre>{<br>  "job.backlog-per-instance": 30,<br>  "job.deregistration-delay": 15,<br>  "job.enable_autoscale": true,<br>  "job.health-check-interval": 20,<br>  "job.health-check-timeout": 19,<br>  "job.healthy-threshold": 2,<br>  "job.max-capacity": 10,<br>  "job.min-capacity": 1,<br>  "job.scale-in-cooldown": 300,<br>  "job.scale-out-cooldown": 300,<br>  "job.unhealthy-threshold": 2<br>}</pre> | no |
| sg-pj-alb-id | n/a | `any` | n/a | yes |
| vpc-subnet-pj-public-a-id | n/a | `any` | n/a | yes |
| vpc-subnet-pj-public-c-id | n/a | `any` | n/a | yes |
| vpc-vpc-pj-id | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| pj-alb | n/a |
| pj-job-tg | n/a |

