variable "project_name" {
  type    = string
  default = "expense"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "common_tags" {
  type = map(any)
  default = {
    Project     = "expense"
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "mysql_tags" {
  type = map(any)
  default = {
    Component = "mysql"
  }
}

variable "backend_tags" {
  type = map(any)
  default = {
    Component = "backend"
  }
}

variable "frontend_tags" {
  type = map(any)
  default = {
    Component = "frontend"
  }
}

variable "ansible_tags" {
  type = map(any)
  default = {
    Component = "ansible"
  }
}

variable "zone_name" {
  type = string
  default = "sprojex.in"
}

variable "backend_instnace_names" {
  type = list(string)
  default = ["backend", "backend2"]
}