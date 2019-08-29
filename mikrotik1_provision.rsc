/ip address
add address=192.168.100.1/24 interface=ether2 network=192.168.100.0
/interface bridge
add name=bridgel2vpn
/interface eoip
add mac-address=02:E6:26:68:C4:47 name=eoip-tunnel1 remote-address=10.8.0.2 tunnel-id=0
/ip pool
add name=ovpn-pool ranges=10.8.0.2-10.8.0.10
/ppp profile
add local-address=10.8.0.1 name=ppp-ovpn remote-address=ovpn-pool use-encryption=required
/ppp secret
add name=l2vpn-1 password=l2vpn-password1 remote-address=10.8.0.2

/interface bridge port
add bridge=bridgel2vpn interface=ether3
add bridge=bridgel2vpn interface=eoip-tunnel1

/certificate add name=CA country="IT" state="IT" locality="PV" organization="Testingorg"  common-name="CA" key-size=4096 days-valid=3650 key-usage=crl-sign,key-cert-sign
/certificate sign CA ca-crl-host=127.0.0.1 name="CA"

/certificate add name=server country="IT" state="IT" locality="PV" organization="Testingorg"  common-name="server" key-size=4096 days-valid=3650 key-usage=digital-signature,key-encipherment,tls-server
/certificate sign server ca="CA" name="server"

/certificate add name=client country="IT" state="IT" locality="PV" organization="Testingorg"  common-name="client" key-size=4096 days-valid=3650 key-usage=tls-client
/certificate sign client ca="CA" name="client"

/certificate export-certificate CA export-passphrase=""
/certificate export-certificate client export-passphrase="12345678" 

/interface ovpn-server server
set certificate=server cipher=blowfish128,aes128,aes192,aes256 default-profile=ppp-ovpn enabled=yes keepalive-timeout=disabled require-client-certificate=yes

/ip firewall filter
add action=accept chain=input comment=OpenVPN dst-port=1194 protocol=tcp