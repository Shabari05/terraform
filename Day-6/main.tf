#creation of vpc

resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags={
        Name="devvpc"
    }
  }
#creation of IG and attach to VPC
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.dev.id
}
#creation of subnets
resource "aws_subnet" "public" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.dev.id
    availability_zone = "us-east-1a"
  
}
resource "aws_subnet" "public1" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.dev.id
    availability_zone = "us-east-1a"
  
}
#creation of RT
#edit RT
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.dev.id
    route{
        cidr_block = "0.0.0.0"
        gateway_id = aws_internet_gateway.IG.id
    }
  
}

#edit subnet association
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.name.id

}
#launch a server
resource "aws_instance" "hello" {
    ami="ami-0e449927258d45bc4" //take ami id from ec2 instance 
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.SG.id]
}
#create SG
resource "aws_security_group" "SG" {
    name = "SG"
    vpc_id = aws_vpc.dev.id
    tags={
        Name="dev_sg"
    }
    ingress  {
description = "TCP "
from_port = 80
to_port = 80
protocol = "TCP"
cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #all protocols 
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}
