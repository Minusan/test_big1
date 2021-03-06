Add-Type -AssemblyName System.IO.Compression.FileSystem
#Initialize Partition
Get-Disk -FriendlyName "Msft Virtual Disk" | Initialize-Disk -PartitionStyle MBR
New-Partition -DiskNumber 2 -DriveLetter F -UseMaximumSize
Format-Volume -DriveLetter F -FileSystem NTFS
#install nginx
New-Item -ItemType Directory -Force -Path F:\nginx
$origin = "F:\nginx"
$url = "http://nginx.org/download/nginx-1.16.1.zip"
$output = "$origin\nginx-1.16.1.zip"
$path = "$origin\nginx-1.16.1"
Invoke-WebRequest -Uri $url -OutFile $output
Expand-Archive -Path $output -DestinationPath $origin -Force 
Set-Location $path
start .\nginx.exe
#create Nginx as a service
New-Item -ItemType Directory -Force -Path "C:\nssm\"
Invoke-WebRequest -Uri "http://nssm.cc/release/nssm-2.24.zip" -OutFile "C:\nssm\nssm-2.24.zip"
Expand-Archive -Path "C:\nssm\nssm-2.24.zip" -DestinationPath 'C:\nssm'
Start-Process -FilePath C:\nssm\nssm-2.24\win64\nssm.exe -ArgumentList "install nginx F:\nginx\nginx-1.16.1\nginx.exe"
#Create Firewall rule
New-NetFirewallRule -Name HTTP -DisplayName HTTP -Action Allow -Protocol TCP -LocalPort 80
New-NetFirewallRule -Name HTTPS -DisplayName HTTP -Action Allow -Protocol TCP -LocalPort 443
New-NetFirewallRule -Name nginxTCP -DisplayName nginxTCP -Action Allow -Profile Any -Protocol TCP -Program "F:\nginx\nginx-1.16.1\nginx.exe"
New-NetFirewallRule -Name nginxUDP -DisplayName nginxUDP -Action Allow -Profile Any -Protocol TCP -Program "F:\nginx\nginx-1.16.1\nginx.exe"
New-NetFirewallRule -Name FlashApp -DisplayName FlaskApp -Action Allow -Protocol TCP -LocalPort 10280

#Prepare for anisble
New-Item -Path "c:\" -Name "temp" -ItemType "directory"
Set-Location -Path C:\temp
$hostname = $env:COMPUTERNAME
$cert = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname $hostname | Select-Object -Property Thumbprint
$cert = Get-ChildItem -path cert:\LocalMachine\My -DnsName $env:COMPUTERNAME | Select-Object -Property Thumbprint
$thumb = $cert.thumbprint
$2ndhostname = """$hostname"""
$2thumb = """$thumb"""
$1ststring = 'winrm create winrm/config/listener?Address=*+Transport=HTTPS @{Hostname='
$2ststring = ';CertificateThumbprint='
$3rdstring = ';Port="5986"}'
Out-File -FilePath C:\temp\addcertificate.bat -NoNewline -InputObject $1ststring,$2ndhostname,$2ststring,$2thumb,$3rdstring -Encoding ASCII
cmd /C C:\temp\addcertificate.bat
Invoke-WebRequest -Uri https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 -OutFile c:\temp\ConfigureRemotingForAnsible.ps1
& "c:\temp\ConfigureRemotingForAnsible.ps1"
#preparte for PRTG
Install-WindowsFeature -Name SNMP-Service
Install-WindowsFeature -Name RSAT-SNMP
Install-WindowsFeature -name Web-Server,Web-CGI -IncludeManagementTools

#install Chrome
$Path = $env:TEMP
$Installer = "chrome_installer.exe"
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $Path\$Installer -Force
#set account password not to expire
Set-LocalUser -Name sustadmin -PasswordNeverExpires 1
exit