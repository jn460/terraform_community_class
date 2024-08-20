variable "lab_vpc01" {
  default = "labvpc01"
}

variable "lab_cidr01" {
  default = "10.0.0.0/16"
} 

variable "zone_for_subnets" {
  type = list(string)
  default = ["ap-southeast-1a" , "ap-southeast-1b" , "ap-southeast-1c"]
}

variable "cidr_for_subnets" {
  type = list(string)
  default = ["10.0.1.0/24" , "10.0.2.0/24" , "10.0.3.0/24"]
}

variable "name_for_subnets" {
  type = list(string)
  default = ["mysubnet01" , "mysubnet02" , "mysubnet03"]
}

