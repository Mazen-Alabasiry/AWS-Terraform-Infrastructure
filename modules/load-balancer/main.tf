# Create Application Load Balancers (ALBs) in each availability zone.
resource "aws_lb" "alb" {
  count                      = length(var.azs)
  name                       = "alb-${count.index + 1}-${var.workspace}"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = [for subnet in var.public_subnets_ids : subnet]
  enable_deletion_protection = false
}


# Configure target groups and listeners for ALBs.
resource "aws_lb_target_group" "target_group" {
  count                             = length(var.azs)
  name                              = "tg-${count.index + 1}-${var.workspace}"
  port                              = 80
  protocol                          = "HTTP"
  vpc_id                            = var.vpc_id
  load_balancing_cross_zone_enabled = true
}

resource "aws_lb_listener" "listener" {
  count             = length(var.azs)
  load_balancer_arn = aws_lb.alb[count.index].arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[count.index].arn
  }

}