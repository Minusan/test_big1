variable "AWS_REGION" {
  default = {}
}

variable "cost_center" {
  default = {}
}

variable "MANAGED" {
  default = {}
}

variable "SERVICEID" {
  default = {}
}

variable "Name" {
  default = ""
}

variable "ENVIRONMENT" {
  default = ""
}

variable "TID" {
  default = ""
}

variable "Tags" {
  default = {}
}



variable "INSTANCE_TYPE" {
  default = ""
}

variable "VPC_ID" {
}

variable "AMI" {
  default = {}
}

variable "public_subnets" {
  default = {}
}

variable "private_subnets" {
  default = {}
}

variable "aws_sg_id" {
  default = {}
}

variable "PUBLIC_SUBNETS" {
  type = list
}


variable "ENV" {
}

variable "eip" {
  default = {}
}

variable "volume" {
  default = {}
  }

variable "root_size" {}
variable "key_name" {}
variable "associate_eip" {}