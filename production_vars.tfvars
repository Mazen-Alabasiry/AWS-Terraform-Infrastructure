workspace            = "production"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.10.0/24", "10.0.20.0/24"]
private_subnet_cidrs = ["10.0.40.0/24", "10.0.50.0/24", "10.0.60.0/24", "10.0.70.0/24"]
azs                  = ["eu-west-1a", "eu-west-1b"]
ami                  = "ami-08f32efd140b7d89f"
instance_type        = "t2.micro"
key_name             = "myawskey"

