# Proxmox

## Resources

* [Installation](https://pve.proxmox.com/wiki/Installation)
* [Zigbee dongle bug](https://github.com/Koenkk/zigbee2mqtt/discussions/24364)
* [Create a node cluster](#create-a-node-cluster)
* [Remove node from a cluster](#remove-node-from-a-cluster)

## Create a node cluster

To connect two nodes in Proxmox VE and create a cluster, follow these steps:

### Prerequisites

Before you start, make sure the following:

* Both nodes have unique names configured in /etc/hosts.
* Both nodes have static IP addresses on the same network.
* The SSH service runs on both nodes (ssh root@IP_OF_OTHER_NODE should connect without asking for a password if you use key authentication).
* Both nodes have the same version of Proxmox VE (pveversion -v).

### Configure /etc/hosts File on Both Nodes

Each node must be able to resolve the other's name. Edit /etc/hosts on both servers:

```bash
nano /etc/hosts
```

Add the IPs of both nodes (adjust according to your configuration):

```bash
192.168.1.100   node1.local  node1
192.168.1.101   node2.local  node2
```

Save and close (Ctrl + X, Y, Enter).

Prove that nodes resolve each other:

```bash
ping -c 3 nodo2
```
If it answers, it is correct.

### Create the Cluster on the First Node

On the master node (node1), run:
```bash
pvecm create my-cluster
```

* This will create a new cluster called “my-cluster”.
* You can verify that it has been created with:
```bash
pvecm status
```

### Joining the Second Node to the Cluster

On the second node (node2), use:
```bash
pvecm add node1.local
```
This will join node2 to the cluster controlled by node1.

Check the status of the cluster on any node:
```bash
pvecm nodes
```

## Remove node from a cluster
### Disaggregate the Node from the Cluster

On the node you want to remove, run the following command:
```bash
pvecm delnode NODE_NAME
```

This will remove the node configuration from the cluster and cause Proxmox to no longer consider it part of the cluster. Make sure to replace NODE_NAME with the actual name of the node.

For example, if the node is called node2, run:
```bash
pvecm delnode node2
```

### Stopping and Disabling Services on the Node to Remove

On the node you are removing, stop the Proxmox and Corosync services:

```bash
systemctl stop pve-cluster
systemctl stop corosync
```

This will stop the necessary services that are managing the cluster communication.

### Clean Configuration Files on the Node to be Removed

Now, delete the Corosync and PVE configuration files from the node you are removing. Run the following commands:

```bash
rm -rf /etc/corosync/*
rm -rf /var/lib/corosync/*
rm -rf /etc/pve/corosync.conf
rm -rf /etc/pve/nodes/*
rm -rf /var/lib/pve-cluster/*
```

This will ensure that all cluster-related files are removed from the node.

### Removing the Node from Shared Storage (If Applicable)

If the node you are removing has shared storage (for example, disks or network storage), make sure that it is no longer mounted or in use by other nodes. You can unmount the node's disks on the shared storage system (such as NFS or iSCSI).

For example:

```bash
umount /mnt/pve/[storage_name]
```

### Verify Node Removal

On the cluster's master node, verify that the node has been successfully removed:

```bash
pvecm nodes
```
The deleted node will no longer appear in the list of active nodes.

### Reboot Cluster Nodes

To ensure that all changes are applied correctly, you can reboot the remaining nodes in the cluster:

```bash
reboot
```
This will also ensure that the removed node is no longer present in the cluster and everything is working properly.
