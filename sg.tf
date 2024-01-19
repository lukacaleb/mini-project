resource "aws_security_group" "ass-load_balancer_sg" {
    name        = "ass-load_balancer_sg"
    description = "security group for the load balancer"
    vpc_id      = aws_vpc.ass_vpc.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_security_group" "ass-security-grp-rule" {
    name        = "allow_ssh_http_https"
    description = "Allow SSH, HTTP, and HTTPS inbound traffic for public instances"
    vpc_id      = aws_vpc.ass_vpc.id

    ingress {
        description     = "HTTP"
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = [aws_security_group.ass-load_balancer_sg.id]
    }

    ingress {
        description     = "HTTPS"
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = [aws_security_group.ass-load_balancer_sg.id]
    }

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ass-security-grp-rule"
    }
}