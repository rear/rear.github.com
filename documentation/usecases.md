---
layout: default
title: Relax-and-Recover use cases
---

## Relax-and-Recover use cases
This chapter will describe some use cases in more detail.

### Internal backup method using rsync and USB device
Suppose you want to use an USB device to store and boot the rescue image from. The very first time you want to use the USB device you need to format it (only required once of course). Therefore, connect the USB device and verify which block device name, e.g. /dev/sdb. To actual format the USB device type:

    # rear -v format /dev/sdb
    Relax-and-Recover 1.17.1 / Git
    Using log file: /var/log/rear/rear-ubuntu-15-04.log
    USB device /dev/sdb must be formatted with ext2/3/4 or btrfs file system
    Please type Yes to format /dev/sdb in ext3 format: Yes
    Repartition /dev/sdb
    Creating new ext3 filesystem on /dev/sdb1
    
Now, you need to edit the `/etc/rear/site.conf` configuration file (be aware, treat the configuration file as a bash script file) and add the following lines:

    BACKUP=NETFS
    OUTPUT=USB
    BACKUP_PROG=rsync
    BACKUP_URL=usb:///dev/disk/by-label/REAR-000
    
The last line (`BACKUP_URL=usb:///dev/disk/by-label/REAR-000`) references the USB device with its label (created by the format command). You could also use `BACKUP_URL=usb:///dev/sdb1` in our case, but a label makes it much clearer what the purpose is of the USB device, no?

To create a full backup of this system just type:

    # rear -v mkbackup
    Relax-and-Recover 1.17.1 / Git
    Using log file: /var/log/rear/rear-ubuntu-15-04.log
    Creating disk layout
    Creating root filesystem layout
    TIP: To login as root via ssh you need to set up /root/.ssh/authorized_keys or SSH_ROOT_PASSWORD in your configuration file
    Copying files and directories
    Copying binaries and libraries
    Copying kernel modules
    Creating initramfs
    Writing MBR to /dev/sdb
    Copying resulting files to usb location
    Encrypting disabled
    Creating rsync archive '/tmp/rear.ByJY9oowW7EG2wQ/outputfs/rear/ubuntu-15-04/20150825.0930/backup'
    Archived 1829 MiB [avg 3081 KiB/sec]OK
    Archived 1829 MiB in 609 seconds [avg 3075 KiB/sec]
    
When you do not specify a specific `OUTPUT_URL` definition then `OUTPUT_URL`=`BACKUP_URL`

The backup can be found on the USB device under `/<usb-mountpoint>/rear/$(hostname)/YYYYMMDD.HHMM/backup` directory. Be aware, these files are not encrypted so keep the USB devices in a fault to safe guard it from unauthorized people.


### Integration of EMC NetWorker with Relax-and-Recover
The EMC NetWorker (or also known as Legato) versions tested with Rear were v8.0.0.1 (and higher?) For brief sake from now on we will use the abbreviation *NSR* for EMC NetWorker. Rear can work with NSR since rear-1.15 and higher.
We assuming the Linux system is a NSR client that is capable of making a *full backup* towards the NSR server. Be aware, if you rely on an external backup solution to make full backups of your system make sure you have a full backup before trying out a recover via rear. That said, when using an external backup solution as NSR rear will *not* make any backup of the internal disks!

To use NSR as backup solution with rear just add the following in the `/etc/rear/site.conf` or `/etc/rear/local.conf` file:

    BACKUP=NSR

To verify that the basic requirements are met just run now:

    rear mkrescue

If rear is able to communicate with the NSR server it will create an ISO image named `/var/lib/rear/output/rear-$(hostname).iso` and you are done from the rear side. The ISO image will automatically being backed up to the NSR server by rear, so, in case of emergency you can always restore the ISO image to another computer to use it to recover this Linux system.

Just in case you are curious, you could have a look in the `/var/lib/rear/recovery/` directory. You will find there two files starting with `nsr_`

    nsr_server (contains the NSR server hostname)
    nsr_paths  (lists the mount points of file systems to restore via NSR)

To recover via NSR, then first of all boot from the ISO file created during the `mkrescue` phase and at the root prompt just type

    rear -v recover

That should be it, after a full restoration via NSR of all internal file systems, rear will make the disk bootable and keeps everything mount under `/mnt/local` for further inspection before rebooting.


### Integration of FDR/Upstream with Relax-and-Recover                              
Beginning with version 1.18, ReaR has support for FDR/Upstream.  To enable this support, add the following line to either `/etc/rear/local.conf` or `/etc/rear/site.conf`

    BACKUP=FDRUPSTREAM

If your FDR/Upstream software is installed somewhere other than the default location of /opt/fdrupstream, that should be specified as well:

    FDRUPSTREAM_INSTALL_PATH="/some/other/location"

ReaR does not perform FDR/Upstream backups.  ReaR is used to provide a working system to which an FDR/Upstream restore can be performed.  A sample workflow follows.

##### Preparations

On the target system (the system being backed up), edit `/etc/rear/local.conf`
or `/etc/rear/site.conf` to include:

    BACKUP=FDRUPSTREAM

On the target system, create a bootable ISO image with this command:
    /usr/sbin/rear -v mkrescue

Find the ISO image in `/var/lib/rear/output/` and put it someplace safe!  Store it offsite, or include it in your regular FDR/Upstream backups.

##### Disaster Recovery Time

On your disaster recovery hardware, boot the ISO image and follow the on-screen instructions.

The disaster recovery hardware will start FDR/Upstream and register to your storage server with the same name as the original target system.

When prompted, use FDR/Upstream Director to initiate a restore of the entire `/` filesystem to the `/mnt/local/` directory on the target system.

When the restore is complete, return to your disaster recovery hardware and hit <enter>.

Wait for ReaR to complete, and then reboot into your restored system.

