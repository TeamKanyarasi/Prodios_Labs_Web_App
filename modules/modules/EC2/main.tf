resource "aws_instance" "webserver" {
  ami                    = var.ami
  instance_type          = var.instance_type
  iam_instance_profile   = var.iam_instance_profile
  vpc_security_group_ids = [var.ec2_public_sg_id]
  subnet_id              = var.pub_sub_1a_id
  key_name               = "test-st"           #var.key_name
  user_data              = file("../modules/EC2/userdata.sh")
  tags = {
    Name = "${var.project_name}-fe-AZ1"
  }

}