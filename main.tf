#this file consists of code for instances and sg
provider "aws" {
region = "us-west-1"
access_key = "AKIA6HZPVPGX2YEQZZHQ"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-09c5c62bac0d0634e"
  instance_type   = "t2.micro"
  key_name        = "rrraham"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-west-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
#yum install httpd -y
#systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by raham sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-09c5c62bac0d0634e"
  instance_type   = "t2.micro"
  #key_name        = "rrraham"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-west-1c"
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
  ami             = "ami-09c5c62bac0d0634e5"
  instance_type   = "t2.micro"
  #key_name        = "rrraham"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-west-1a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-09c5c62bac0d0634e"
  instance_type   = "t2.micro"
  #key_name        = "rrraham"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-west-1c"
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
  bucket = "gnana77889900"
}

resource "aws_iam_user" "seven" {
name = "Terraform" 
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "us-west-1c"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.10.2"
  availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name           = "mydb"
  master_username         = "gnana"
  master_password         = "gnana@1999"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

