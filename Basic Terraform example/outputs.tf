output "public_ip" {
     
     value = aws_instance.app-dev[*].public_ip
     description = "This will show the puublic ip address of my ec2 instances"
   }