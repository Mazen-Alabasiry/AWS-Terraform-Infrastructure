output "albs" {
    value = aws_lb.alb.*.id
}
output "target_groups_id" {
  value = aws_lb_target_group.target_group.*.id
}
output "target_groups_arns" {
  value = aws_lb_target_group.target_group.*.arn
}