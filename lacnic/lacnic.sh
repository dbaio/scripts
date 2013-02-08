#!/bin/sh
#
# Just a script to extract IPs from Brazil
# and generate a ignore IPs list for fail2ban
# It uses informations from lacnic.
# You could change it for get another country.
# 

curl -O ftp://ftp.lacnic.net/pub/stats/lacnic/delegated-lacnic-latest
grep BR delegated-lacnic-latest | grep ipv4 | awk -F "\|" '{print $4 "/" (32 - (log($5)/log(2)))}' > ips

# Country list
#cat delegated-lacnic-latest | grep ipv4 | awk -F '\|' '{ print $2 }' | sort -n | uniq

FAIL2BAN=""
for X in `cat ips`; do
	FAIL2BAN="${FAIL2BAN} ${X}"
done

echo "ignoreip =${FAIL2BAN}" > fail2ban.jail.conf

exit 0
