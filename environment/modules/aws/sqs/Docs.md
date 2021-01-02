## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| sqs-params | n/a | `map(string)` | <pre>{<br>  "jobrequest.delay-seconds": 0,<br>  "jobrequest.max-message-size": 2048,<br>  "jobrequest.max-receive-count": 10,<br>  "jobrequest.message-retention-seconds": 1209600,<br>  "jobrequest.receive-wait-time-seconds": 10,<br>  "jobrequest.visibility-timeout-seconds": 30<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| pj-jobrequest | n/a |

