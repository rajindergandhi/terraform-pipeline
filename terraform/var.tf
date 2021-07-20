variable "web_instance_type" {
  description = "Choose instance type for your web"
  default     = "t2.micro"
}

variable "web_tags" {
  default = {
    Name = "Webserver"
  }
}

variable "web_ec2_count" {
  description = "Choose number ec2 instances for web"
  default     = "1"
}

variable "region" {
  description = "Choose region for your stack"
  default     = "us-east-1"
}

