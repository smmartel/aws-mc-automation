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
    tags = {
        Name = "minecraft-subnet"
    }
}