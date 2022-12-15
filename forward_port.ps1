# Author benliao@qq.com
# If met security error, with Administrator PowerShell, Enter: set-executionpolicy remotesigned, and choose Y when prompt.

if ($Args.Length -lt 2){
    Write-Host "Usage: forward_port [host port] [wsl  port]"
    Exit 1
}

$host_port = $Args[0]
$wsl_port = $Args[1]

# DO NOT TRY to auto-get the wsl ip from wsl command, which gives messy output due to encoding issues.
# If you have multiple wsl distributions, you get the wsl ip address from "wsl -d <disto name> hostname -I" command manually.

#If only one wsl distribution, the following setting works fine.
$wsl_ip = "127.0.0.1"

# Forward wsl port
netsh interface portproxy add v4tov4 listenport=$host_port listenaddress=0.0.0.0 connectport=$wsl_port connectaddress=$wsl_ip

# open firewall
netsh advfirewall firewall add rule name="Allowing LAN connections" dir=in action=allow protocol=TCP localport=$host_port

# Finished.
Write-Host "Done!"