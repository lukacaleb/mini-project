resource "aws_lb" "ass-load-balancer" {
  name = "ass-load-balancer"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.ass-load_balancer_sg.id]
  subnets = [aws_subnet.ass-public-subnet1.id, aws_subnet.ass-public-subnet2.id]
  enable_deletion_protection = false
  depends_on = [ aws_instance.ass-1, aws_instance.ass-2, aws_instance.ass-3 ]
}

resource "aws_lb_target_group" "ass-target-group" {
  name = "ass-target-group"
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.ass_vpc.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
}


resource "aws_lb_listener" "ass-listener" {
  load_balancer_arn = aws_lb.ass-load-balancer.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ass-target-group.arn
  }
}

resource "aws_lb_listener_rule" "ass-listener-rule" {
    listener_arn = aws_lb_listener.ass-listener.arn
    priority = 1

    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.ass-target-group.arn
    }

    condition {
      path_pattern {
        values = ["/"]
      }
    }
}

resource "aws_lb_target_group_attachment" "ass-target-group-attachement1" {
  target_group_arn = aws_lb_target_group.ass-target-group.arn
  target_id = aws_instance.ass-1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "ass-target-group-attachement2" {
  target_group_arn = aws_lb_target_group.ass-target-group.arn
  target_id = aws_instance.ass-2.id
  port = 80
}

resource "aws_lb_target_group_attachment" "ass-target-group-attachement3" {
  target_group_arn = aws_lb_target_group.ass-target-group.arn
  target_id = aws_instance.ass-3.id
  port = 80
}