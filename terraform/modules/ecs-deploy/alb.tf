resource "aws_security_group" "this" {
  name   = "${var.appName}-alb-sg"
  vpc_id = module.common-modules.defaultVpc

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "this" {
  name               = "${var.appName}-bg-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = data.aws_subnets.public.ids

  enable_deletion_protection = false

}

resource "aws_lb_target_group" "blue" {
  name        = "${var.appName}-blue-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = module.common-modules.defaultVpc
  target_type = "instance"

  health_check {
    path                = "/actuator/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }
}

resource "aws_lb_target_group" "green" {
  name        = "${var.appName}-green-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = module.common-modules.defaultVpc
  target_type = "instance"

  health_check {
    path                = "/actuator/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}

resource "aws_security_group" "ecs" {
  name   = "${var.appName}-sg"
  vpc_id = module.common-modules.defaultVpc

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.this.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "alb_to_ecs_dynamic_ports" {
  type                     = "ingress"
  from_port                = 32768
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id         = aws_security_group.ecs.id
  source_security_group_id = aws_security_group.this.id
}