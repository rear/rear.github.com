---
layout: default
title: Relax-and-Recover project
---

## About Relax-and-Recover

Relax-and-Recover has a few interesting characteristics you may find useful when assessing
it as a Disaster Recovery solution:

 * Modular design, written in Bash
   * easy to extend with custom functionality
   * targetted at sysadmins first, developers second

 * Set up and forget nature
   * designed to be easy to setup _(Relax-and-Deploy!)_
   * designed to require no maintenance _(new images through cron job)_

 * Recovery image based on original distribution with original tools
   * recovery process remains compatible with original system and applications
   * hardware support is guaranteed

 * Two-step recovery, and optional guided menus
   * disaster recovery process targetted at operational teams
   * migration process offers flexibility and control

 * Bare metal recovery on dissimilar hardware
   * Support for physical-to-virtual (P2V), virtual-to-physical (V2P)
   * Support for physical-to-physical (P2P) and virtual-to-virtual (V2V)
   * Various virtualization options supported (KVM, Xen, VMware)

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
   * CIFS

 * Extensive disk layout implementation, incl.
   * HWRAID (HP SmartArray)
   * SWRAID
   * LVM
   * multipathing
   * DRBD
   * iSCSI
   * LUKS (encrypted partitions and filesystems)

 * Supports various backup technologies, incl.
   * HP DataProtector
   * IBM Tivoli Storage Manager (TSM)
   * Symantec NetBackup
   * CommVault Galaxy
   * Bacula
   * tar
   * rsync

 * Two phase disk layout recovery, allows reconfiguration before recovery, e.g.
   * migrations from eg. SWRAID to HWRAID, or unencryped to encrypted partitions
   * HWRAID reconfigurations
   * migration from partitions to LVM

 * Various techniques to help troubleshooting
   * structured log files and guided menus
   * log files are moved to recovery image, and to recovered system (available in every step for debugging)
   * advanced debugging options to help trace scripts or develop new functionality

 * Integration with monitoring (examples for Nagios/Opsview)

 * Integration with scheduler
   _(e.g. let cron recreate and transfer your images upon disk layout changes)_

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
