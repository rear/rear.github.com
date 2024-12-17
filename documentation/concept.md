---
layout: default
title: Relax-and-Recover concepts
---

## The Workflow System

Rear is built as a modular framework. A call of *rear command* will invoke
the following general workflow:

  1. *Configuration:* Collect system information to assemble a correct
     configuration (default, arch, OS, OS_ARCH, OS_VER, site, local).
     See the output of *rear dump* for an example.
     read 'default.conf' first and 'site.conf', 'local.conf' last.

  2. Create work area in '/var/tmp/rear.$$/' and start logging to
     '/var/log/rear/rear-hostname.log'

  3. Run the workflow script for the specified command:
     '/usr/share/rear/lib/*command*-workflow.sh'

  4. Cleanup work area

## Workflow Make Rescue Media

The application will have the following general workflow which is represented
by appropriately named scripts in various subdirectories:

  1. *Prep:* Prepare the build area by copying a skeleton filesystem layout.
     This can also come from various sources (FS layout for arch, OS, OS_VER,
     Backup-SW, Output, ...)

  2. *Save layout*: Analyse the system to create the '/var/lib/rear/layout' data

  3. *Analyse (Rescue):* Analyse the system to create the rescue system
     (network, binary dependancies, ...)

  4. *Build:* Build the rescue image by copying together everything required

  5. *Pack:* Package the kernel and initrd image together

  6. *Backup:* (Optionally) run the backup sowftware to create a current backup

  7. *Output:* Copy / Install the rescue system (kernel+initrd+(optionally)
     backups) into the target environemnt (e.g. PXE boot, write on tape,
     write on CD/DVD)

  8. *Cleanup:* Cleanup the build area from temporary files

The configuration must define the *BACKUP* and *OUTPUT* methods. Some valid choices are:

    |NAME        | TYPE    | Description                              | Implement in Phase
    +------------+---------+------------------------------------------+-------------------
    |NETFS       | BACKUP  | Copy files to NFS, CIFS share            | OK
    |TAPE        | BACKUP  | Copy files to tape(s)                    | OK
    |CDROM       | BACKUP  | Copy files to ISO image                  | OK
    |NSR         | BACKUP  | Use Legato Networker                     | OK
    |TSM         | BACKUP  | Use Tivoli Storage Manager               | OK
    |DP          | BACKUP  | Use OpenText Data Protector              | OK
    |BACULA      | BACKUP  | Use opensource Bacula                    | OK
    |FDRUPSTREAM | BACKUP  | Use FDR/Upstream                         | OK
    | ...        | BACKUP  | (see default.conf for full list)         |
    |            |         |                                          |
    |ISO         | OUTPUT  | Write result to ISO9660 image            | OK
    |CDROM       | OUTPUT  | Write result to CD/DVD                   | on request
    |OBDR        | OUTPUT  | Create OBDR Tape                         | OK
    |PXE         | OUTPUT  | Create PXE bootable files on TFTP server | OK
    |USB         | OUTPUT  | Create bootable USB device               | OK

## Workflow Recovery

The result of the analysis is written into configuration files under
'/var/lib/rear/recovery/'. This directory is copied together with the other
Rear directories onto the rescue system where the same framework runs
a different workflow the recovery workflow.

The recovery workflow is triggered by the fact that the root filesystem is
mounted in a ram disk or tmpfs. Alternatively a demo recovery workflow
can be started manually. This will simply recover all data into a
subdirectory and not touch the hard disks.

The *recovery workflow* consists of these parts (identically named modules
are indeed the same):

  1. *Config:* By utilizing the same configuration module, the same
     configuration variable are available for the recovery, too.
     This makes writing pairs of backup/restore modules much easier.

  2. *Verify:* Verify the integrity and sanity of the recovery data and
     check the hardware found to determine, wether a recovery will be
     likely to suceed. If not, then we abort the workflow so as not to
     touch the hard disks if we don't believe that we would manage to
     successfully recover the system on this hardware.

  3. *Recreate:* Recreate the FS layout (partitioning, LVM, raid,
     filesystems, ...) and mount it under /mnt/local

  4. *Restore:* Restore files and directories from the backup to '/mnt/local/'.
     This module is the analog to the Backup module

  5. *Finalize:* Install boot loader, finalize system, dump recovery log
     onto '/var/log/rear/' in the recovered system.

## FS layout

Rear tries to be as much LSB complient as possible. Therefore rear will be
installed into the usual locations:

- */etc/rear/*: Local Configuration files

- */usr/sbin/rear*: Main program

- */usr/share/rear/*: Internal scripts

- */var/lib/rear/*: Recovery and disk and file system layout information

- */var/log/rear/*: Log file of rear is kept here

- */tmp/rear.$$/*: Build area (will be removed by default, use option '-d' to keep)

### Layout of /usr/share/rear/conf

- *default.conf*: Default configuration will define EVERY variable with a sane default
    setting. Serves also as a reference for the available variables 'site.conf'
    site wide configuration (optional)

- *$(uname -s)-$(uname -i).conf*: architecture specific configuration (optional)

- *$(uname -o).conf*: OS system (e.g. GNU/Linux.conf) (optional)

- *$OS/$OS_VER.conf*: OS and OS Version specific configuration (optional)

- *templates/*: Directory to keep user-changeable templates for various files used
    or generated

- *templates/PXE_per_node_config*: template for pxelinux.cfg per-node configurations

- *templates/CDROM_isolinux.cfg*: isolinux.cfg template

- *templates/...*: other templates as the need arises

### Layout of /etc/rear

- *local.conf*: local machine configuration (optional). Remember, only redefine variables which you need. The KISS principle is always a save choice.

- *site.conf*: local site configuration (optional). Rear will never overwrite or remove a *site.conf* file, so it is a safe way to survive rear upgrades.

- *rescue.conf*: Rescue configuration file which is created during the 'mkrescue' or 'mkbackup' phase. You should never need to modify this configuration file.

- *mappings/...*: Re-map information such as IP addresses

### Layout of /var/lib/rear

- *layout/*: Information on disk partitioning and file system layout

- *output/*: The ISO9660 image or PXE files are kept here

- *recovery/*: Recovery information such as initrd modules, mount points are kept here

### Layout of /usr/share/rear

- *skel/default/*: default rescue FS skeleton

- *skel/$(uname -i)/*: arch specific rescue FS skeleton (optional)

- *skel/$OS_$OS_VER/*: OS-specific rescue FS skeleton (optional)

- *skel/$BACKUP/*: Backup-SW specific rescue FS skeleton (optional)

- *skel/$OUTPUT/*: Output-Method specific rescue FS skeleton (optional)

- *lib/\*.sh*: function definitions, split into files by their topic

- *prep/default/\*.sh*:

- *prep/$(uname -i)/\*.sh*:

- *prep/$OS_$OS_VER/\*.sh*:

- *prep/$BACKUP/\*.sh*:

- *prep/$OUTPUT/\*.sh*:
    Prep scripts. The scripts get merged from the applicable directories
    and executed in their alphabetical order. Naming conventions are:

    xx_name.sh
    where 00 < xx < 99

- *layout/save/default/\*.sh*:

- *layout/save/$(uname -i)/\*.sh*:

- *layout/save/$OS_OS_VER/\*.sh*:
    Save layout scripts. The scripts get merged from the applicable directories
    and executed in their alphabetical order. Naming conventions are:

    xx_name.sh
    where 00 < xx < 99


- *rescue/...*:
    Analyse-Rescue scripts ...

- *build/...*:
    Build scripts ...

- *pack/...*:
    Pack scripts ...

- *backup/$BACKUP/\*.sh*:
    Backup scripts ...

- *output/$OUTPUT/\*.sh*:
    Output scripts ...

- *verify/...*:
    Verify the recovery data against the hardware found, wether we can
    successfully recover the system

- *recreate/...*:
    Recreate file systems and their dependancies

- *restore/$BACKUP/...*:
    Restore data from backup media

- *finalize/...*:
    Finalization scripts

## Inter-module communication

The various stages and modules communicate via standarized environment variables:

    |NAME             |TYPE         |Descriptions                         |Example
    +-----------------+-------------+-------------------------------------+-------------------------
    |CONFIG_DIR       |STRING (RO)  |Configuration dir                    |'/etc/rear/'
    |SHARE_DIR        |STRING (RO)  |Shared data dir                      |'/usr/share/rear/'
    |BUILD_DIR        |STRING (RO)  |Build directory                      |'/tmp/rear.$$/'
    |ROOTFS_DIR       |STRING (RO)  |Root FS directory for rescue system  |'/tmp/rear.$$/initrd/'
    |PROGS            |LIST         |Program files to copy                |bash ip route grep ls ...
    |MODULES          |LIST         |Modules to copy                      |af_unix e1000 ide-cd ...
    |COPY_AS_IS       |LIST         |Files (with path) to copy as-is      |'/etc/localtime' ...
    |....

RO means that the framework manages this variable and modules and methods shouldn't change it.

### Config

Small user config in /etc/rear/local.conf for personal settings.

Use /etc/rear/site.conf to deliver ReaR configuration via configuration management automation, this file will never be shipped by a ReaR package.
