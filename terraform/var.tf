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

variable "web_amis" {
  default = {
    us-east-1 = "ami-0b898040803850657"
    us-east-2 = "ami-0d8f6eb4f641ef691"
  }
}

