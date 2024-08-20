resource "aws_instance" "tiger"{
ami = "ami-0ad21ae1d0696ad58"    # ubuntu in Mumbai
#instance_type = "t2.micro"
instance_type = var.type
#tags = {Name = "TerraformLab Day2"}
tags = {Name = var.servername}
}

#input variable
variable "type" {
  default = "t2.micro"
  description = "Instance Type"
}

variable "servername" {

  
}