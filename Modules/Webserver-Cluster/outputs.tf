output "public_ip" {
     
     value = aws_lb.loadbalance.dns_name
     description = "This will show the puublic ip address of my ec2 instances"
   }


output "asg_name" {

    value = aws_autoscaling_group.ASG.name
    description = "THe name of the Auto Scaling Group"
  
}

output "alb_dns_name" {
    value = aws_lb.loadbalance.dns_name
    description = "The domain name of the load balancer"



}

output "alb_security_group_id" {
    value = aws_security_group.alb.id
    description = "The ID of the secuitu Group attached to the load balcner"


}
