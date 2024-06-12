variable "project_name" {
    description = "define your project name" 
    default = "ProdiosLabsWebApp"
}

# IPV4 CIDR Block value for VPC
variable "vpc_cidr" {
  description = "cidr Block value for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable pub_sub_1a_cidr {
    default = "1st public subnet"
    type = string
}