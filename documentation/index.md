---
layout: default
title: Relax-and-Recover documentation
---

## Relax-and-Recover documentation
The Relax-and-Recover documentation is being revised and updated.

### Getting Started

This quick start guide will show you how to run Relax-and-Recover from the git
checkout and create a bootable USB backup.

Start by cloning the Relax-and-Recover sources from Github:

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
start creating full backups. If you USB devices has enough space, initiate a
backup using:

    sudo usr/sbin/rear -v mkbackup

That is it. Your hard disk can now safely fail.

### Under construction

This page will consists of links to:

 - [Relax-and-Recover Manual](https://github.com/rear/rear/blob/master/doc/rear.8.asciidoc)

 - Relax-and-Recover Release Notes

   * [Relax-and-Recover Release Notes 1.17.1](http://relax-and-recover.org/documentation/release-notes-1-17)
   * [Relax-and-Recover Release Notes 1.16.1](http://relax-and-recover.org/documentation/release-notes-1-16)
   * [Relax-and-Recover Release Notes 1.15.0](http://relax-and-recover.org/documentation/release-notes-1-15)
   * [Relax-and-Recover Release Notes 1.14.0](http://relax-and-recover.org/documentation/release-notes-1-14)

 - [Relax-and-Recover User Guide](https://github.com/rear/rear/blob/master/doc/user-guide/relax-and-recover-user-guide.asciidoc)

   1. [Introduction](https://github.com/rear/rear/blob/master/doc/user-guide/01-introduction.asciidoc)
   2. [Getting started](https://github.com/rear/rear/blob/master/doc/user-guide/02-getting-started.asciidoc)
   3. [Configuration](https://github.com/rear/rear/blob/master/doc/user-guide/03-configuration.asciidoc)
   4. [Scenarios](https://github.com/rear/rear/blob/master/doc/user-guide/04-scenarios.asciidoc)
   5. [Integration](https://github.com/rear/rear/blob/master/doc/user-guide/05-integration.asciidoc)
   6. [Layout configuration](https://github.com/rear/rear/blob/master/doc/user-guide/06-layout-configuration.asciidoc)
   7. [Tips and Tricks](https://github.com/rear/rear/blob/master/doc/user-guide/07-tips-and-tricks.asciidoc)
   8. [Troubleshooting](https://github.com/rear/rear/blob/master/doc/user-guide/08-troubleshooting.asciidoc)
   9. [Design concepts](https://github.com/rear/rear/blob/master/doc/user-guide/09-design-concepts.asciidoc)

 - Other documentation not integrated into the User Guide yet

   * [Concept](http://relax-and-recover.org/documentation/concept)
   * [Installation](http://relax-and-recover.org/documentation/installation)
   * [Use cases](http://relax-and-recover.org/documentation/usecases)
   * Best practices

 - [Relax-and-Recover FAQ](http://relax-and-recover.org/documentation/faq)

 - Relax-and-Recover presentations

 - External Links

   * [Linux Disaster Recovery mit Relax-and-Recover und EMC Networker (in German)](http://backupinferno.de/?p=358)
   * [Linux Disaster Recovery with Relax-and-Recover und SEP sesam](http://wiki.sepsoftware.com/wiki/index.php/Disaster_Recovery_for_Linux_3.0_en)

