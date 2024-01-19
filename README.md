USING TERRAFORM TO CREATE MULTIPLE INFRASTRUCTURE ON AWS.
Using Terraform, to create several EC2 instances and put them behind an Elastic Load Balancer.
Making sure that after applying your plan, Terraform exports the public IP addresses of the instances to a file called host-inventory.
Get a .com.ng or any other domain name for yourself (be creative, this will be a domain you can keep using) 
and set it up with AWS Route53 within your terraform plan, 
then add an A record for subdomain terraform-test that points to your ELB IP address.
Create an Ansible script that uses the host-inventory file Terraform created to install Apache, 
set timezone to Africa/Lagos and displays a simple HTML page that displays content to clearly identify on all 3 EC2 instances.
