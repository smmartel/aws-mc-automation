output "minecraft_server_ip" {
  description = "The public IP address of the Minecraft Server"
  value = aws_instance.minecraft_server.public_ip
}
