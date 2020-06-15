from typing import Dict

import boto3

from src.jobrequest_queue import jobrequest_sqs_base_metrics


def handler(event: Dict, context):
    """
    This handler will put sqs based custom metric.
    
    Args:
        event
        ```sample.json
        {
            "cluster_name": "pj-job-cluster",
            "queue": {
                "jobrequest": {
                    "url": "https://~~~~~",
                    "name": "pj-jobrequest.fifo"
                }
            }
        }
        ```
    """
    print(event)
    print(context)

    cw_client = boto3.client("cloudwatch")
    sqs_client = boto3.client("sqs")
    ecs_client = boto3.client("ecs")
    cluster_name = event["cluster_name"]
    workspace = event["workspace"]
    accept_backlog_per_instance = event["backlog_per_instance"]

    jobrequest_sqs_base_metrics(
          cw_client=cw_client,
        sqs_client=sqs_client,
        ecs_client=ecs_client,
        workspace=workspace,
        cluster_name=cluster_name,
        queue_url=event["queue"]["jobrequest"]["url"],
        queue_name=event["queue"]["jobrequest"]["name"],
        accept_backlog_per_instance=accept_backlog_per_instance,
    )