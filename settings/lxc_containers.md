# Creating LXC Containers on Proxmox

To create LXC containers in our Proxmox environment, we will use the provided script as a base. This script automates the container creation process, ensuring consistency and ease of deployment.

```bash
#!/bin/bash

if [ "$#" -ne 9 ]; then
    echo "Use: $0 <ID> <HOSTNAME> <PASSWORD> <SSH_KEY> <DISK_SIZE> <CORES> <MEMORY> <IP> <GATEWAY>"
    exit 1
fi

ID=$1
HOSTNAME=$2
PASSWORD=$3
SSH_KEY=$4
DISK_SIZE=$5
CORES=$6
MEMORY=$7
IP=$8
GATEWAY=$9

pct create $ID local:vztmpl/debian-12-turnkey-core_18.1-1_amd64.tar.gz \
  --ostype debian --arch amd64 \
  --hostname $HOSTNAME --unprivileged 1 \
  --password $PASSWORD --ssh-public-keys "$SSH_KEY" \
  --storage local-lvm --rootfs volume=local-lvm:$DISK_SIZE \
  --cores $CORES \
  --memory $MEMORY --swap $MEMORY \
  --net0 name=eth0,bridge=vmbr0,firewall=1,ip=$IP,gw=$GATEWAY \
  --start false
```

## Usage

Run the script with the required parameters:

```bash
./create_lxc.sh <ID> <HOSTNAME> <PASSWORD> <SSH_KEY> <DISK_SIZE> <CORES> <MEMORY> <IP> <GATEWAY>
```

## Example 1: Creating a Pi-hole Container

To create an LXC container for Pi-hole, run the following command:

```bash
./create_lxc.sh 300 pihole "securepassword" "ssh-rsa AAA..." 5G 2 1024 192.168.1.2/24 192.168.1.1
```

## Example 2: Creating a Plex Container with Host Folder Sharing and GPU Passthrough

To create a Plex container with shared host folders and GPU access, use:

```bash
./create_lxc.sh 301 plex "securepassword" "ssh-rsa AAA..." 64G 4 4096 192.168.1.3/24 192.168.1.1
```

Then, edit the container configuration to add shared storage and GPU passthrough:

```bash
nano /etc/pve/lxc/301.conf
```

Add the following lines:

```bash
mp0: /volume1/folder,mp=/volume1/folder
dev0: /dev/dri/card0,gid=44
dev1: /dev/dri/renderD128,gid=104
```

Restart the container:

```bash
pct stop 301 && pct start 301
```

Now, Plex will have access to the media folder on the host and hardware-accelerated transcoding via the GPU.
You can install the Plex server using https://www.wundertech.net/how-to-install-plex-on-proxmox/
