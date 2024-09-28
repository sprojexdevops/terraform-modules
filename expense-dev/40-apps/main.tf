# source --> terraform open source modules in github (no URL required for these)

module "mysql" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami  = data.aws_ami.ami.id
  name = "${local.resource_name}-mysql"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    var.mysql_tags,
    {
      Name = "${local.resource_name}-mysql"
    }
  )
}

module "backend" {
  count  = ["backend", "backend-2"]
  source = "terraform-aws-modules/ec2-instance/aws"

  ami  = data.aws_ami.ami.id
  name = "${local.resource_name}-${[count.index]}"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.backend_sg_id]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    var.mysql_tags,
    {
      Name = "${local.resource_name}-${[count.index]}"
    }
  )
}

module "frontend" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami  = data.aws_ami.ami.id
  name = "${local.resource_name}-frontend"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.frontend_sg_id]
  subnet_id              = local.public_subnet_id

  tags = merge(
    var.common_tags,
    var.mysql_tags,
    {
      Name = "${local.resource_name}-forntend"
    }
  )
}

module "ansible" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami  = data.aws_ami.ami.id
  name = "${local.resource_name}-ansible"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.ansible_sg_id]
  subnet_id              = local.public_subnet_id
  user_data              = file(expense.sh)

  tags = merge(
    var.common_tags,
    var.mysql_tags,
    {
      Name = "${local.resource_name}-ansible"
    }
  )
}

