
# SQS based AWS Fargate Autoscaling

This repository defines terraform scripts and aws fargate task definition.  
This repository just define the minimum resources, so to deploy into the production, you will need to add some resources.

# Description

This is an implementation of **Scaling Based on Amazon SQS Message Count** in the document below.

It checks the SQS Message count every minute, then increase the computation (Fargate in this repo) with autoscaling

[Scaling Based on Amazon SQS - AWS Documentation](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-using-sqs-queue.html)


# Setup 

- [Terraform](environment/README.md)
- [Fargate](fargate/README.md)

# Diagram

<img src="docs/SQSBasedAutoscaling.png" width=500>