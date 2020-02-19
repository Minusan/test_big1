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
New-NetFirewallRule -Name HTTP -DisplayName HTTP -Action Allow -Protocol TCP -LocalPort 80
New-NetFirewallRule -Name HTTPS -DisplayName HTTP -Action Allow -Protocol TCP -LocalPort 443
exit