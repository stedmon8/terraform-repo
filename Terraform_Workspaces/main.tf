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

resource "aws_instance" "app-dev" {
   ami =  data.aws_ami.app_ami.id
   instance_type = "t2.micro"
  
}   

terraform {
    backend "s3" {
        bucket = "terraform-up-and-running-state-sted"
        key = "workspaces-example/terraform.tfstate"
        region = "us-west-1"
        
        dynamodb_table = "terraform-up-and-running-locks"
        encrypt = true
    }
    }