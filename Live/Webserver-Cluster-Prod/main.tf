provider "aws" {
    region = "us-west-1"
    access_key = "AKIAWGRXNRVQHNQANY4C"
    secret_key = "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"
    version = "~> 3.48"
}


module "webserver_cluster" {

source = "/Users/stbates/Desktop/New_Terraform_Training/Modules/Webserver-Cluster"

cluster_name = "webservers-prod"
db_remote_state_bucket = "terraform-up-and-running-state-sted"
db_remote_state_key = "Data-Store/prod/terraform.tfstate"

instance_type = "m4.large"
min_size = 2
max_size = 10

}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
    schedule_action_name = "scale-out-during-business-hours"
    min_size = 2
    max_size = 10
    desired_capacity = 10
    recurrence = "0 9 * * *"
    autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale-in-at-night-time" {
    schedule_action_name = "scale-in-at-night-time"
    min_size = 2
    max_size = 10
    desired_capacity = 2
    recurrence = "0 17 * * *"

     autoscaling_group_name = module.webserver_cluster.asg_name
}

output "alb_dns_name" {
    value = module.webserver_cluster.alb_dns_name
    description = "The domain name of the load balancer"


}