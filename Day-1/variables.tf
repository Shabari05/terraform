variable "ami_id" {
    description = "inserting amiid into main"
    type = string
    default = "ami-00a929b66ed6e0de6"
  
}

variable "instance_type" {
    type = string
    default = "t2.nano"
  
}