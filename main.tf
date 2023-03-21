#this file consists of code for instances and sg
provider "aws" {
region = "us-east-1"
access_key = "AKIARQTIL2YDVW3EED3L"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-005f9685cb30f234b"
  instance_type   = "t2.micro"
  key_name        = "terraformproject"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "us-east-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by raham on server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-005f9685cb30f234b"
  instance_type   = "t2.micro"
  key_name        = "terraformproject"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "us-east-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by raham on server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-2"
  }
}

resource "aws_security_group" "three" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "four" {
  bucket = "sathishterraformprojectbucket"
}

resource "aws_iam_user" "five" {
name = "usersathishterraform" 
}

resource "aws_ebs_volume" "six" {
 availability_zone = "us-east-1b"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
