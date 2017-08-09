# RogueAP

A very basic configuration for setting up your own 'Rogue AP' 

Tested on a Mikrotik hAP lite (RB941-2nD) but likely to work on other 5+ port Mikrotiks with some changes

## Wired Interfaces

* **ether1** - 'Bridged' network, anything in ether1 will be sent out the Wifi and vice versa. Plug this into your upstream switch or router.
* **ether2** - 'NATd' network. Will request an IP via DHCP and NAT everything behind it. Blocks input (SSH etc) for security. Usefull for working around switch security.
* **ether3** - Not in use.
* **ether4** - Not in use.
* **ether5** - Management Port. This port will give you an IP via DHCP and allow you to access the route via SSH.

## Wireless Interfaces

* **Rogue One - Xhz** - Connects to bridged network
* **Rogue Two - Xhz** - Connects to NATd network

## Other

* You will need to add your own passwords
* Running a Rogue Access point is naughty
