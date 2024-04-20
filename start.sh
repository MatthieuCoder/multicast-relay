#!/bin/ash

echo "Assigning IP adresses using 10.60.<vlan>.254/24"

MTU=$(ip link show "${INTERFACES%%[ .]*}" | awk '{print $5}')
for IFNAME in $INTERFACES; do
    [ ! -d "/sys/class/net/$IFNAME" ] && {
        echo "Creating interface $IFNAME"
        ip link add link "${IFNAME%%.*}" \
             name "$IFNAME" mtu "$MTU" type vlan id "${IFNAME##*.}"
    }
    echo "Bringing up $IFNAME on vlan ${IFNAME##*.}"
    ip link set "$IFNAME" up
    echo "Using ip 10.60.${IFNAME##*.}.254/24 on $IFNAME"
    ip address add 10.60.${IFNAME##*.}.254/24 dev $IFNAME
done

echo "Starting multicast-relay"
echo "Using Interfaces:" $INTERFACES
echo "Using Options --foreground " $OPTS

python3 ./multicast-relay/multicast-relay.py --interfaces $INTERFACES --foreground $OPTS
