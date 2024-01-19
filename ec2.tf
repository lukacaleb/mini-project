resource "aws_instance" "ass-1" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key_pair
    security_groups = [aws_security_group.ass-security-grp-rule.id]
    subnet_id = aws_subnet.ass-public-subnet1.id
    availability_zone = var.availability_zone["a"]

    connection {
      type = "ssh"
      host = "self.public_ip"
      user = "ubuntu"
      private_key = file("/root/terraform/london-key-pair.pem")
    }

    tags = {
      Name = "ass-1"
      source = "terraform"
    }
  
}

resource "aws_instance" "ass-2" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key_pair
    security_groups = [aws_security_group.ass-security-grp-rule.id]
    subnet_id = aws_subnet.ass-public-subnet2.id
    availability_zone = var.availability_zone["b"]

    connection {
      type = "ssh"
      host = "self.public_ip"
      user = "ubuntu"
      private_key = file("/root/terraform/london-key-pair.pem")
    }

    tags = {
      Name = "ass-2"
      source = "terraform"
    }
  
}

resource "aws_instance" "ass-3" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key_pair
    security_groups = [aws_security_group.ass-security-grp-rule.id]
    subnet_id = aws_subnet.ass-public-subnet1.id
    availability_zone = var.availability_zone["a"]

    connection {
      type = "ssh"
      host = "self.public_ip"
      user = "ubuntu"
      private_key = file("/root/terraform/london-key-pair.pem")
    }

    tags = {
      Name = "ass-3"
      source = "terraform"
    }
}

resource "local_file" "Ip_address" {
    filename = "/root/terraform/ansible-playbook/host-inventory"
    content = <<EOT
    ${aws_instance.ass-1.public_ip}
    ${aws_instance.ass-2.public_ip}
    ${aws_instance.ass-3.public_ip}
     EOT
}

