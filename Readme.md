Mikrotik lab: openvpn with eoip and layer2 bridging for stretched lan implementation

client1 and client2 vm are in different and isolated network segments but with the same network subnet, after powering on and configuring the two mikrotik instances (mikrotik1 and mikrotik2) the clients will communicate

Scripts will provision the openvpn and eoip config, they will automatically bridge interfaces

mikrotik.rb from https://github.com/cheretbe/vagrant-files/blob/master/host-scripts/common.rb uploads and executes a script 