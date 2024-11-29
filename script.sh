pcs resource create ebs ocf:connect:ebs volume_id=${VOLMUME_ID} --disabled
pcs resource create vip ocf:connect:vip secondary_private_ip=${SECONDARY_PRIVATE_IP} netmask=${NATMASK} --disable
pcs constraint order start ebs then vip
pcs constraint colocation add vip with ebs

pcs resource create karaf ocf:connect:karaf --disabled
pcs constraint order start vip then karaf
pcs constraint colocation karaf with ebs

pcs resource create mariadb ocf:connect:mariadb --disabled
pcs constraint order start vip then mariadb
pcs constraint colocation mariadb with ebs