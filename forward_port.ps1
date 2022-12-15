# Author benliao@qq.com
# If met security error, with Administrator PowerShell, Enter: set-executionpolicy remotesigned, and choose Y when prompt.

# Argument 0 as forward port

if ($Args.Length -lt 1){
    Write-Host "Usage: forward_port [port number]"
    Exit 1
}

$forward_port = $Args[0]

# Find wsl host ip
$wsl_dists =  wsl -l -v | Select-Object -Index 2
$dist_array = $wsl_dists.Split(" ")
$dist_array[1]

$wsl_ip = wsl -d $dist_array[1] hostname -I

# Forward wsl port
netsh interface portproxy add v4tov4 listenport=$forward_port listenaddress=0.0.0.0 connectport=$forward_port connectaddress=$wsl_ip

# open firewall
netsh advfirewall firewall add rule name="Allowing LAN connections" dir=in action=allow protocol=TCP localport=3000

# Finished.
Write-Host "Done!"