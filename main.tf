provider "aws" {
  region     = "us-west-2"
 }
resource "aws_instance" "Jendoc" {
  key_name               = "terrakey"
  ami                    = "ami-03f65b8614a860c29"
  instance_type          = "t2.medium"
  network_interface {
    network_interface_id = aws_network_interface.mynet.id
    device_index         = 0
  }
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted = true
  }
  tags = {
    Name = "Jendoc"
  }
  user_data = file("jendocker.sh")
}
resource "aws_vpc" "myvpc" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name = "myvpc"
  }
  enable_dns_hostnames = true
  enable_dns_support   = true
}
resource "aws_security_group" "mysg" {
  description = "New security group"
  vpc_id      = aws_vpc.myvpc.id
   ingress {
    description      = "Jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  ingress {
    description      = "ALL"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    description      = "ALL"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "Mynewsg"
  }
}
resource "aws_subnet" "mysubnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "172.31.0.0/20"
  availability_zone = "us-west-2a"
  tags = {
    Name = "Sub01"
  }
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true
}
resource "aws_network_interface" "mynet" {
  subnet_id = aws_subnet.mysubnet.id
  tags = {
    Name = "NIF01"
  }
  security_groups = [aws_security_group.mysg.id]
}
resource "aws_internet_gateway" "mygate" {
  vpc_id = aws_vpc.myvpc.id
}
resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygate.id
  }
  tags = {
    Name = "Myroute"
  }
}
resource "aws_route_table_association" "myroutable" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.myroute.id
}
