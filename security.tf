# Security Groups for EC2 instance

resource "aws_security_group" "minecraft_sg" {
    name        = "minecraft-sg"
    description = "Allow Minecraft traffic"
    vpc_id      = aws_vpc.minecraft_vpc.id

  ingress {
        from_port   = 25565
        to_port     = 25565
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Open to the world for Minecraft traffic
  
}
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" 
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "admin_sg" {
    name        = "admin-sg"
    description = "Allow SSH access from home IP"
    vpc_id      = aws_vpc.minecraft_vpc.id

  ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.admin_ip] # Only allow SSH from the specified admin IP
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" 
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}