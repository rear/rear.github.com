---
layout: default
title: About Relax-and-Recover
---

## Overview

Relax-and-Recover (abbreviated ReaR) is the de facto standard disaster recovery framework on Linux.

It is in particular used on enterprise Linux distributions like Red Hat Enterprise Linux (RHEL)
and SUSE Linux Enterprise Server (SLES).

ReaR is a system administrator tool and framework to create a bootable disaster recovery system image
for bare metal disaster recovery with data backup restore on physical or virtual replacement hardware.

For bare metal disaster recovery the ReaR recovery system is booted on pristine replacement hardware.
On replacement hardware first the storage setup/layout is recreated (disk partitioning, filesystems, mount points),
then a backup restore program is called to restore the data (system files) into the recreated storage,
and finally a boot loader is installed.

System administrators use the ReaR framework to set up a disaster recovery procedure
as part of their disaster recovery policy (which complements their existing backup policy).

ReaR complements backup and restore of data with bare metal disaster recovery. ReaR can also act as local backup software,
but ReaR is not a a backup management software. In many enterprise environmentments, data backup and restore happens via dedicated backup software which is integrated by ReaR and used to restore the data onto a replacement system as part of the automated disaster recovery procedure implemented by ReaR.

ReaR has support for built-in backup methods using 'tar' and 'rsync' that are used for backup and restore.

ReaR integrates supports the following 3rd party, also commercial, tools for restoring a backup.

The complete list of backup methods (`BACKUP=...`) is:

* `AVA` Dell EMC Avamar / EMC Avamar
* `BACULA` Bacula
* `BAREOS` [Bareos](https://docs.bareos.org/Appendix/DisasterRecoveryUsingBareos.html#linux)
* `BLOCKCLONE` block device cloning via `dd`
* `BORG` Borg Backup
* `CDM` Rubrik Cloud Data Management
* `DP` HP Data Protector
* `DUPLICITY` Duplicity / Duply
* `EXTERNAL` External custom restore method
* `FDRUPSTREAM` FDR/Upstream
* `GALAXY11` Commvault Galaxy 11 / Commvault Simpana
* `NBKDC` NovaStor DataCenter
* `NBU` Veritas NetBackup / Symantec NetBackup
* `NETFS` ReaR built-in backup and restore via `rsync` or `tar` to a network file system or to a locally attached backup disk (USB, eSATA, ...)
* `NFS4SERVER` NFS4 server to push data *to* the rescue system
* `NSR` Dell EMC NetWorker / EMC NetWorker / Legato NetWorker
* `OBDR` One Button Disaster Recovery via tape
* `PPDM` [Dell PowerProtect Data Manager](https://infohub.delltechnologies.com/en-us/t/simplifying-linux-bmr-for-powerprotect-data-manager-using-rear-relax-and-recover-disaster-recovery-solution/)
* `RBME` Rsync Backup Made Easy
* `REQUESTRESTORE` Request restore from a human operator
* `RSYNC` ReaR built-in backup using `rsync` via `rsync` or `ssh` protocol
* `SESAM` [SEP Sesam](https://wiki.sep.de/wiki/index.php/Bare_Metal_Recovery_Linux)
* `TSM` IBM Storage Protect / Tivoli Storage Manager / IBM Spectrum Protect
* `VEEAM` Veeam Backup

ReaR integrates well with Disaster Recovery Linux Manager (DRLM) [drlm.org](https://drlm.org), which can act as a central management tool for ReaR deployments.

## Features

Relax-and-Recover has a few interesting characteristics you may find useful
when assessing it as a Disaster Recovery or Bare Metal Restore solution:

* Modular design, written in Bash
  * easy to extend with custom functionality
  * targeted at sysadmins foremost

* Set up and forget nature
  * designed to be easy to setup
  * designed to require no maintenance _(e.g. cron integration, nagios monitoring)_

* Recovery image based on original distribution with original tools
  * recovery process remains compatible with original system and applications
  * hardware support is guaranteed

* Two-step recovery, with optional guided menus
  * disaster recovery process targeted at operational teams
  * migration process offers flexibility and control
  * fully unattended recovery possible for large scale deployments

* Bare metal recovery on different hardware
  * support for physical-to-virtual (P2V), virtual-to-physical (V2P)
  * support for physical-to-physical (P2P) and virtual-to-virtual (V2V)
  * various virtualization technologies supported (KVM, Xen, VMware)

* Support for various integrated boot media types, incl.
  * ISO
  * USB
  * eSATA
  * OBDR/bootable tape
  * PXE

* Support for various transport methods, incl.
  * HTTP
  * HTTPS
  * FTP
  * SFTP
  * NFS
  * CIFS (SMB)

* Extensive disk layout implementation, incl.
  * HWRAID (HP SmartArray)
  * SWRAID
  * LVM
  * multipathing
  * DRBD
  * iSCSI
  * LUKS (encrypted partitions and filesystems)

* Supports various 3rd party backup technologies
  * use backup tool of your choice
  * restore files from backup software, ReaR takes care of the rest and controls the entire process from bare metal boot to functioning new system
  * integrates with many commercial backup software
  * integrates with many Open Source backup software
  * with some tools, ReaR can also store the rescue media with the backup software

* Supports various built-in backup and restore methods
  * [tar](http://www.gnu.org/software/tar)
  * [rsync](http://rsync.samba.org)
  * restore via NFS4 Server running on rescue system

* Two phase disk layout recovery, allows reconfiguration before recovery, e.g.
  * migrations from e.g. SWRAID to HWRAID, or unencryped to encrypted partitions
  * HWRAID reconfigurations
  * migration from partitions to LVM

* Various techniques to help troubleshooting
  * structured log files and guided menus
  * log files are moved to recovery image, and to recovered system (available in every step for debugging)
  * advanced debugging options to help trace scripts or develop new functionality

* Integration with monitoring
  * examples for Nagios/Opsview

* Integration with scheduler
  * e.g. let cron recreate and transfer your images upon disk layout changes

* Various best practices to assist recovery
  * integrates with local bootloader
     _(in case it is still possible, you can restore from local disk through Grub)_
  * automatic network and ssh configuration
     _(for remote recovery)_
  * automatic serial console support
     _(useful for recovery through iLO or KVM serial console)_
  * shell history-stuffing
     _(stuff shell history with useful commands at every step)_
  * automatic recovery when possible, guided recovery when needed
