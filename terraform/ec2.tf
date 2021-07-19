resource "aws_instance" "web" {
  count                  = "${var.web_ec2_count}"
  ami                    = "${var.web_amis[var.region]}"
  instance_type          = "${var.web_instance_type}"
  tags                   = "${local.web_tags}"
} 
