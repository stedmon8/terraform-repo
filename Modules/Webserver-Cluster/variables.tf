variable "server_port" {
    description = "An example of a number variable in Terraform"
    type = number
    default = 8080
}

variable "cluster_name" {
    description = "The name to use for all the cluster resources"
    type = string 

}

variable "db_remote_state_bucket" {
    description = "The name of the S3 bucket for the datbase's remote state"
    type = string

}

variable "db_remote_state_key" {
    description = "The path for the database's remote stat in S3"
    type = string 


}

variable "instance_type" {
 description = "THe type of EC2 Instances to run ( e.g. t2.mirco)"
 type = string


}


variable "min_size" {
    description = "The minimum number of EC2 Instances in the ASG"
    type = number

}

variable "max_size" {
 description = "The maximum number of EC2 Instances in the ASG"
 type = number



}