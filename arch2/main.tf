resource "aws_autoscaling_group" "aws_asg_7" {
  provider = "aws.us-east-2"
  min_size = 1
  max_size = 1

  availability_zones = [
    "us-east-2b",
    "us-east-2c",
  ]

  launch_template {
    id = aws_launch_template.aws_launch_template_8.id
  }

  target_group_arns = [
    aws_lb_target_group.aws_lb_target_group_12.arn,
  ]
}

resource "aws_security_group_rule" "aws_security_group_rule-aea0f141" {
  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_db-fcaa5a30.id
  provider          = "aws.us-east-2"
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_lb_listener" "aws_lb_listener-14eb1e91" {
  provider          = "aws.us-east-2"
  protocol          = "HTTPS"
  port              = 443
  load_balancer_arn = aws_lb.alb_9.arn
  certificate_arn   = "arn:aws:acm:us-east-2:366187108546:certificate/d2c0f434-ce30-4932-a59b-993d8d2848df"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_target_group_12.arn
    forward {
      target_group {
        arn = aws_lb_target_group.aws_lb_target_group_12.arn
      }
    }
  }

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule-f362004a" {
  type                     = "ingress"
  to_port                  = 80
  source_security_group_id = aws_security_group.aws_security_group_alb_10.id
  security_group_id        = aws_security_group.aws_security_group_ec2-de08daee.id
  provider                 = "aws.us-east-2"
  protocol                 = "tcp"
  from_port                = 80
}

resource "aws_lb_target_group" "aws_lb_target_group_29" {
  vpc_id      = aws_default_vpc.aws_default_vpc_3.id
  target_type = "instance"
  protocol    = "HTTP"
  port        = 80

  tags = {
    env      = "Development"
    archUUID = "454f8601-3b0f-4677-9d74-73c07aa49065"
  }
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm_15" {
  threshold           = 90
  statistic           = "Average"
  provider            = "aws.us-east-2"
  period              = 600
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  evaluation_periods  = 2
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_name          = "cpu_above_90"
  actions_enabled     = true

  alarm_actions = [
    aws_autoscaling_policy.aws_autoscaling_policy_14.arn,
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws_asg_7.name
  }

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_security_group" "aws_security_group_26" {

  tags = {
    env      = "Development"
    archUUID = "454f8601-3b0f-4677-9d74-73c07aa49065"
  }
}

resource "aws_autoscaling_policy" "aws_autoscaling_policy-16dbd0bd" {
  scaling_adjustment     = -1
  provider               = "aws.us-east-2"
  name                   = "scale_in"
  autoscaling_group_name = aws_autoscaling_group.aws_asg_7.name
  adjustment_type        = "ChangeInCapacity"
}

resource "aws_security_group" "aws_security_group_ec2-de08daee" {
  vpc_id   = aws_default_vpc.aws_default_vpc_3.id
  provider = "aws.us-east-2"

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule-29c77e63" {
  type              = "ingress"
  to_port           = 443
  security_group_id = aws_security_group.aws_security_group_26.id
  provider          = "aws.us-east-2"
  protocol          = "tcp"
  from_port         = 443

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm-3e05cb0c" {
  threshold           = 60
  statistic           = "Average"
  provider            = "aws.us-east-2"
  period              = 600
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  evaluation_periods  = 2
  comparison_operator = "LessThanThreshold"
  alarm_name          = "cpu_below_60"
  actions_enabled     = true

  alarm_actions = [
    aws_autoscaling_policy.aws_autoscaling_policy-5bda9802.arn,
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws_asg_7.name
  }

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule-2b81709d" {
  type                     = "ingress"
  to_port                  = 80
  source_security_group_id = aws_security_group.aws_security_group_alb_10.id
  security_group_id        = aws_security_group.aws_security_group_26.id
  provider                 = "aws.us-east-2"
  protocol                 = "tcp"
  from_port                = 80
}

resource "aws_security_group" "aws_security_group_alb_10" {
  vpc_id   = aws_default_vpc.aws_default_vpc_3.id
  provider = "aws.us-east-2"

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_autoscaling_group" "aws_autoscaling_group-3a329cf0" {
  provider = "aws.us-east-2"
  min_size = 1
  max_size = 1

  availability_zones = [
    "us-east-2b",
    "us-east-2c",
  ]

  launch_template {
    id = aws_launch_template.aws_launch_template-d6e46686.id
  }

  target_group_arns = [
    aws_lb_target_group.aws_lb_target_group-a65cf02b.arn,
  ]
}

resource "aws_route53_record" "aws_route53_record_32" {
  zone_id = "Z0993102EDIT1RM1B14I"
  type    = "A"
  name    = "arch2gui"

  alias {
    zone_id                = aws_lb.alb_28.zone_id
    name                   = aws_lb.alb_28.dns_name
    evaluate_target_health = true
  }
}

resource "aws_security_group_rule" "aws_security_group_rule-3c3b854e" {
  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_26.id
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm-3d896345" {
  threshold           = 90
  statistic           = "Average"
  provider            = "aws.us-east-2"
  period              = 600
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  evaluation_periods  = 2
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_name          = "cpu_above_90"
  actions_enabled     = true

  alarm_actions = [
    aws_autoscaling_policy.aws_autoscaling_policy_14.arn,
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws_asg_7.name
  }

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_launch_template" "aws_launch_template_8" {
  user_data     = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteQpzdWRvIHN5c3RlbWN0bCBlbmFibGUgaHR0cGQKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3VkbyBlY2hvICJ0aGlzIGlzIG15IHdlYnNpdGUgMSIgPj4gL3Zhci93d3cvaHRtbC9pbmRleC5odG1s"
  provider      = "aws.us-east-2"
  key_name      = "brainboard"
  instance_type = "t2.medium"
  image_id      = "ami-0c6a6b0e75b2b6ce7"

  security_group_names = [
    aws_security_group.aws_security_group_ec2-de08daee.name,
  ]

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_17" {
  type              = "ingress"
  to_port           = 80
  security_group_id = aws_security_group.aws_security_group_alb_10.id
  provider          = "aws.us-east-2"
  protocol          = "tcp"
  from_port         = 80

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_instance" "m5_25" {
  user_data_base64 = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteQpzdWRvIHN5c3RlbWN0bCBlbmFibGUgaHR0cGQKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3VkbyBlY2hvICJ0aGlzIGlzIG15IEdVSSB3ZWJzaXRlIiA+PiAvdmFyL3d3dy9odG1sL2luZGV4Lmh0bWw="
  key_name         = "braibboard"
  instance_type    = "m5.large"
  ami              = "ami-0c6a6b0e75b2b6ce7"

  security_groups = [
    aws_security_group.aws_security_group_26.id,
  ]

  tags = {
    env      = "Development"
    archUUID = "454f8601-3b0f-4677-9d74-73c07aa49065"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule-c92a32cb" {
  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_alb_10.id
  provider          = "aws.us-east-2"
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm-4c876790" {
  threshold           = 60
  statistic           = "Average"
  provider            = "aws.us-east-2"
  period              = 600
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  evaluation_periods  = 2
  comparison_operator = "LessThanThreshold"
  alarm_name          = "cpu_below_60"
  actions_enabled     = true

  alarm_actions = [
    aws_autoscaling_policy.aws_autoscaling_policy-5bda9802.arn,
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws_asg_7.name
  }

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_lb" "alb_9" {
  provider                         = "aws.us-east-2"
  load_balancer_type               = "application"
  enable_http2                     = true
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  security_groups = [
    aws_security_group.aws_security_group_alb_10.id,
  ]

  subnets = [
    aws_default_subnet.aws_default_subnet_6.id,
    aws_default_subnet.aws_default_subnet_5.id,
  ]

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule-675b13ef" {
  type                     = "ingress"
  to_port                  = 3306
  source_security_group_id = aws_security_group.aws_security_group_ec2-de08daee.id
  security_group_id        = aws_security_group.aws_security_group_db-fcaa5a30.id
  provider                 = "aws.us-east-2"
  protocol                 = "tcp"
  from_port                = 3306
}

resource "aws_default_vpc" "aws_default_vpc_3" {
  provider = "aws.us-east-2"

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_lb" "alb_28" {
  load_balancer_type               = "application"
  enable_http2                     = true
  enable_cross_zone_load_balancing = true

  security_groups = [
    aws_security_group.aws_security_group_26.id,
  ]

  tags = {
    env      = "Development"
    archUUID = "454f8601-3b0f-4677-9d74-73c07aa49065"
  }
}

resource "aws_db_instance" "aurora_34" {
  replicate_source_db = aws_db_instance.aurora_33.id
  instance_class      = "db.t3.small"
  availability_zone   = "us-east-2b"

  tags = {
    env      = "Development"
    archUUID = "454f8601-3b0f-4677-9d74-73c07aa49065"
  }
}

resource "aws_lb_target_group_attachment" "aws_lb_target_group_attachment_30" {
  target_id        = aws_instance.m5_25.id
  target_group_arn = aws_lb_target_group.aws_lb_target_group_29.arn
}

resource "aws_lb_listener" "aws_lb_listener_80_13" {
  provider          = "aws.us-east-2"
  protocol          = "HTTP"
  port              = 80
  load_balancer_arn = aws_lb.alb_9.arn

  default_action {
    type = "redirect"
    forward {
      target_group {
        arn = aws_lb_target_group.aws_lb_target_group_12.arn
      }
    }
    redirect {
      status_code = "HTTP_301"
      query       = "#{query}"
      protocol    = "#{protocol}"
      port        = "443"
      path        = "#{path}"
      host        = "#{host}"
    }
  }

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_route53_record" "aws_route53_record_24" {
  zone_id = "Z0993102EDIT1RM1B14I"
  type    = "A"
  name    = "arch2"

  alias {
    zone_id                = aws_lb.alb_9.zone_id
    name                   = aws_lb.alb_9.dns_name
    evaluate_target_health = true
  }
}

resource "aws_default_subnet" "aws_default_subnet_5" {
  provider          = "aws.us-east-2"
  availability_zone = "us-east-2b"

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_security_group" "aws_security_group_db-fcaa5a30" {
  vpc_id   = aws_default_vpc.aws_default_vpc_3.id
  provider = "aws.us-east-2"

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_lb_target_group" "aws_lb_target_group-a65cf02b" {
  vpc_id      = aws_default_vpc.aws_default_vpc_3.id
  target_type = "instance"
  provider    = "aws.us-east-2"
  protocol    = "HTTP"
  port        = 80

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_27" {
  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_26.id
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_db_instance" "aurora_33" {
  username            = "myuser"
  storage_type        = "gp2"
  publicly_accessible = true
  password            = "thisismysecretpassword"
  multi_az            = true
  instance_class      = "t3.small"
  identifier          = "arch-db-instance"
  engine_version      = "5.7"
  engine              = "mysql"
  db_name             = "archdb"
  availability_zone   = "us-east-2c"
  allocated_storage   = 8

  security_group_names = [
    aws_security_group.aws_security_group_db-fcaa5a30.name,
  ]

  tags = {
    env      = "Development"
    archUUID = "454f8601-3b0f-4677-9d74-73c07aa49065"
  }
}

resource "aws_autoscaling_policy" "aws_autoscaling_policy-5bda9802" {
  scaling_adjustment     = -1
  provider               = "aws.us-east-2"
  name                   = "scale_in"
  autoscaling_group_name = aws_autoscaling_group.aws_asg_7.name
  adjustment_type        = "ChangeInCapacity"
}

resource "aws_security_group" "aws_security_group-aebe2a56" {

  tags = {
    env      = "Development"
    archUUID = "454f8601-3b0f-4677-9d74-73c07aa49065"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule-bdb16eff" {
  type                     = "ingress"
  to_port                  = 80
  source_security_group_id = aws_security_group.aws_security_group_26.id
  security_group_id        = aws_security_group.aws_security_group_26.id
  provider                 = "aws.us-east-2"
  protocol                 = "tcp"
  from_port                = 80
}

resource "aws_default_subnet" "aws_default_subnet_6" {
  provider          = "aws.us-east-2"
  availability_zone = "us-east-2c"

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_lb_target_group" "aws_lb_target_group_12" {
  vpc_id      = aws_default_vpc.aws_default_vpc_3.id
  target_type = "instance"
  provider    = "aws.us-east-2"
  protocol    = "HTTP"
  port        = 80

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_autoscaling_policy" "aws_autoscaling_policy_14" {
  scaling_adjustment     = 1
  provider               = "aws.us-east-2"
  name                   = "scale_out"
  autoscaling_group_name = aws_autoscaling_group.aws_asg_7.name
  adjustment_type        = "ChangeInCapacity"
}

resource "aws_launch_template" "aws_launch_template-d6e46686" {
  user_data     = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteQpzdWRvIHN5c3RlbWN0bCBlbmFibGUgaHR0cGQKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3VkbyBlY2hvICJ0aGlzIGlzIG15IHdlYnNpdGUgMiIgPj4gL3Zhci93d3cvaHRtbC9pbmRleC5odG1s"
  provider      = "aws.us-east-2"
  key_name      = "braibboard"
  instance_type = "t2.medium"
  image_id      = "ami-0c6a6b0e75b2b6ce7"

  security_group_names = [
    aws_security_group.aws_security_group_ec2-de08daee.name,
  ]

  tags = {
    env      = "Production"
    archUUID = "e5855611-71aa-4cbc-ad37-fb22e1764c39"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule-d904a786" {
  type              = "ingress"
  to_port           = 443
  security_group_id = aws_security_group.aws_security_group_26.id
  provider          = "aws.us-east-2"
  protocol          = "tcp"
  from_port         = 443

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "aws_security_group_rule_16" {
  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_ec2-de08daee.id
  provider          = "aws.us-east-2"
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_lb_listener" "aws_lb_listener_31" {
  load_balancer_arn = aws_lb.alb_28.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_target_group_29.arn
    forward {
      target_group {
        arn = aws_lb_target_group.aws_lb_target_group_29.arn
      }
    }
  }

  tags = {
    env      = "Development"
    archUUID = "454f8601-3b0f-4677-9d74-73c07aa49065"
  }
}

resource "aws_autoscaling_policy" "aws_autoscaling_policy-fe8091a4" {
  scaling_adjustment     = 1
  provider               = "aws.us-east-2"
  name                   = "scale_out"
  autoscaling_group_name = aws_autoscaling_group.aws_asg_7.name
  adjustment_type        = "ChangeInCapacity"
}

