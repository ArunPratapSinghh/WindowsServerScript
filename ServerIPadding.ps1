## New IP Details in Servers####


#Details of DHCP 
#Get-NetIPAddress |Where-Object{$_.PrefixOrigin -like 'DHCP'}|Select-Object IPAddress,AddressFamily,PrefixLength |Ft -AutoSize


#Assign new IP details to server

$Ethernet_Number ="Ethernet0"
$IPAddress="10.211.55.34"
$GatewayAddress="10.211.55.4"
$DNSDetails="127.0.0.1,8.8.8.8"

New-NetIPAddress -InterfaceAlias $Ethernet_Number  -ip $IPAddress -DefaultGateway $GatewayAddress  -AddressFamily IPv4 -PrefixLength 20
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $DNSDetails
