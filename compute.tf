resource "aws_instance" "minecraft_server" {
  ami = data.aws_ami.amazon_linux.id # Use the Amazon Linux 2023 AMI
  instance_type = "t3.small" # Small has 2GB ram can be scaled up depending on needs
  subnet_id = aws_subnet.minecraft_subnet.id
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]
  associate_public_ip_address = true # Connect to the server from the internet
  iam_instance_profile = aws_iam_instance_profile.minecraft_profile.name


  user_data = templatefile("${path.module}/install_script.sh.tpl", {
    minecraft_server_jar_url = var.minecraft_server_jar_url
  })

  tags = {
    Name = "minecraft-server"
  }
}