## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |
| aws | ~> 2.5 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability-zone | n/a | `map(string)` | <pre>{<br>  "development.a": "ap-northeast-2a",<br>  "development.c": "ap-northeast-2c",<br>  "production.a": "ap-northeast-1a",<br>  "production.c": "ap-northeast-1c",<br>  "staging.a": "ap-southeast-1a",<br>  "staging.c": "ap-southeast-1c"<br>}</pre> | no |
| load-balancer-rule | n/a | `map(string)` | <pre>{<br>  "job.backlog-per-instance": 30,<br>  "job.deregistration-delay": 15,<br>  "job.enable-autoscale": true,<br>  "job.health-check-interval": 20,<br>  "job.health-check-timeout": 19,<br>  "job.healthy-threshold": 2,<br>  "job.max-capacity": 10,<br>  "job.min-capacity": 1,<br>  "job.scale-in-cooldown": 300,<br>  "job.scale-out-cooldown": 300,<br>  "job.unhealthy-threshold": 2<br>}</pre> | no |
| region | n/a | `map(string)` | <pre>{<br>  "development": "ap-northeast-2",<br>  "production": "ap-northeast-1",<br>  "staging": "ap-southeast-1"<br>}</pre> | no |
| sqs-params | n/a | `map(string)` | <pre>{<br>  "jobrequest.delay-seconds": 0,<br>  "jobrequest.max-message-size": 2048,<br>  "jobrequest.max-receive-count": 10,<br>  "jobrequest.message-retention-seconds": 1209600,<br>  "jobrequest.receive-wait-time-seconds": 20,<br>  "jobrequest.visibility-timeout-seconds": 90<br>}</pre> | no |

## Outputs

No output.

