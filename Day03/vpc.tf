

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}


// 01. Create VPC
resource "aws_vpc" "labvpc01" {
  //cidr_block = "10.0.0.0/16"
  cidr_block = var.lab_cidr01
  tags = {
   // Name = "labvpc01"
    Name = var.lab_vpc01
  }
}

//02. Create Internet Gateway  
resource "aws_internet_gateway" "labigw01" {
    tags = {
      Name = "Lab IGW 01"
    }
  
}


//03. Attach Internet Gateway to VPC.
resource "aws_internet_gateway_attachment" "IGW_VPC" {
  internet_gateway_id = aws_internet_gateway.labigw01.id
  vpc_id              = aws_vpc.labvpc01.id
}



//04. Create one public subnet per each zone.
//05. Create a public routing table and associate it with all public subnets.
resource "aws_route_table" "labroutetable" {
  vpc_id = aws_vpc.labvpc01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.labigw01.id
  }
  tags = {
    Name = "Lab_Public_RTB"
  }
}


// create subnets manual
# resource "aws_subnet" "mysubnet01" {
#  vpc_id = aws_vpc.labvpc01.id
#  availability_zone = "ap-southeast-1a"
#  cidr_block = "10.0.0.0/24"
#  tags = {
#    Name = "My Subnet01"
#  }
# }

// Create Subnets by using Variables
 resource "aws_subnet" "my_lab_subnet" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.labvpc01.id
  availability_zone = var.zone_for_subnets[count.index]
  cidr_block = var.cidr_for_subnets[count.index]
  tags = {
    Name = var.name_for_subnets[count.index]
  }
}

//Associate wit Public Route Table
resource "aws_route_table_association" "Lab_Public_RTB_Asso" {
    count = length(aws_subnet.my_lab_subnet)
    route_table_id = aws_route_table.labroutetable.id
    subnet_id = aws_subnet.my_lab_subnet[count.index].id
  
}