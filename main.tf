provider "aws" {
  region     = var.rname
 }
resource "aws_instance" "Jendoc" {
  key_name               = var.keyname
  ami                    = var.amiid
  instance_type          = var.instype
  network_interface {
    network_interface_id = aws_network_interface.mynet1.id
    device_index         = 0
  }
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted = true
  }
  tags = {
    Name = var.vmname
  }
  user_data = file("jendocker.sh")
}
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpcid
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
    description      = "All"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 egress {
    description      = "All"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Mynewsg"
  }
}
resource "aws_subnet" "mysubnet1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.subnetid1
  availability_zone = var.azone1
  tags = {
    Name = var.subname1
  }
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true
}
/*resource "aws_subnet" "mysubnet2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.subnetid2
  availability_zone = var.azone2
  tags = {
    Name = var.subname2
  }
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true
}*/
resource "aws_network_interface" "mynet1" {
  subnet_id = aws_subnet.mysubnet1.id
  tags = {
    Name = var.Netif1
  }
  security_groups = [aws_security_group.mysg.id]
}
/*resource "aws_network_interface" "mynet2" {
  subnet_id = aws_subnet.mysubnet2.id
  tags = {
    Name = var.Netif2
  }
  security_groups = [aws_security_group.mysg.id]
}*/
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
resource "aws_route_table_association" "myroutable1" {
  subnet_id      = aws_subnet.mysubnet1.id
  route_table_id = aws_route_table.myroute.id
}
/*resource "aws_route_table_association" "myroutable2" {
  subnet_id      = aws_subnet.mysubnet2.id
  route_table_id = aws_route_table.myroute.id
}*/
/*# web app load balancer
resource "aws_lb" "exloadbal" {
  name = "webexternalloadbalancer"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.mysg.id]
  subnets = [aws_subnet.mysubnet.id,aws_subnet.mysubnet1.id ]
  enable_deletion_protection = false
  tags = {
    Name = "App Load balancer"
  }
}
resource "aws_lb_target_group" "albtarget" {
  name = "appbaltg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.myvpc.id
}
resource "aws_lb_target_group_attachment" "tgroup" {
  target_group_arn = aws_lb_target_group.albtarget.arn
  target_id = aws_instance.Jendoc.id
  port = 80
}
resource "aws_lb_listener" "externalelb" {
  load_balancer_arn = aws_lb.exloadbal.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.albtarget.arn
  }
}*/

  

  

