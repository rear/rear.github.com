---
layout: default
title: Relax-and-Recover FAQ
---

## Relax-and-Recover Frequently Asked Questions

### Hardware support

### Backup support

### System migrations

#### IP Migration

*Question:* Can we define a fixed IP address with a rescue image?

Yes, you can do the following on the production system (before you run `rear mkbackup`). Create a file `/etc/rear/mappings/ip_addresses` with the following content:

    eth0 192.268.1.100/24

Of course, replace the above IP address and cidr with your settings. You can also define `eth0  dhcp` to force DHCP when you boot with the rescue image.

There a second file `/etc/rear/mappings/routes` with the following content:

    default 192.168.1.1 eth0

As you can guess this is used to define the default gateway (also here replace the items with your settings).

And, if you forgot these files you can still define a fixed IP address when you boot up from the rescue image. You need to interrupt the automatic boot process and give some extra kernel options:

    ip=192.268.1.100 nm=255.255.255.0 gw=192.168.1.1 netdev=eth0

#### P2P

#### P2V

#### V2V

#### V2P

### Virtualization

#### Why use Relax-and-Recover in a virtualized setup ?
