variable "server_port" {
    description = "An example of a number variable in Terraform"
    type = number
    default = 8080
}

variable "sted" {
    description = "An example of a number variable in Terraform"
    type = number
    default = 2
}

variable "tags" {
  type = list
  default = ["firstec2","secondec2"]
}