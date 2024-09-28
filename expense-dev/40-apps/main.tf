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
  count  = length(var.backend_instnace_names)
  source = "terraform-aws-modules/ec2-instance/aws"

  ami  = data.aws_ami.ami.id
  name = "${local.resource_name}-${var.backend_instnace_names[count.index]}"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.backend_sg_id]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    var.mysql_tags,
    {
      Name = "${local.resource_name}-${var.backend_instnace_names[count.index]}"
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
  user_data              = file("expense.sh")

  tags = merge(
    var.common_tags,
    var.mysql_tags,
    {
      Name = "${local.resource_name}-ansible"
    }
  )
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name

  records = [
    {
      name    = "mysql"
      type    = "A"
      ttl     = 1
      records = [
        module.mysql.private_ip
      ]
    },
    {
      name    = var.backend_instnace_names[0]
      type    = "A"
      ttl     = 1
      records = [
        module.backend[0].private_ip
      ]
    },
    {
      name    = var.backend_instnace_names[1]
      type    = "A"
      ttl     = 1
      records = [
        module.backend[1].private_ip
      ]
    },
    {
      name    = "frontend"
      type    = "A"
      ttl     = 1
      records = [
        module.frontend.private_ip
      ]
    },
    {
      name    = ""
      type    = "A"
      ttl     = 1
      records = [
        module.frontend.public_ip
      ]
    }
  ]
}

