---
layout: default
title: Relax-and-Recover usage
---

## Usage scenarios

### Recovery from USB

Prepare your rescue media using

    rear format /dev/sdX

It will be labeled REAR-000. The `/etc/rear/local.conf` can be as simple as:

    BACKUP=NETFS
    OUTPUT=USB
    OUTPUT_URL="usb:///dev/disk/by-label/REAR-000"

Run `rear -v mkbackup` to create the rescue media.

### Rescue system

Relax-and-Recover will automatically add itself to the Grub bootloader.
It copies itself to your `/boot` folder.

To disable this, add

    GRUB_RESCUE=

to your local configuration.

The entry in the bootloader is password protected. The default password is REAR.
Change it in your own `local.conf`

    GRUB_RESCUE_PASSWORD="SECRET"

### Storing on a central NFS server

The most straightforward way to store your DR images is using a central NFS
server. The configuration below will store both a backup and the rescue CD in a
directory on the share.

    OUTPUT=ISO
    BACKUP=NETFS
    BACKUP_URL="nfs://192.168.122.1/nfs/rear/"

### Backup integration

Relax-and-Recover integrates with various backup solutions. Your backup
software takes care of backing up all system files, Relax-and-Recover
recreates the filesystems and starts the file restore.

Currently Bacula, HP DataProtector, CommVault Galaxy, Symantec NetBackup and IBM
Tivoli Storage Manager are supported.

The following `local.conf` uses a USB stick for the rescue system. Multiple
systems can use the USB stick since the size of the rescue system is probably
less than 40M. It relies on your Bacula infrastructure to restore all files.

    BACKUP=BACULA
    OUTPUT=USB
    OUTPUT_URL="usb:///dev/disk/by-label/REAR-000"

### Monitoring integration

Relax-and-Recover integrates with your monitoring. The `rear checklayout`
command will tell you if the most recent rescue environment deviates from
your storage configuration (e.g. LVM changes, filesystem resized, ...)

In good Unix tradition `rear checklauout` returns 0 if your system is in
sync with your rescue image.  A return code of 1 should lead to a red
light in your monitoring screen because a new rescue image is needed. Create
a rescue image and the next time `rear checklayout` runs, it will return
0 again, and your monitoring will switch to green.

You can also automate the creation of rescue images by adding a cron job for
`/usr/sbin/rear checklayout || /usr/sbin/rear mkrescue`. And make sure the
`OUTPUT_URL` points to a central location for storing your rescue images.
