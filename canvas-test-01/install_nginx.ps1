Add-Type -AssemblyName System.IO.Compression.FileSystem
New-Item -ItemType Directory -Force -Path F:\nginx

$origin = "F:\nginx"
$url = "http://nginx.org/download/nginx-1.16.1.zip"
$output = "$origin\nginx-1.16.1.zip"
$path = "$origin\nginx-1.16.1"

Invoke-WebRequest -Uri $url -OutFile $output

Expand-Archive -Path $output -DestinationPath $origin -Force 
Set-Location $path
start .\nginx.exe

