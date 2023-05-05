//STEP 1 : Create a VPC
resource "aws_vpc" "myvpc"{
    cidr_block = "10.0.0.0/16"
    tages={
        Name="MyTerraformVPC"
    }
}
//STEP 2: Create a public subnet
resource "aws_subnet" "PublicSubnet"{
    vcp_id=aws_vcp.myvcp.vcp_id
    cidr_block="10.0.0.0/24"
}
//STEP 3: Create a private subnet
resource " aws_subnet" "PrivateSubnet" {
    vcp_id = aws_vcp.myvcp.vcp_id
    cidir_block="10.0.2.0/24"
  
}
//STEP 4: Create IGW - Internet Gate Way
//it's nessery to have an IGW inorder to have a internet connection to a public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vcp.myvcp.id
}

//STEP 5: Create route Table for public subnet
resource "aws_route_table" "PublicRouteTable" {
  vcp_id=aws_vcp.myvcp.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
//STEP 7: Create route table association public subnet
resource "aws_route_table_association" "PublicRouteTableAssocoation" {
  subnet_id = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.PublicRouteTable.id
}