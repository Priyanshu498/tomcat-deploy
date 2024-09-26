# Application Load Balancer
resource "aws_lb" "tomcat_lb" {
  name               = "tomcat-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnets
}

# Target Group for Private Instances
resource "aws_lb_target_group" "tomcat_tg" {
  name     = "tomcat-TG"
  port     = var.port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Listener for the ALB
resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.tomcat_lb.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tomcat_tg.arn
  }
}
