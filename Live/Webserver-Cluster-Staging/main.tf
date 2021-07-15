provider "aws" {
    region = "us-west-1"
    access_key = "AKIAWGRXNRVQHNQANY4C"
    secret_key = "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"
    version = "~> 3.48"
}

module "webserver_cluster" {

#source = "/Users/stbates/Desktop/New_Terraform_Training/Modules/Webserver-Cluster"
 source = "github.com/stedmon8/terraform-repo//Modules/Webserver-Cluster?ref=v0.0.1"
cluster_name = "webservers-stage"
db_remote_state_bucket = "terraform-up-and-running-state-sted"
db_remote_state_key = "Data-Store/staging/terraform.tfstate"

instance_type = "t2.micro"
min_size = 2
max_size = 2

}

resource "aws_security_group_rule" "allow_testing_inbound" {
    type = "ingress"
    security_group_id = module.webserver_cluster.alb_security_group_id

     from_port = 12345
     to_port = 12345
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]




}
