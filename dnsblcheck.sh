#!/bin/bash

# Check IP addresses against dnsbl.tyutin.net
# IN: ip.list

for i in `cat ip.list | sort | uniq`; do
        O1=$(echo $i | cut -d '.' -f 1)
        O2=$(echo $i | cut -d '.' -f 2)
        O3=$(echo $i | cut -d '.' -f 3)
        O4=$(echo $i | cut -d '.' -f 4)

        RESULT=$(nslookup "$O4.$O3.$O2.$O1.dnsbl.tyutin.net" | grep 'Address:\|NXDOMAIN' | grep -v '#' | cut -d ':' -f 2)
        LISTED=$(echo $RESULT | grep -v NXDOMAIN | wc -l)

        echo -ne "$i;$LISTED;"
        if (( $LISTED == 1 )); then
                echo "LISTED"
        else
                echo "NOTLISTED"
        fi
done
