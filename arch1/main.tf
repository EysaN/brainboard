resource "aws_security_group_rule" "aws_security_group_rule-17a03100" {
  provider = aws.eu-central-1

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
  provider = aws.eu-central-1

  username            = "myuser"
  storage_type        = "gp2"
  publicly_accessible = true
  password            = "thisismypassword"
  instance_class      = "db.t3.small"
  identifier          = "mysql-aurora"
  engine              = "mysql"
  db_name             = "mydb"
  availability_zone   = "eu-central-1a"

  security_group_names = [
    aws_security_group.aws_security_group_3.name,
  ]

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_route53_record" "aws_route53_record_13" {
  provider = aws.eu-central-1

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
  provider = aws.eu-central-1

  availability_zone = "eu-central-1a"

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_5" {
  provider = aws.eu-central-1

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
  provider = aws.eu-central-1


  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_lb_target_group" "aws_lb_target_group_11" {
  provider = aws.eu-central-1

  vpc_id      = aws_default_vpc.aws_default_vpc_1.id
  target_type = "instance"
  protocol    = "HTTP"
  port        = 80

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_lb" "alb_9" {
  provider = aws.eu-central-1

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
  provider = aws.eu-central-1

  target_id        = aws_instance.m5_6.id
  target_group_arn = aws_lb_target_group.aws_lb_target_group_11.arn
}

resource "aws_security_group" "aws_security_group_3" {
  provider = aws.eu-central-1

  vpc_id = aws_default_vpc.aws_default_vpc_1.id

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_lb_listener" "aws_lb_listener_10" {
  provider = aws.eu-central-1

  load_balancer_arn = aws_lb.alb_9.arn

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
  provider = aws.eu-central-1

  availability_zone = "eu-central-1b"

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_instance" "r5_7" {
  provider = aws.eu-central-1

  monitoring    = false
  key_name      = "braibboard"
  instance_type = "r5.large"
  ami           = "ami-0c6a6b0e75b2b6ce7"

  security_groups = [
    aws_security_group.aws_security_group_3.id,
  ]

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_instance" "m5_6" {
  provider = aws.eu-central-1

  user_data_base64  = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteQpzdWRvIHN5c3RlbWN0bCBlbmFibGUgaHR0cGQKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3VkbyBlY2hvICJ0aGlzIGlzIG15IHdlYnNpdGUgMSIgPj4gL3Zhci93d3cvaHRtbC9pbmRleC5odG1s"
  key_name          = "braibboard"
  instance_type     = "m5.large"
  availability_zone = "eu-central-1a"
  ami               = "ami-0c6a6b0e75b2b6ce7"

  security_groups = [
    aws_security_group.aws_security_group_3.id,
  ]

  tags = {
    env      = "Development"
    archUUID = "27e3a626-c4ac-45d4-ba51-465591a24fa0"
  }
}

resource "aws_security_group_rule" "aws_security_group_rule_4" {
  provider = aws.eu-central-1

  type              = "ingress"
  to_port           = 80
  security_group_id = aws_security_group.aws_security_group_3.id
  protocol          = "tcp"
  from_port         = 80

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

