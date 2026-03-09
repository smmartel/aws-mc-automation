# Create the Network (VPC)

resource "aws_vpc" "minecraft_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "minecraft-vpc"
    }
}

# Subnet for the server

resource "aws_subnet" "minecraft_subnet" {
  vpc_id = aws_vpc.minecraft_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true # Connect to the server from the internet

  availability_zone = "us-east-1a" # Specify the availability zone for the subnet. Adjust as needed.
    tags = {
        Name = "minecraft-subnet"
    }
}

# Internet Gateway and Route Table for internet access
resource "aws_internet_gateway" "minecraft_igw" {
  vpc_id = aws_vpc.minecraft_vpc.id
    tags = {
        Name = "minecraft-igw"
    }
}

# Route Table to allow internet access
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.minecraft_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft_igw.id
  }

    tags = {
        Name = "minecraft-rt"
    }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "association" {

  subnet_id = aws_subnet.minecraft_subnet.id
  route_table_id = aws_route_table.rt.id
  
}

