---
layout: default
title: Relax-and-Recover FAQ
---

## Relax-and-Recover Frequently Asked Questions

### Upgrading Support

*Question:* rear upgrade fails via `rpm -U`

If you ever have this behavior you better first remove the old version with `rpm -e` and then do a fresh installation again with `rpm -ivh` or `yum install rear`

### Hardware support

### mkrescue support

*Question:* Not enough disk space available in /boot for GRUB rescue image?

If you see above error message then you can edit the `/etc/rear/local.conf` and add

    GRUB_RESCUE=

to avoid the rear generates a rescue image under the `/boot/grub` directory. By default,
rear is generating a rescue image and adding it to your grub configuration.

### General Questions

*Question:* cannot make pipe for command substitution: Too many open files

Your linux system linits the amount of open files for the user root to a default which is too low (usually 1024). You should increase it - see details in [issue #586](https://github.com/rear/rear/issues/586)

*Question:* How to create a bootable USB disk from an ISO image

Using the `BACKUP=NETFS` and `OUTPUT=ISO` method prodices an ISO image to boot from in rescue/rcover mode. However, suppose the system to recover (or clone) cannot use an ISO image to boot from, but does have an USB interface which could be used to boot from. The easiest way would be to copy the ISO image to an USB stick and boot from the USB stick, right?

How can we do this? You can use *UNetbootin* to accomplish this. Only a few steps are required:

    sfdisk /dev/sdd <<EOF
    ;
    EOF

    mkfs.vfat -F32 -n REAR-USB  /dev/sdd1

Pull and replug the USB stick. Verify it is mounted.

    unetbootin method=diskimage isofile=/path/to/[ISO].iso installtype=USB targetdrive=/dev/sdd1 autoinstall=yes

More information about unetbootin can be found at [http://sourceforge.net/p/unetbootin/wiki/commands/](http://sourceforge.net/p/unetbootin/wiki/commands/)

*Question:* Cannot create ISO image larger then 4 Gb

Indeed that is try by default setting within rear. We prefer to have smaller boot image on ISO. However, when combining the tar archive and rescue image on the same ISO then it could happen that 4 Gb is not enough. To solve this read [issue #581](https://github.com/rear/rear/issues/581)

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

*Question:* Can we force a static IP address with the rescue image?

Yes, even when you are currently using DHCP you can define the variable

    USE_STATIC_NETWORKING=1

in the configuration file `/etc/rear/local.conf`. You might also consider to define a static IP address in `/etc/rear/mappings/ip_addresses` (see previous question).


#### P2P

#### P2V

#### V2V

#### V2P

### Virtualization

#### Why use Relax-and-Recover in a virtualized setup ?
