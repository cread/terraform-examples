resource "aws_lb" "lb" {
  name               = "ec2-spot-autoscale"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = data.aws_subnet_ids.default.ids
}

resource "aws_lb_target_group" "lb" {
  name        = "ec2-spot-autoscale"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id

  load_balancing_algorithm_type = "least_outstanding_requests"
  deregistration_delay          = 30

  stickiness {
    type    = "lb_cookie"
    enabled = false
  }

  health_check {
    enabled  = true
    interval = 10
    path     = "/"
    timeout  = 5
    matcher  = "200"
  }
}

resource "aws_lb_listener" "lb" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb.arn
  }
}
