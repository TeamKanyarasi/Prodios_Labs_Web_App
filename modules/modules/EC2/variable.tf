variable "ami" {
  default = "ami-03f4878755434977f"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "ec2_public_sg_id" {}

variable "pub_sub_1a_id" {}

variable "project_name" {}

variable "iam_instance_profile" {}