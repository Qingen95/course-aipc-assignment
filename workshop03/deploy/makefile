include .env
export

tf_init:
	@export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
	@export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
	@terraform init -backend-config="bucket=${TFSTATE_BUCKET}"

tf_apply:
	@terraform apply --auto-approve