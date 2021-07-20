resource "aws_instance" "web" {
  count                  = "${var.web_ec2_count}"
  ami                    = "ami-0b898040803850657"
  instance_type          = "${var.web_instance_type}"
  tags                   = "${var.web_tags}"
} 
