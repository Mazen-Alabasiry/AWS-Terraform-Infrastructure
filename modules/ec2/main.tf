
resource "aws_instance" "ec2" {
  count         = length(var.azs)
  ami           = var.ami != "" ? var.ami: data.aws_ami.amazon-linux.id
  instance_type = var.instance_type
  subnet_id     = element(var.subnets, count.index)
  key_name      = var.key_name
  user_data     = var.user_data
  associate_public_ip_address = true
  vpc_security_group_ids = var.ec2_sg_ids
  tags = {
    Name = " EC2 ${count.index + 1}-${var.workspace}"
  }
}
