resource "aws_rds_cluster" "aws_rds_cluster_53" {
  provider = aws.us-east-2

  skip_final_snapshot     = true
  master_username         = "masteruser"
  master_password         = "thisissecretmasterpassword"
  engine                  = "aurora-mysql"
  backup_retention_period = 1
  apply_immediately       = true

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }

  vpc_security_group_ids = [
    aws_security_group.aws_security_group_11.id,
  ]
}

resource "aws_security_group_rule" "aws_security_group_rule_14" {
  provider = aws.us-east-2

  type              = "ingress"
  to_port           = 80
  security_group_id = aws_security_group.aws_security_group_13.id
  protocol          = "tcp"
  from_port         = 80

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "aws_security_group_rule_6" {
  provider = aws.us-east-2

  type              = "ingress"
  to_port           = 443
  security_group_id = aws_security_group.aws_security_group_4.id
  protocol          = "tcp"
  from_port         = 443

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_autoscaling_policy" "aws_autoscaling_policy_38" {
  provider = aws.us-east-2

  scaling_adjustment     = 1
  name                   = "scale_out"
  autoscaling_group_name = aws_autoscaling_group.aws_asg_23.name
  adjustment_type        = "ChangeInCapacity"
}

resource "aws_lb_listener" "aws_lb_listener_31" {
  provider = aws.us-east-2

  protocol          = "HTTP"
  port              = 80
  load_balancer_arn = aws_lb.alb_30.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_target_group_37.arn
    forward {
      target_group {
        arn = aws_lb_target_group.aws_lb_target_group_37.arn
      }
    }
  }

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_10" {
  provider = aws.us-east-2

  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_8.id
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_autoscaling_policy" "aws_autoscaling_policy_50" {
  provider = aws.us-east-2

  scaling_adjustment     = -1
  name                   = "scale_in"
  autoscaling_group_name = aws_autoscaling_group.aws_asg_48.name
  adjustment_type        = "ChangeInCapacity"
}

resource "aws_security_group_rule" "aws_security_group_rule_21" {
  provider = aws.us-east-2

  type                     = "ingress"
  to_port                  = 80
  source_security_group_id = aws_security_group.aws_security_group_13.id
  security_group_id        = aws_security_group.aws_security_group_19.id
  protocol                 = "tcp"
  from_port                = 80
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm_44" {
  provider = aws.us-east-2

  unit                = "Percent"
  threshold           = 90
  statistic           = "Average"
  period              = 600
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  evaluation_periods  = 2
  comparison_operator = "LessThanThreshold"
  alarm_name          = "cpu_below_90"
  actions_enabled     = true

  alarm_actions = [
    aws_autoscaling_policy.aws_autoscaling_policy_39.arn,
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws_asg_23.name
  }

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_autoscaling_group" "aws_asg_23" {
  provider = aws.us-east-2

  min_size         = 2
  max_size         = 5
  desired_capacity = 2

  availability_zones = [
    "us-east-2c",
    "us-east-2b",
  ]

  launch_template {
    version = aws_launch_template.aws_launch_template_35.latest_version
    id      = aws_launch_template.aws_launch_template_35.id
  }

  target_group_arns = [
    aws_lb_target_group.aws_lb_target_group_37.arn,
  ]
}

resource "aws_instance" "m5_24" {
  provider = aws.us-east-2

  user_data     = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteQpzdWRvIHN5c3RlbWN0bCBlbmFibGUgaHR0cGQKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3VkbyBlY2hvICJ0aGlzIGlzIG15IEdVSSB3ZWJzaXRlIiA+PiAvdmFyL3d3dy9odG1sL2luZGV4Lmh0bWw="
  key_name      = "braibboard"
  instance_type = "m5.large"
  ami           = "ami-0c6a6b0e75b2b6ce7"

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }

  vpc_security_group_ids = [
    aws_security_group.aws_security_group_8.id,
  ]
}

resource "aws_security_group_rule" "aws_security_group_rule_15" {
  provider = aws.us-east-2

  type              = "ingress"
  to_port           = 443
  security_group_id = aws_security_group.aws_security_group_13.id
  protocol          = "tcp"
  from_port         = 443

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group" "aws_security_group_4" {
  provider = aws.us-east-2


  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_lb_listener" "aws_lb_listener_26" {
  provider = aws.us-east-2

  protocol          = "HTTPS"
  port              = 443
  load_balancer_arn = aws_lb.alb_25.arn
  certificate_arn   = "arn:aws:acm:us-east-2:366187108546:certificate/d2c0f434-ce30-4932-a59b-993d8d2848df"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_target_group_27.arn
    forward {
      target_group {
        arn = aws_lb_target_group.aws_lb_target_group_27.arn
      }
    }
  }

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_12" {
  provider = aws.us-east-2

  type                     = "ingress"
  to_port                  = 3306
  source_security_group_id = aws_security_group.aws_security_group_19.id
  security_group_id        = aws_security_group.aws_security_group_11.id
  protocol                 = "tcp"
  from_port                = 3306
}

resource "aws_security_group" "aws_security_group_8" {
  provider = aws.us-east-2


  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_security_group" "aws_security_group_13" {
  provider = aws.us-east-2


  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm_51" {
  provider = aws.us-east-2

  unit                = "Percent"
  threshold           = 90
  statistic           = "Average"
  period              = 600
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  evaluation_periods  = 2
  comparison_operator = "LessThanThreshold"
  alarm_name          = "cpu_below_90"
  actions_enabled     = true

  alarm_actions = [
    aws_autoscaling_policy.aws_autoscaling_policy_50.arn,
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws_asg_48.name
  }

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_rds_cluster_instance" "aws_rds_cluster_instance_54" {
  provider = aws.us-east-2

  publicly_accessible = true
  promotion_tier      = 0
  instance_class      = "db.t3.small"
  identifier          = "aurora-cluster-instance-1"
  engine_version      = aws_rds_cluster.aws_rds_cluster_53.engine_version_actual
  engine              = aws_rds_cluster.aws_rds_cluster_53.engine
  cluster_identifier  = aws_rds_cluster.aws_rds_cluster_53.cluster_identifier
  availability_zone   = "us-east-2c"
  apply_immediately   = true

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_lb" "alb_30" {
  provider = aws.us-east-2

  load_balancer_type               = "application"
  enable_http2                     = true
  enable_cross_zone_load_balancing = true

  security_groups = [
    aws_security_group.aws_security_group_13.id,
  ]

  subnets = [
    aws_default_subnet.aws_default_subnet_3.id,
    aws_default_subnet.aws_default_subnet_2.id,
  ]

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_default_subnet" "aws_default_subnet_3" {
  provider = aws.us-east-2

  availability_zone = "us-east-2c"

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_7" {
  provider = aws.us-east-2

  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_4.id
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_lb_target_group_attachment" "aws_lb_target_group_attachment_28" {
  provider = aws.us-east-2

  target_id        = aws_instance.m5_24.id
  target_group_arn = aws_lb_target_group.aws_lb_target_group_27.arn
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm_52" {
  provider = aws.us-east-2

  unit                = "Percent"
  threshold           = 90
  statistic           = "Average"
  period              = 600
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  evaluation_periods  = 2
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_name          = "cpu_above_90"
  actions_enabled     = true

  alarm_actions = [
    aws_autoscaling_policy.aws_autoscaling_policy_49.arn,
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws_asg_48.name
  }

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_9" {
  provider = aws.us-east-2

  type                     = "ingress"
  to_port                  = 80
  source_security_group_id = aws_security_group.aws_security_group_4.id
  security_group_id        = aws_security_group.aws_security_group_8.id
  protocol                 = "tcp"
  from_port                = 80
}

resource "aws_autoscaling_group" "aws_asg_48" {
  provider = aws.us-east-2

  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  availability_zones = [
    "us-east-2b",
    "us-east-2c",
  ]

  launch_template {
    version = aws_launch_template.aws_launch_template_34.latest_version
    id      = aws_launch_template.aws_launch_template_34.id
  }

  target_group_arns = [
    aws_lb_target_group.aws_lb_target_group_36.arn,
  ]
}

resource "aws_lb_target_group" "aws_lb_target_group_27" {
  provider = aws.us-east-2

  vpc_id      = aws_default_vpc.aws_default_vpc_1.id
  target_type = "instance"
  protocol    = "HTTP"
  port        = 80

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_lb_target_group" "aws_lb_target_group_36" {
  provider = aws.us-east-2

  vpc_id      = aws_default_vpc.aws_default_vpc_1.id
  target_type = "instance"
  protocol    = "HTTP"
  port        = 80

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_route53_record" "aws_route53_record_33" {
  provider = aws.us-east-2

  zone_id = "Z0993102EDIT1RM1B14I"
  type    = "A"
  name    = "arch2"

  alias {
    zone_id                = aws_lb.alb_30.zone_id
    name                   = aws_lb.alb_30.dns_name
    evaluate_target_health = true
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_16" {
  provider = aws.us-east-2

  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_13.id
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_lb_listener" "aws_lb_listener_32" {
  provider = aws.us-east-2

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  protocol          = "HTTPS"
  port              = 443
  load_balancer_arn = aws_lb.alb_30.arn
  certificate_arn   = "arn:aws:acm:us-east-2:366187108546:certificate/d2c0f434-ce30-4932-a59b-993d8d2848df"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_target_group_36.arn
    forward {
      target_group {
        arn = aws_lb_target_group.aws_lb_target_group_36.arn
      }
    }
  }

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_rds_cluster_instance" "aws_rds_cluster_instance_55" {
  provider = aws.us-east-2

  publicly_accessible = true
  promotion_tier      = 1
  instance_class      = "db.t3.small"
  engine_version      = aws_rds_cluster.aws_rds_cluster_53.engine_version_actual
  engine              = aws_rds_cluster.aws_rds_cluster_53.engine
  cluster_identifier  = aws_rds_cluster.aws_rds_cluster_53.cluster_identifier
  availability_zone   = "us-east-2b"
  apply_immediately   = true

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_launch_template" "aws_launch_template_34" {
  provider = aws.us-east-2

  user_data     = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteQpzdWRvIHN5c3RlbWN0bCBlbmFibGUgaHR0cGQKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3VkbyBlY2hvICJ0aGlzIGlzIG15IHdlYnNpdGUgMiIgPj4gL3Zhci93d3cvaHRtbC9pbmRleC5odG1s"
  key_name      = "braibboard"
  instance_type = "t2.medium"
  image_id      = "ami-0c6a6b0e75b2b6ce7"

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }

  vpc_security_group_ids = [
    aws_security_group.aws_security_group_19.id,
  ]
}

resource "aws_default_subnet" "aws_default_subnet_2" {
  provider = aws.us-east-2

  availability_zone = "us-east-2b"

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_22" {
  provider = aws.us-east-2

  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_19.id
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_launch_template" "aws_launch_template_35" {
  provider = aws.us-east-2

  user_data     = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteQpzdWRvIHN5c3RlbWN0bCBlbmFibGUgaHR0cGQKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3VkbyBlY2hvICJ0aGlzIGlzIG15IHdlYnNpdGUgMSIgPj4gL3Zhci93d3cvaHRtbC9pbmRleC5odG1s"
  key_name      = "braibboard"
  instance_type = "t2.medium"
  image_id      = "ami-0c6a6b0e75b2b6ce7"

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }

  vpc_security_group_ids = [
    aws_security_group.aws_security_group_19.id,
  ]
}

resource "aws_security_group" "aws_security_group_19" {
  provider = aws.us-east-2


  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm_45" {
  provider = aws.us-east-2

  unit                = "Percent"
  threshold           = 90
  statistic           = "Average"
  period              = 600
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  evaluation_periods  = 2
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_name          = "cpu_above_90"
  actions_enabled     = true

  alarm_actions = [
    aws_autoscaling_policy.aws_autoscaling_policy_38.arn,
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws_asg_23.name
  }

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_20" {
  provider = aws.us-east-2

  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_11.id
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_lb" "alb_25" {
  provider = aws.us-east-2

  load_balancer_type               = "application"
  enable_http2                     = true
  enable_cross_zone_load_balancing = true

  security_groups = [
    aws_security_group.aws_security_group_4.id,
  ]

  subnets = [
    aws_default_subnet.aws_default_subnet_2.id,
    aws_default_subnet.aws_default_subnet_3.id,
  ]

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_autoscaling_policy" "aws_autoscaling_policy_39" {
  provider = aws.us-east-2

  scaling_adjustment     = -1
  name                   = "scale_in"
  autoscaling_group_name = aws_autoscaling_group.aws_asg_23.name
  adjustment_type        = "ChangeInCapacity"
}

resource "aws_route53_record" "aws_route53_record_29" {
  provider = aws.us-east-2

  zone_id = "Z0993102EDIT1RM1B14I"
  type    = "A"
  name    = "arch2gui"

  alias {
    zone_id                = aws_lb.alb_25.zone_id
    name                   = aws_lb.alb_25.dns_name
    evaluate_target_health = true
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_5" {
  provider = aws.us-east-2

  type              = "ingress"
  to_port           = 80
  security_group_id = aws_security_group.aws_security_group_4.id
  protocol          = "tcp"
  from_port         = 80

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_default_vpc" "aws_default_vpc_1" {
  provider = aws.us-east-2


  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_autoscaling_policy" "aws_autoscaling_policy_49" {
  provider = aws.us-east-2

  scaling_adjustment     = 1
  name                   = "scale_out"
  autoscaling_group_name = aws_autoscaling_group.aws_asg_48.name
  adjustment_type        = "ChangeInCapacity"
}

resource "aws_security_group" "aws_security_group_11" {
  provider = aws.us-east-2


  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

resource "aws_lb_target_group" "aws_lb_target_group_37" {
  provider = aws.us-east-2

  vpc_id      = aws_default_vpc.aws_default_vpc_1.id
  target_type = "instance"
  protocol    = "HTTP"
  port        = 80

  tags = {
    env      = "Production"
    archUUID = "c3cbd410-a565-4d33-bfd0-4e81e45e61f7"
  }
}

