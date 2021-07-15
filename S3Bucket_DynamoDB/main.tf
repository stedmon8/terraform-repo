provider "aws" {
    region = "us-west-1"
    access_key = "AKIAWGRXNRVQHNQANY4C"
    secret_key = "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"
    version = "~> 3.48"
}

resource "aws_s3_bucket" "terraform_state" {
 bucket = "terraform-up-and-running-state-sted"

 lifecycle {
     prevent_destroy = true

 }

 versioning {
     enabled = true 

 }

 server_side_encryption_configuration {
     rule {
         apply_server_side_encryption_by_default {
             sse_algorithm = "AES256"

         }

     }

 }

}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-up-and-running-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"


    }


}

terraform {
    backend "s3" {
        bucket = "terraform-up-and-running-state-sted"
        key = "global/s3/terraform.tfstate"
        region = "us-west-1"
        
        dynamodb_table = "terraform-up-and-running-locks"
        encrypt = true

    }

}

output "s3_bucket_arn" {
    value = aws_s3_bucket.terraform_state.arn
    description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.terraform_locks.name
    description = "The name of the DynamoDB table"


}