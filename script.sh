mv connect /usr/lib/ocf/resource.d/
chmod +x /usr/lib/ocf/resource.d/connect/*

pcs resource create ebs ocf:connect:ebs volume_id=${VOLMUME_ID} --group connect
pcs resource create vip ocf:connect:vip secondary_private_ip=${SECONDARY_PRIVATE_IP} netmask=${NATMASK} --group connect


# MariaDB
pcs resource create mariadb ocf:connect:mariadb --group connect
# Coordinator
pcs resource create coord ocf:connect:coord --group connect
# Karaf(e.g Message box)
pcs resource create karaf ocf:connect:karaf --group connect