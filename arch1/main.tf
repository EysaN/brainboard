resource "aws_security_group_rule" "aws_security_group_rule-17a03100" {
  provider = aws.us-east-2

  type              = "ingress"
  to_port           = 3306
  security_group_id = aws_security_group.aws_security_group_3.id
  protocol          = "tcp"
  from_port         = 3306

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_db_instance" "aurora_8" {
  provider = aws.us-east-2

  username            = "myuser"
  skip_final_snapshot = true
  publicly_accessible = true
  password            = "thisismypassword"
  instance_class      = "db.t3.small"
  identifier          = "mysql-aurora"
  engine_version      = "5.7"
  engine              = "mysql"
  availability_zone   = "us-east-2a"
  allocated_storage   = 200

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }

  vpc_security_group_ids = [
    aws_security_group.aws_security_group_3.id,
  ]
}

resource "aws_route53_record" "aws_route53_record_13" {
  provider = aws.us-east-2

  zone_id = "Z0993102EDIT1RM1B14I"
  type    = "A"
  name    = "arch1"

  alias {
    zone_id                = aws_lb.alb_9.zone_id
    name                   = aws_lb.alb_9.dns_name
    evaluate_target_health = true
  }
}

resource "aws_default_subnet" "aws_default_subnet_2" {
  provider = aws.us-east-2

  availability_zone = "us-east-2a"

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_5" {
  provider = aws.us-east-2

  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.aws_security_group_3.id
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_default_vpc" "aws_default_vpc_1" {
  provider = aws.us-east-2


  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_lb_target_group" "aws_lb_target_group_11" {
  provider = aws.us-east-2

  vpc_id      = aws_default_vpc.aws_default_vpc_1.id
  target_type = "instance"
  protocol    = "HTTP"
  port        = 80

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_15" {
  provider = aws.us-east-2

  type              = "ingress"
  to_port           = 443
  security_group_id = aws_security_group.aws_security_group_3.id
  protocol          = "tcp"
  from_port         = 443

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_lb" "alb_9" {
  provider = aws.us-east-2

  load_balancer_type = "application"
  enable_http2       = true

  security_groups = [
    aws_security_group.aws_security_group_3.id,
  ]

  subnets = [
    aws_default_subnet.aws_default_subnet_2.id,
    aws_default_subnet.aws_default_subnet_12.id,
  ]

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_lb_target_group_attachment" "aws_lb_target_group_attachment_14" {
  provider = aws.us-east-2

  target_id        = aws_instance.m5_6.id
  target_group_arn = aws_lb_target_group.aws_lb_target_group_11.arn
}

resource "aws_security_group" "aws_security_group_3" {
  provider = aws.us-east-2

  vpc_id = aws_default_vpc.aws_default_vpc_1.id

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_lb_listener" "aws_lb_listener_10" {
  provider = aws.us-east-2

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  protocol          = "HTTPS"
  port              = 443
  load_balancer_arn = aws_lb.alb_9.arn
  certificate_arn   = "arn:aws:acm:us-east-2:366187108546:certificate/d2c0f434-ce30-4932-a59b-993d8d2848df"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_target_group_11.arn
    forward {
      target_group {
        arn = aws_lb_target_group.aws_lb_target_group_11.arn
      }
    }
  }

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_default_subnet" "aws_default_subnet_12" {
  provider = aws.us-east-2

  availability_zone = "us-east-2b"

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_instance" "r5_7" {
  provider = aws.us-east-2

  monitoring        = false
  key_name          = "braibboard"
  instance_type     = "r5.large"
  availability_zone = "us-east-2a"
  ami               = "ami-0c6a6b0e75b2b6ce7"

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }

  vpc_security_group_ids = [
    aws_security_group.aws_security_group_3.id,
  ]
}

resource "aws_instance" "m5_6" {
  provider = aws.us-east-2

  user_data_base64  = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteQpzdWRvIHN5c3RlbWN0bCBlbmFibGUgaHR0cGQKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3VkbyBlY2hvICJ0aGlzIGlzIG15IHdlYnNpdGUgMSIgPj4gL3Zhci93d3cvaHRtbC9pbmRleC5odG1s"
  key_name          = "braibboard"
  instance_type     = "m5.large"
  availability_zone = "us-east-2a"
  ami               = "ami-0c6a6b0e75b2b6ce7"

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }

  vpc_security_group_ids = [
    aws_security_group.aws_security_group_3.id,
  ]
}

resource "aws_security_group_rule" "aws_security_group_rule_4" {
  provider = aws.us-east-2

  type              = "ingress"
  to_port           = 80
  security_group_id = aws_security_group.aws_security_group_3.id
  protocol          = "tcp"
  from_port         = 80

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

