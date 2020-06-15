
# ecs-cli setup
## install deploy tool
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI_installation.html

MacOS installation
```
$ sudo curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-darwin-amd64-latest
$ sudo chmod +x /usr/local/bin/ecs-cli
$ ecs-cli --version
```

## register projects
```
$ ecs-cli configure \
    --cluster job \
    --default-launch-type FARGATE \
    --region ap-northeast-2 \
    --config-name pj-dev

$ ecs-cli configure \
    --cluster job \
    --default-launch-type FARGATE \
    --region ap-southeast-1 \
    --config-name pj-stg

$ ecs-cli configure \
    --cluster job \
    --default-launch-type FARGATE \
    --region ap-northeast-1 \
    --config-name pj-prod
```
