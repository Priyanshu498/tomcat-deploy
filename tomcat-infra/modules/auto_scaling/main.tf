# Auto Scaling Group for Private Instances
resource "aws_launch_template" "tomcat_launch_template" {
  name_prefix   = "tomcat-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  key_name      = var.key_name
}

resource "aws_autoscaling_group" "tomcat_asg" {
  name               = "tomcat-asg"
  vpc_zone_identifier = var.private_subnets
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size

  launch_template {
    id      = aws_launch_template.tomcat_launch_template.id
    version = "$Latest"
    
  }
  
  
  tag {
    key                 = "Name"
    value               = "TomcatInstance"
    propagate_at_launch = true
  }

  health_check_type          = "EC2"
  health_check_grace_period = 300

  target_group_arns = [var.target_group_arn]
}
