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

variable "vpc_id" {
}

variable "AMI" {
  default = {}
}

variable "public_subnet_ids" {
  default = {}
}

variable "private_subnets" {
  default = {}
}

variable "aws_sg_id" {
  default = {}
}

variable "BUCKET_NAME" {
  default = ""
}

variable "KEY_NAME" {
  default = ""
}

variable "eip_id" {
  default = {}
}

variable "volume" {
  default = {}
  }

variable "bucket" {}
variable "key" {}
variable "service" {}
variable "root_size" {}

variable "key_name" {}
variable "associate_eip" {}