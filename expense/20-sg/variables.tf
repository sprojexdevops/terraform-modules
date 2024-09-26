variable "project_name" {
  type    = string
  default = "expense"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "sg_name" {
  type    = list(string)
  default = ["mysql", "backend", "frontend"]
}

variable "common_tags" {
  type = map(any)
  default = {
    Project     = "expense"
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "sg_tags" {
  type    = list(map)
  default = [{}]
}