# Create a security group that allows access to ssh, http, and RDS ports for EC2 instances
resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg-${var.workspace}"
  vpc_id = module.network.vpc_id

  # Inbound rules 
  ingress {
    from_port   = 22 # SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80 # HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    self      = true
  }

  # Outbound rules 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg-${var.workspace}"
  description = "Security group for RDS"
  vpc_id      = module.network.vpc_id

  # Allow RDS access only from the EC2 security group
  ingress {
    from_port       = 3306 # RDS port
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id] # Allow only access from the EC2 security group
  }

  # Outbound rules 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
