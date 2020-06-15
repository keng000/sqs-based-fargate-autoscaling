ecs-cli compose \
	--cluster-config pj-prod \
	--project-name job \
	--file docker-compose.yml \
	--ecs-params ecs-params.yml \
	service up \
		--target-group-arn "" \
		--container-name job \
		--container-port 8000 \
		--force-deployment \
		--health-check-grace-period 40 \
		--timeout 20 \
		--create-log-groups

