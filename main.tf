terraform{
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}

provider "aws" {
    region = "eu-west-2"
}

resource "aws_vpc" "ass_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = "ass_vpc"
    }
}

resource "aws_internet_gateway" "ass_internet_gateway" {
    vpc_id = aws_vpc.ass_vpc.id
    tags = {
      Name = "ass_internet_gateway"
    }
  
}

resource "aws_route_table" "ass-route-table-public" {
    vpc_id = aws_vpc.ass_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ass_internet_gateway.id
    }

    tags = {
      Name = "ass-route-table-public"
    }
  
}


resource "aws_route_table_association" "ass-public-subnet1-association" {

    subnet_id = aws_subnet.ass-public-subnet1.vpc_id
    route_table_id = aws_route_table.ass-route-table-public.id
}

resource "aws_route_table_association" "ass-public-subnet2-association" {
    subnet_id = aws_subnet.ass-public-subnet2.vpc_id
    route_table_id = aws_route_table.ass-route-table-public.id
}

resource "aws_subnet" "ass-public-subnet1" {
    vpc_id = aws_vpc.ass_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-2a"

    tags = {
        Name = "ass-public-subnet1"
    }
}

resource "aws_subnet" "ass-public-subnet2" {
    vpc_id = aws_vpc.ass_vpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-2b"

    tags = {
        Name = "ass-public-subnet2"
    }
}


resource "aws_network_acl" "ass-network_acl" {
    vpc_id = aws_vpc.ass_vpc.id
    subnet_ids = [aws_subnet.ass-public-subnet1.id, aws_subnet.ass-public-subnet2.id]

    ingress {
        rule_no = 100
        protocol = "-1"
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    egress {
        rule_no = 100
        protocol = "-1"
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
  
}