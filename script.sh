/usr/lib/ocf/resource.d/connect/ebs
/usr/lib/ocf/resource.d/connect/vip
/usr/lib/ocf/resource.d/connect/karaf
/usr/lib/ocf/resource.d/connect/mariadb
/usr/lib/ocf/resource.d/connect/coord

chmod +x /usr/lib/ocf/resource.d/connect/*

pcs resource create ebs ocf:connect:ebs volume_id=${VOLMUME_ID} --disabled
pcs resource create vip ocf:connect:vip secondary_private_ip=${SECONDARY_PRIVATE_IP} netmask=${NATMASK} --disabled
pcs constraint order start ebs then vip
pcs constraint colocation add vip with ebs

pcs resource create karaf ocf:connect:karaf --disabled
pcs constraint order start vip then karaf
pcs constraint colocation add karaf with ebs

pcs resource create mariadb ocf:connect:mariadb --disabled
pcs constraint order start vip then mariadb
pcs constraint colocation add mariadb with ebs

pcs resource create coord ocf:connect:coord --disabled
pcs constraint order start vip then coord
pcs constraint colocation add coord with ebs