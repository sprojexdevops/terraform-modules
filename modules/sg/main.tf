resource "aws_security_group" "security_groups" {
  count  = length(var.sg_name)
  name   = "${local.sg_final_name}-${var.sg_name[count.index]}"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    var.sg_tags,
    {
      name = "${local.sg_final_name}-${var.sg_name[count.index]}"
    }
  )
}