module "security_groups" {
  source       = "../../modules/sg"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = var.sg_name
  vpc_id       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.sg_tags
}