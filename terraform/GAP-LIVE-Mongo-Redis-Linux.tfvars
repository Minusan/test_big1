### VPC info
AWS_REGION         = "eu-west-1"
vpc_id             = "vpc-062b78d85f59f6113"
public_subnet_ids  = ["subnet-0155fce74daf2665b", "subnet-02f2ef2f38b96e923"]
private_subnets    = ["subnet-031cd3bbbc720008d"]
aws_sg_id          = ["sg-01f876abc44d87a3b", "sg-0c8b372547b404857"]

### EC2 Instance info
AMI                = "ami-07968fa5f7b508577"
INSTANCE_TYPE      = "r5a.4xlarge"
key_name           = "mstar-stga-prod"
associate_eip      = "false"
eip_id             = "eipalloc-0c1f5e209a98f496f"
root_size          = "30"
volume = {
    volume1        = { device_name = "/dev/sdh", volume_id = "vol-0dd248a33945973d2"},
    volume2        = { device_name = "/dev/sdi", volume_id = "vol-0a5b0926b2f346397"}
    }

### S3 for tfstate info
bucket             = "mstar-stga-prod-eu-west-1-provisioning-tfstate"
key                = "GAP-LIVE-Mongo-Redis-Linux.tfstate"

### Tags
cost_center     = "Customer experience"
MANAGED         = "TERRAFORM"
SERVICEID       = "tc01171"
Name            = "GAP-LIVE-Mongo-Redis-Linux"
ENVIRONMENT     = "PROD"
TID             = "SUST"
service         = "Global Access"

# ALB
create_lb           = "false"
create_globalaccelerator    = "false"
name_alb            = "mstar-website"
load_balancer_type  = "application"
name_prefix         = ""
backend_protocol    = "HTTPS"
backend_port        = 443
target_type         = "instance"
listener_port       = 443
listener_protocol   = "HTTPS"
certificate_arn     = "arn:aws:acm:eu-west-1:144761996442:certificate/87e069bc-b3f4-49ed-b114-0cff9f5499bb"
target_group_name   = "mstar-website"
target_group_path   = "/"
target_group_port   = 80
target_group_sticky = "false"

#Route 53
create_route53      = "false"
zone_id             = "Z073262128X8X3VFHVYUI"
zone_name           = "test.devops.sustainalytics.com"
zone_type           = "A"