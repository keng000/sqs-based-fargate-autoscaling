# Env

```
Terraform version >= 0.12.19
```

# Regions

- ap-northeast-1: production
- ap-southeast-1: staging
- ap-northeast-2: development

# Before Deploy


1. Build Lambda Function


```
$ make build-lambda
```

# Deploy

## development

```
$ terraform init
$ terraform select workspace development
$ terraform plan
$ terraform apply
```

## staging

```
$ terraform init
$ terraform select workspace staging
$ terraform plan
$ terraform apply
```

## production

```
$ terraform init
$ terraform select workspace production
$ terraform plan
$ terraform apply
```

# Update Lambda

```
python >= 3.7.x
```

```
$ make build-lambda
```
