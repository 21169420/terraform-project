resource "aws_elb" "bar" {
  name               = "gnana-terraform-elb"
  availability_zones = ["us-west-1a", "us-west-1c"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                 = ["${aws_instance.one.id}", "${aws_instance.two.id}"]
  cross_zone_load_balancing = true
  idle_timeout              = 400
  tags = {
    Name = "gnana-tf-elb"
  }
}

###resource "aws_rds_cluster" "default" {
#  cluster_identifier      = "aurora-cluster-demo"
#  engine                  = "aurora-mysql"
#  engine_version          = "5.7.mysql_aurora.2.11.2"
#  availability_zones      = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
#  database_name           = "mydb"
#  master_username         = "gnana"
#  master_password         = "gnana@1999"
#  backup_retention_period = 5
#  preferred_backup_window = "07:00-09:00"
} 
