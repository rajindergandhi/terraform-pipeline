resource "aws_instance" "web" {
  count                  = "${var.instance_count}"
  ami                    = "ami-0b898040803850657"
  instance_type          = "t2.micro"
} 
