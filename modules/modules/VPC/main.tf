# create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  enable_dns_support =  true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

# create internet gateway and attach it to vpc
# No need to Create Variable for IGW , cause we're not declaring any new variable for this.                                              
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "${var.project_name}-igw"
  }
}

# use data source to get all avalablility zones in region
#Fetch Availibility Zones from the specifed aws region - for that we use "data/data source" - as keyword
#u do not need to assign varibales for this, as we're not declairing 
data "aws_availability_zones" "azs" {}

# create public first public subnet 
resource "aws_subnet" "pub_sub_1a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.pub_sub_1a_cidr
  availability_zone = data.aws_availability_zones.azs.names[0]
  map_public_ip_on_launch = true #-- to get a Elastic Ip

  tags      = {
    Name    = "${var.project_name}-public-sub"
  }
}


#Create Public Route Table through internet_gateway in VPC  
resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"            #CIDR block of the route.
    gateway_id = aws_internet_gateway.internet_gateway.id   #Destination/egress of the public route to "Internet Gateway".
  }

  tags = {
    Name = "${var.project_name}-public-RT"
  }
}

#associate public subnet pub_sub_1a/az1 to "route table -> public-RT"
resource "aws_route_table_association" "pub_sub_1a_with_public-RT" {
    subnet_id = aws_subnet.pub_sub_1a.id
    route_table_id = aws_route_table.public-RT.id
  
}