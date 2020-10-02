terraform {
  backend "s3" {
    bucket = var.bucket
    key    = var.key 
    region = var.AWS_REGION
  }
}

locals {
  general_tags = {
	"Cost Center"  = var.cost_center
	ENVIRONMENT    = var.ENVIRONMENT
  MANAGED        = var.MANAGED
  SERVICEID      = var.SERVICEID
  Name           = var.Name
  TID            = var.TID
  Service         = var.service
}
}

module "instances" {
  source         = "./modules/instances"
  ENV            = var.ENVIRONMENT
  VPC_ID         = var.vpc_id
  PUBLIC_SUBNETS = var.public_subnet_ids
  Tags           = local.general_tags
  INSTANCE_TYPE  = var.INSTANCE_TYPE
  aws_sg_id      = var.aws_sg_id
  key_name       = var.key_name
  AMI            = var.AMI
  eip            = var.eip_id
  volume         = var.volume
  root_size      = var.root_size
  associate_eip  = var.associate_eip
}
module "alb" {
  source             = "./modules/alb"
#  version = "~> 5.0"
  create_lb          = var.create_lb
  create_route53     = var.create_route53
  create_globalaccelerator  = var.create_globalaccelerator
  name               = var.name_alb

  load_balancer_type = var.load_balancer_type

  vpc_id             = var.vpc_id
  subnets            = var.public_subnet_ids
  security_groups    = var.aws_sg_id
  instance_id        = module.instances.instance_id
  #access_logs = {
  #  bucket = "my-alb-logs"
  #}
  target_group_name = var.target_group_name
  name_prefix       = var.name_prefix

  target_group_path    = var.target_group_path
  target_group_port    = var.target_group_port
  target_group_sticky  = var.target_group_sticky

  zone_id = var.zone_id
  zone_name    = var.zone_name
  zone_type    = var.zone_type

  target_groups = [
    {
      name_prefix      = var.name_prefix
      backend_protocol = var.backend_protocol
      backend_port     = var.backend_port
      target_type      = var.target_type
      
    }
  ]

  https_listeners = [
    {
      port                 = var.listener_port
      protocol             = var.listener_protocol
      certificate_arn      = var.certificate_arn
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  tags = local.general_tags
}
