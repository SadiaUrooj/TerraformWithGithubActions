//STEP 1 : Create a VPC
resource "aws_vpc" "myvpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MyVPC"
    }
}
//STEP 2: Create a public subnet
resource "aws_subnet" "PublicSubnet"{
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.1.0/24"
}
//STEP 3: Create a private subnet
resource "aws_subnet" "PrivateSubnet"{
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true

}
//STEP 4: Create IGW - Internet Gate Way
//it's nessery to have an IGW inorder to have a internet connection to a public subnet
resource "aws_internet_gateway" "myIgw"{
    vpc_id = aws_vpc.myvpc.id
}

//STEP 5: Create route Table for public subnet
resource "aws_route_table" "PublicRouteTable"{
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIgw.id
    }
}
//STEP 7: Create route table association public subnet
resource "aws_route_table_association" "PublicRouteTableAssociation"{
    subnet_id = aws_subnet.PublicSubnet.id
    route_table_id = aws_route_table.PublicRT.id
}