import math
from typing import Dict

from src.utils import get_container_count, get_message_count, put_custom_metrics_helper


def jobrequest_sqs_base_metrics(
    cw_client,
    sqs_client,
    ecs_client,
    workspace: str,
    cluster_name: str,
    queue_url: str,
    queue_name: str,
    accept_backlog_per_instance: Dict[str, str],
):
    message_count = get_message_count(sqs_client, queue_url)
    print(f"{queue_name} Message Count: {message_count}")

    put_jobrequest_scaling_metrics(
        cw_client=cw_client,
        sqs_client=sqs_client,
        ecs_client=ecs_client,
        workspace=workspace,
        cluster_name=cluster_name,
        queue_name=queue_name,
        message_count=message_count,
        accept_backlog_per_instance=accept_backlog_per_instance,
    )


def put_jobrequest_scaling_metrics(
    cw_client,
    sqs_client,
    ecs_client,
    workspace: str,
    cluster_name: str,
    queue_name: str,
    message_count: int,
    accept_backlog_per_instance: Dict[str, str],
):
    service_name = "job"
    container_count = get_container_count(ecs_client, cluster_name, service_name)

    try:
        # container_count wount be zero due to minimum capacity
        backlog_per_instance = math.ceil(message_count / container_count)
    except ZeroDivisionError:
        backlog_per_instance = message_count

    put_custom_metrics_helper(
        cw_client=cw_client,
        workspace=workspace,
        queue_name=queue_name,
        service_name=service_name,
        message_count=message_count,
        backlog_per_instance=backlog_per_instance,
    )
