output "load_balancer_id" {
  value = aws_lb.tomcat_lb.id
}

output "target_group_arn" {
  value = aws_lb_target_group.tomcat_tg.arn
}

output "listener_arn" {
  value = aws_lb_listener.alb.arn
}
