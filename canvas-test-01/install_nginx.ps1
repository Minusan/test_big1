Add-Type -AssemblyName System.IO.Compression.FileSystem
New-Item -ItemType Directory -Force -Path C:\nginx

$origin = "C:\nginx"
$url = "http://nginx.org/download/nginx-1.16.1.zip"
$output = "$origin\nginx-1.16.1.zip"
$path = "$origin\nginx-1.16.1"

Invoke-WebRequest -Uri $url -OutFile $output

Expand-Archive -Path $output -DestinationPath $origin -Force 
Set-Location $path
start .\nginx.exe
#Create Firewall rule
New-NetFirewallRule -Name HTTP -DisplayName HTTP -Action Allow -Protocol TCP -LocalPort 80
New-NetFirewallRule -Name HTTPS -DisplayName HTTP -Action Allow -Protocol TCP -LocalPort 443
#Initialize Partition
Get-Disk -FriendlyName "Msft Virtual Disk" | Initialize-Disk -PartitionStyle MBR
New-Partition -DiskNumber 2 -DriveLetter G -UseMaximumSize
Format-Volume -DriveLetter G -FileSystem NTFS
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
exit