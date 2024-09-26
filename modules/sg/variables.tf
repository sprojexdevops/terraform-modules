variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "sg_name" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "common_tags" {
  type    = map(any)
  default = {}
}

variable "sg_tags" {
  type    = map(any)
  default = {}
}