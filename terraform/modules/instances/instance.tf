resource "aws_eip_association" "eip_assoc" {
  count         = var.associate_eip ? 1 : 0
  instance_id   = aws_instance.instance.id
  allocation_id = var.eip
}

resource "aws_eip" "lb" {
count         = var.associate_eip ? 0 : 1
  instance = aws_instance.instance.id
  vpc      = true
}

resource "aws_instance" "instance" {
  ami           = var.AMI
  instance_type = var.INSTANCE_TYPE

  root_block_device {
    volume_size           = var.root_size
    encrypted = true
  }
  
  # the VPC subnet
  subnet_id = element(var.PUBLIC_SUBNETS, 0)

  # the security group
  vpc_security_group_ids = var.aws_sg_id

  # the public SSH key
  key_name = var.key_name

#  provisioner "remote-exec" {
#      inline = [  
#'powershell.exe $Path = $env:TEMP; $Installer = "chrome_installer.exe"; Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path\$Installer'
#]

  tags = var.Tags 
  
}

resource "aws_volume_attachment" "ext1" {
  #count    = var.volume != "" ? 1 : 0
  for_each = var.volume
  device_name = each.value.device_name
  volume_id = each.value.volume_id
  instance_id = aws_instance.instance.id
}

output "instance_id" {
  value = join("", aws_instance.instance.*.id)
}