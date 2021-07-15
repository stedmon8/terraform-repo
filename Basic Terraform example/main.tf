provider "aws" {
    region = "us-west-1"
    access_key = "AKIAWGRXNRVQHNQANY4C"
    secret_key = "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"
    version = "~> 3.48"
}



data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["099720109477"]


  filter {
    name   = "name"
    values = ["ubuntu/images/hvm*"]
  }
}


resource "aws_security_group" "instance" {
    name = "terraform_security_group"

        ingress {
            from_port = var.server_port
            to_port = var.server_port
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]

        }

         ingress {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]

        }

        egress {
            from_port        = 0
            to_port          = 0
            protocol         = "-1"
            cidr_blocks      = ["0.0.0.0/0"]
     
        }
    }

resource "aws_instance" "app-dev" {
   ami =  data.aws_ami.app_ami.id
   instance_type = "t2.micro"
   key_name = "terraform-key"
   vpc_security_group_ids = [aws_security_group.instance.id]
   count = 2

   user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                echo "${data.terraform_remote_state.db.outputs.address}" >> index.html
                echo "${data.terraform_remote_state.db.outputs.port}" >> index.html
                 nohup busybox httpd -f -p ${var.server_port}
                 &
                                EOF

   tags = {
     Name = element(var.tags,count.index)
     

   }

   
}   

data "terraform_remote_state" "db"{
    backend = "s3"
    config = {
        bucket = "terraform-up-and-running-state-sted"
        key = "Data-Store/terraform.tfstate"
        region = "us-west-1"
    }
}

terraform {
    backend "s3" {
        bucket = "terraform-up-and-running-state-sted"
        key = "Basic-Terraform-Example/terraform.tfstate"
        region = "us-west-1"
        
        dynamodb_table = "terraform-up-and-running-locks"
        encrypt = true
    }
    }