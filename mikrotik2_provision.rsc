/ip address
add address=192.168.100.2/24 interface=ether2 network=192.168.100.0

/delay 5

/tool fetch address=192.168.100.1 src-path=/cert_export_CA.crt/ user=admin password="" mode=ftp dst-path=CA.crt port=21 host="" keep-result=yes
/tool fetch address=192.168.100.1 src-path=/cert_export_client.crt/ user=admin password="" mode=ftp dst-path=cert_export_client.crt port=21 host="" keep-result=yes
/tool fetch address=192.168.100.1 src-path=/cert_export_client.key user=admin password="" mode=ftp dst-path=cert_export_client.key port=21 host="" keep-result=yes

/certificate import file=CA.crt passphrase=""
/certificate import file=cert_export_client.crt passphrase="12345678"
/certificate import file=cert_export_client.key passphrase="12345678"

/interface ovpn-client add certificate=cert_export_client.crt_0 cipher=aes256 connect-to=192.168.100.1 mac-address=FE:C8:DA:61:DA:20 name=ovpn-out1 password=l2vpn-password1 user=l2vpn-1

/interface eoip
add mac-address=02:9F:E5:A1:23:D3 name=eoip-tunnel1 remote-address=10.8.0.1 tunnel-id=0

/interface bridge
add name=bridgel2vpn

/interface bridge port
add bridge=bridgel2vpn interface=ether3
add bridge=bridgel2vpn interface=eoip-tunnel1