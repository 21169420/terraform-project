#this file consists of code for instances and sg
provider "aws" {
region = "us-east-1"
access_key = "AKIA6HZPVPGXQ3IUWPNS"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-022e1a32d3f742bd8"
  instance_type   = "t2.micro"
  key_name        = "Jenkins-Keypair_pem"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by raham sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-022e1a32d3f742bd8"
  instance_type   = "t2.micro"
  key_name        = "Jenkins-Keypair_pem"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by raham sir server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-022e1a32d3f742bd8"
  instance_type   = "t2.micro"
  key_name        = "Jenkins-Keypair_pem"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-022e1a32d3f742bd8"
  instance_type   = "t2.micro"
  key_name        = "Jenkins-Keypair_pem"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1b"
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
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

resource "aws_s3_bucket" "six" {
  bucket = "gnana_reddy"
}

resource "aws_iam_user" "seven" {
name = "kops" 
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "us-east-1a"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
