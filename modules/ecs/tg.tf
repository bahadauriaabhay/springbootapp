######alb

resource "aws_lb" "test" {
  name               = "awslb-${var.name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.public_sg
  subnets            = var.public_sub
}

resource "aws_lb_target_group" "test" {
  name     = "aws-lb-target-group-${var.name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = var.path
#    port                = var.port  dynamic port
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
    matcher             = var.matcher  # has to be HTTP 200 or fails
  }
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn     = aws_lb.test.arn
  port                  = "80"
  protocol              = "HTTP"

  default_action {
    type                = "forward"
    target_group_arn    = aws_lb_target_group.test.arn
  }
}