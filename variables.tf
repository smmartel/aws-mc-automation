variable "admin_ip" {
  description = "Your home IP IN CIDR for SSH access"
  type = string

  validation {
    condition = can(regex("/", var.admin_ip))
    error_message = "admin_ip must be in CIDR format (e.g., x.x.x.x/32)."
  }
}

variable "minecraft_server_jar_url" {
  description = "Enter the URL to download the minecraft server jar file"
  type = string

  validation {
    condition = can(regex("^https?://", var.minecraft_server_jar_url))
    error_message = "minecraft_server_jar_url must be a valid HTTP or HTTPS URL."
  }
  
}