resource "aws_iam_role" "minecraft_role" {
  name = "minecraft-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  
}

resource "aws_iam_role_policy_attachment" "ssm_attachment" {
  role       = aws_iam_role.minecraft_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  
}

resource "aws_iam_instance_profile" "minecraft_profile" {
    name = "minecraft-instance-profile"
    role = aws_iam_role.minecraft_role.name
    
}

resource "aws_iam_role_policy" "stop_self_policy" {
  name = "AllowStopSelfPolicy"
  role = aws_iam_role.minecraft_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "ec2:StopInstances"
        Resource = "*"
      }
    ]
  })
}