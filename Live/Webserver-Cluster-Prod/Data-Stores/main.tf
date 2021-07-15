provider "aws" {
    region = "us-west-1"
    access_key = "AKIAWGRXNRVQHNQANY4C"
    secret_key = "hDMXCaDA00tcP8rFjK3T9I4AzTjkJTE5IeGY5EzA"
    version = "~> 3.48"
}


resource "aws_db_instance" "example" {
    identifier_prefix = "terraform-up-and-running-sted"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t2.micro"
    name = "example_database"
    username = "admin"
    password = "$ted$inthu"
}


terraform {
    backend "s3" {
        bucket = "terraform-up-and-running-state-sted"
        key = "Data-Store/prod/terraform.tfstate"
        region = "us-west-1"
        
        dynamodb_table = "terraform-up-and-running-locks"
        encrypt = true
    }
    }