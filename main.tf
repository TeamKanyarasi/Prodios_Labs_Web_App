#Creation Deatils of VPC
module "VPC" {
    source = "./modules/modules/VPC"
    # region = var.region
    # vpc_name= var.vpc.name  #not sure of the variable mentioned here , Double check
    vpc_cidr   = module.VPC.vpc_cidr
    project_name = var.project_name
    pub_sub_1a_cidr = module.VPC.pub_sub_1a_cidr
  
}

module "Security_Group" {
    source = "./modules/modules/Security_Group"
    vpc_id = module.vpc.vpc_id
    project_name = var.project_name
}

module "EC2" {
  source = "./modules/modules/EC2"
  ami = ""
  iam_instance_profile = module.S3.ec2_role
  project_name = var.project_name
  pub_sub_1a_id = module.VPC.pub_sub_1a_id
  ec2_public_sg_id = module.Security_Group.ec2_public_sg_id
}

module "ALB" {
  source = "./modules/modules/ALB"
    project_name      = var.project_name
    pub_sub_1a_id     = module.vpc.pub_sub_1a_id
    ec2_public_sg_id  = module.security-group.ec2_public_sg_id
    vpc_id            = module.vpc.vpc_id
    webserver_id = module.EC2.webserver_id
}

module "S3" {
    source = "./modules/modules/S3"
  
}

module "CDN" {
  source = "./modules/modules/CDN"
  bucket_domain_name = module.S3.bucket_domain_name
    
}

module "Route53" {
  source = "./modules/modules/Route53"
  domain_name = module.CDN.domain_name
  hosted_zone_id = module.CDN.hosted_zone_id
}
# /*module "ASG_fe" {
#     source = "../modules/ASG_fe"
#     project_name = module.vpc.project_name
#     pub_sub_1a_id = module.vpc.pub_sub_1a_id
#     ec2_public_sg_id = module.security-group.ec2_public_sg_id
#     alb_tg_arn_fe =  module.ALB_fe.alb_tg_arn_fe
#     instance_type = var.instance_type
#     ami = var.ami
#     asg_health_check_type = var.asg_health_check_type

# }*/