# Create  lanuch Template
resource "aws_launch_template" "asg_template" {
  name          = "asg-template-${var.workspace}"
  image_id      = var.ami != "" ? var.ami: data.aws_ami.amazon-linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  # user data must to be encoded in base64 format 
  user_data =var.user_data

  vpc_security_group_ids = var.ec2_sg_ids
}



# Create Auto Scaling Group for the private subnets with EC2 instances and configure ALB listeners and target groups.
resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = aws_launch_template.asg_template.id
    version = "$Latest"
  }
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  force_delete        = true
  vpc_zone_identifier = var.subnets
  name                = "asg-${var.workspace}"
  target_group_arns = var.target_group_arns
}