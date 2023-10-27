# Get latest Amazon Linux ami
data "aws_ami" "amazon-linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]

  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
