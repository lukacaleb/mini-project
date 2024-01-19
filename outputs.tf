output "vpc_id" {
    value = aws_vpc.ass_vpc.id
}

output "elb_load_balancer_dns_name" {
    value = aws_lb.ass-load-balancer.dns_name
}