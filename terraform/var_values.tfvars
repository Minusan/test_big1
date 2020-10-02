### VPC info
AWS_REGION         = "us-east-1"
vpc_id             = "vpc-006c1b1e18a65d74f"
public_subnet_ids  = ["subnet-02364c561847fc622", "subnet-06cdf30b1a6c46e83"]
private_subnets    = ["subnet-0fe8a305eb1452691"]
aws_sg_id          = ["sg-0cfc374136fcda9c8",]

### EC2 Instance info
AMI                = "ami-0eb7fbcc77e5e6ec6"
INSTANCE_TYPE      = "t2.micro"
key_name           = "cosminkey"
associate_eip      = "false"
eip_id             = "eipalloc-0c1f5e209a98f496f"
root_size          = "30"
volume = {
#    volume1        = { device_name = "/dev/sdh", volume_id = "vol-05f0ff4b237b8f4f9"},
#    volume2        = { device_name = "/dev/sdi", volume_id = "vol-0797ab74843610a8e"}
    }

### S3 for tfstate info
bucket             = "cosmin-terra"
key                = "Test_EC2.tfstate"

### Tags
cost_center     = "Customer experience"
MANAGED         = "TERRAFORM"
SERVICEID       = "tc01171"
Name            = "Test_EC2"
ENVIRONMENT     = "PROD"
TID             = "SUST"
service         = "Global Access"

# ALB
create_lb           = "false"
create_globalaccelerator    = "true"
name_alb            = "Test_EC2"
load_balancer_type  = "application"
name_prefix         = ""
backend_protocol    = "HTTPS"
backend_port        = 443
target_type         = "instance"
listener_port       = 443
listener_protocol   = "HTTPS"
certificate_arn     = "arn:aws:acm:eu-west-1:144761996442:certificate/87e069bc-b3f4-49ed-b114-0cff9f5499bb"
target_group_name   = "Test_EC2"
target_group_path   = "/test"
target_group_port   = 80
target_group_sticky = "false"

#Route 53
create_route53      = "false"
zone_id             = "Z073262128X8X3VFHVYUI"
zone_name           = "test.devops.sustainalytics.com"
zone_type           = "A"