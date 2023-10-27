output "launch_template" {
  value = aws_launch_template.asg_template
}

output "autoscaling_group" {
  value = aws_autoscaling_group.asg
}
