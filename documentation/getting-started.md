---
layout: default
title: Relax-and-Recover Quick Start
---

This quick start guide will show you how to run Relax-and-Recover from the git
checkout and create a bootable USB backup.


Start by cloning the Relax-and-Recover sources from GitHub:

Avoid that a non-root user controls what ReaR does (ReaR must run as root):
You should run "git clone" as root to ensure that ReaR's files (bash scripts)
in your local git clone directory are only under root's control
(i.e. with file owner root and without write permissions for a non-root user)
to avoid crossing a privilege boundary when running ReaR
from 'root' who runs ReaR to a non-root user who controls ReaR
which would happen when ReaR's files were downloaded as a non-root user.

    git clone https://github.com/rear/rear.git

Move into the rear/ directory:

    cd rear/

Prepare your USB media. Change /dev/sdb to the correct device in your situation.
Relax-and-Recover will 'own' the device in this example.

*This will destroy all data on that device.*

    sudo usr/sbin/rear format /dev/sdb

Relax-and-recover asks you to confirm that you want to format the device:

    Yes

The device has been labeled REAR-000 by the 'format' workflow.

Now edit the 'etc/rear/local.conf' configuration file:

    cat > etc/rear/local.conf <<EOF
    ### write the rescue initramfs to USB and update the USB bootloader
    OUTPUT=USB

    ### create a backup using the internal NETFS method, using 'tar'
    BACKUP=NETFS

    ### write both rescue image and backup to the device labeled REAR-000
    BACKUP_URL=usb:///dev/disk/by-label/REAR-000

    ### add this if you use Secure Boot
    SECURE_BOOT_BOOTLOADER=(/boot/efi/EFI/*/shimx64.efi)
    
    EOF

Now you are ready to create a rescue image. We want verbose output.

    sudo usr/sbin/rear -v mkrescue

The output I get is:

    Relax-and-Recover 1.13.0 / $Date$
    Using log file: /home/jeroen/tmp/quickstart/rear/var/log/rear/rear-fireflash.log
    Creating disk layout
    Creating root filesystem layout
    WARNING: To login as root via ssh you need to setup an authorized_keys file in /root/.ssh
    Copying files and directories
    Copying binaries and libraries
    Copying kernel modules
    Creating initramfs
    Writing MBR to /dev/sdb
    Copying resulting files to usb location

You might want to check the log file for possible errors or see what
Relax-and-Recover is doing.

Now reboot your system and try to boot from the USB device.

If that worked, you can dive into the advanced Relax-and-Recover options and
start creating full backups. If your USB device has enough space, initiate a
backup using:

    sudo usr/sbin/rear -v mkbackup

That is it. Your hard disk can now safely fail.
