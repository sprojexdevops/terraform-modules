locals {
  resource_name = "${var.project_name}-${var.environment}-bastion"
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
  bastion_sg_id = data.aws_security_group.bastion_sg_id.id
}