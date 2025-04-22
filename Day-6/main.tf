resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_type
    availability_zone = "us-east-1b"

    tags = {
      Name = "dev"
    }
    
  
}