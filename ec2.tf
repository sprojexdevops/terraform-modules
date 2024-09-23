module "ec2" {
  source             = "./ec2-demo"
  ami_id             = var.ami_id
  instance_type      = "t3.micro"
  security_group_ids = ["sg-0a1fb132f1fc1e49d"]

}