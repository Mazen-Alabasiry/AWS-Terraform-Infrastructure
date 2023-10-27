workspace            = "development"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
azs                  = ["eu-west-1a", "eu-west-1b"]
ami                  = "ami-08f32efd140b7d89f"
instance_type        = "t2.micro"
key_name             = "myawskey"

