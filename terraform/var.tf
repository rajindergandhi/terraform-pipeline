variable "web_instance_type" {
  description = "Choose instance type for your web"
  type        = "string"
  default     = "t2.micro"
}

variable "web_tags" {
  type = "map"
  default = {
    Name = "Webserver"
  }
}

variable "web_ec2_count" {
  description = "Choose number ec2 instances for web"
  type        = "string"
  default     = "1"
}

variable "region" {
  description = "Choose region for your stack"
  type        = "string"
  default     = "us-east-1"
}

