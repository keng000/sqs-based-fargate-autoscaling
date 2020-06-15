from datetime import datetime
from typing import Union

import dateutil


def put_custom_metrics_helper(
    cw_client, workspace: str, queue_name: str, service_name: str, message_count: int, backlog_per_instance: int
):
    namespace = f"Custom/{workspace}/SQS-Based-Metrics"
    put_custom_metrics(
        cw_client,
        dimension_name="Service",
        dimension_value=f"{service_name}",
        metric_name="ApproximateNumberOfMessages",
        metric_value=int(message_count),
        namespace=namespace,
    )
    put_custom_metrics(
        cw_client,
        dimension_name="Service",
        dimension_value=f"{service_name}",
        metric_name="BacklogPerInstance",
        metric_value=backlog_per_instance,
        namespace=namespace,
    )


def put_custom_metrics(
    cw_client,
    dimension_name: str,
    dimension_value: str,
    metric_name: str,
    metric_value: Union[int, float],
    namespace: str,
):
    cw_client.put_metric_data(
        Namespace=namespace,
        MetricData=[
            {
                "MetricName": metric_name,
                "Dimensions": [{"Name": dimension_name, "Value": dimension_value}],
                "Timestamp": datetime.now(dateutil.tz.tzlocal()),
                "Value": metric_value,
            }
        ],
    )


def get_container_count(ecs_client, cluster_name: str, service_name: str) -> int:
    try:
        ret = ecs_client.describe_services(cluster=cluster_name, services=[service_name])
    except Exception as e:
        raise Exception(
            f"faild get_container_count cluster_name=`{cluster_name}`, service_name=`{service_name}`"
        ) from e
    return int(ret["services"][0]["runningCount"])


def get_message_count(sqs_client, queue_url: str) -> int:
    try:
        ret = sqs_client.get_queue_attributes(
            QueueUrl=queue_url, AttributeNames=["ApproximateNumberOfMessages", "ApproximateNumberOfMessagesNotVisible"]
        )
    except Exception as e:
        raise Exception(f"failed get_message_count queue_url=`{queue_url}`") from e
    visible = int(ret["Attributes"]["ApproximateNumberOfMessages"])
    not_visible = int(ret["Attributes"]["ApproximateNumberOfMessagesNotVisible"])
    return visible + not_visible
