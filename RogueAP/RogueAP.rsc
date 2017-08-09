/interface bridge
add name="LAN Bridge (NAT)"
add name="LAN Bridge (No NAT)" protocol-mode=none
/interface ethernet
set [ find default-name=ether1 ] name="01 - Bridged LAN"
set [ find default-name=ether2 ] name="02 - NATd LAN"
set [ find default-name=ether3 ] name="03 - Not in use"
set [ find default-name=ether4 ] name="04 - Not in use"
set [ find default-name=ether5 ] name="05 - Management"
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n channel-width=20/40mhz-Ce country="united kingdom" disabled=no mode=ap-bridge name="Rogue One - 2.4Ghz (No NAT)" ssid="Rogue One - 2.4Ghz"
set [ find default-name=wlan2 ] band=5ghz-a/n/ac channel-width=20/40mhz-Ce country="united kingdom" disabled=no mode=ap-bridge name="Rogue One - 5Ghz (No NAT)" ssid="Rogue One - 5Ghz"
add disabled=no mac-address=6C:3B:6B:71:BE:51 master-interface="Rogue One - 2.4Ghz (No NAT)" mode=ap-bridge name="Rogue Two - 2.4Ghz (NAT)" ssid="Rogue Two - 2.4Ghz"
add disabled=no mac-address=6C:3B:6B:71:BE:50 master-interface="Rogue One - 5Ghz (No NAT)" mode=ap-bridge name="Rogue Two - 5Ghz (NAT)" ssid="Rogue Two - 5Ghz"
/interface list
add name=LAN
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk mode=dynamic-keys supplicant-identity=MikroTik wpa-pre-shared-key=[PASSWORD] wpa2-pre-shared-key=[PASSWORD]
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
/ip pool
add name="LAN Bridge (NAT)" ranges=192.168.23.21-192.168.23.254
add name=Management ranges=192.168.1.21-192.168.1.254
/ip dhcp-server
add address-pool="LAN Bridge (NAT)" disabled=no interface="LAN Bridge (NAT)" name="DHCP - LAN Bridge (NAT)"
add address-pool=Management disabled=no interface="05 - Management" name="DHCP - Management"
/interface bridge port
add bridge="LAN Bridge (No NAT)" interface="01 - Bridged LAN"
add bridge="LAN Bridge (No NAT)" interface="Rogue One - 2.4Ghz (No NAT)"
add bridge="LAN Bridge (No NAT)" interface="Rogue One - 5Ghz (No NAT)"
add bridge="LAN Bridge (NAT)" interface="Rogue Two - 2.4Ghz (NAT)"
add bridge="LAN Bridge (NAT)" interface="Rogue Two - 5Ghz (NAT)"
/interface list member
add interface="LAN Bridge (NAT)" list=LAN
add interface="LAN Bridge (No NAT)" list=LAN
/ip address
add address=192.168.23.1 interface="LAN Bridge (NAT)" network=192.168.23.1
add address=192.168.1.1 interface="05 - Management" network=192.168.1.1
/ip dhcp-client
add dhcp-options=hostname,clientid disabled=no interface="02 - NATd LAN"
/ip dhcp-server network
add address=192.168.1.0/24 dns-server=192.168.1.1 gateway=192.168.1.1
add address=192.168.23.0/24 dns-server=192.168.23.1 gateway=192.168.23.1
/ip dns
set allow-remote-requests=yes
/ip firewall filter
add action=accept chain=forward connection-state=established
add action=accept chain=forward out-interface="02 - NATd LAN"
add action=accept chain=input connection-state=established
add action=accept chain=input in-interface="05 - Management" port=22 protocol=tcp
add action=accept chain=input in-interface-list=LAN port=53 protocol=udp
add action=drop chain=forward
add action=drop chain=input
/ip firewall nat
add action=masquerade chain=srcnat out-interface="02 - NATd LAN"
/ip firewall service-port
set ftp disabled=yes
set tftp disabled=yes
set irc disabled=yes
set h323 disabled=yes
set sip disabled=yes
set pptp disabled=yes
set udplite disabled=yes
set dccp disabled=yes
set sctp disabled=yes
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set winbox disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=Europe/London
/system identity
set name="Rogue AP"
/system ntp client
set enabled=yes
/system routerboard settings
set init-delay=0s
/tool mac-server
set [ find default=yes ] interface="05 - Management"
