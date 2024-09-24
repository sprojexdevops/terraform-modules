module "ec2" {
  source             = "./modules/ec2"
  ami_id             = var.ami_id
  instance_type      = "t3.large"   #"t3.micro"
  security_group_ids = ["sg-0a1fb132f1fc1e49d"]

}