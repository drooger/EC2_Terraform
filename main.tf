## AWS provider configuration
provider "aws" {
  profile			= "aws"
  region			= "us-east-1"
}

## VPC selection, needed for subnet_ids
data "aws_vpc" "default" {
  default	= true
}

## Subnet_ids selection
data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

## EC2 instance specification
data "aws_ami" "amazon_linux" {
  most_recent 	= true
  filter {
    name	= "name"
    values 	= ["amzn-ami-hvm-*-x86_64-ebs"]
  }
  filter {
    name 	= "owner-alias"
    values 	= ["amazon"]
  }
}

## Security group for EC2 instances
module "security_group" {
  source 		= "terraform-aws-modules/security-group/aws"
  name 			= "awsservers"
  description 		= "Security group for EC2 instances created with terraform"
  vpc_id		= "${data.aws_vpc.default.id}"
  ingress_cidr_blocks 	= ["0.0.0.0/0"]
  ingress_rules		= ["ssh-tcp", "http-80-tcp", "all-icmp"]
  egress_rules		= ["all-all"]
}

## EC2 instance creation
module "ec2_cluster" {
  source			= "terraform-aws-modules/ec2-instance/aws"
  instance_count		= 4
  name				= "tf-instance"
  ami				= "${data.aws_ami.amazon_linux.id}"
  instance_type			= "t2.micro"
  associate_public_ip_address	= true
  subnet_id			= "${element(data.aws_subnet_ids.all.ids, 0)}"
  vpc_security_group_ids	= ["${module.security_group.this_security_group_id}"]
  tags = {
    Type			= "tf-example"
  }
}
