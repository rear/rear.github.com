---
layout: default
title: Rear project
---

## About Relax and Recover ##

Rear has a few interesting characteristics you may find useful when assessing
it as a Disaster Recovery solution:

 * Modular design, written in Bash
   _(makes it possible to extend it with custom functionality)_

 * Simple to setup, requires no maintenance _(set up and forget nature)_

 * Two step recovery, and optional guided menus

 * Support for various integrated media types
   _(incl. ISO, USB, eSATA, OBDR/bootable tape, PXE)_

 * Support for various transport methods
   _(incl. HTTP, HTTPS, FTP, SFTP, NFS, CIFS, ...)_

 * Extensive disk layout implementation
   _(with support for HWRAID, SWRAID, LVM, multipathing, DRBD, iSCSI, LUKS, ...)_

 * Supports various backup technologies
   _(incl. DataProtector, Bacula, TSM, NetBackup, tar, rsync)_

 * Two phase disk layout recovery
   * rescue image contains an abstract disk layout configuration
   * during recovery one can modify this disk layout configuration
   _(enables migrations from e.g. SWRAID to HWRAID, a HWRAID reconfiguration or from partitions to LVM)_

 * Support for P2V, V2P, V2V and P2P scenarios

 * Various techniques to help troubleshooting (e.g. restoring to modified hardware etc...)
   * structured log-files
   * log-files are moved to recovery image, and to recovered system (so log-files are available in every step: before, during and after recovery)
   * advanced debugging options to help trace scripts or develop new functionality

 * Integration with monitoring (examples for Nagios)

 * Integration with scheduler
   _(e.g. let cron recreate and transfer your images upon disk layout changes)_

 * Various best practices to assist recovery:
   * integrates with local bootloader
     _(in case it is still possible, you can restore from local disk through Grub)_
   * automatic network and ssh configuration
     _(for remote recovery)_
   * automatic serial console support
     _(useful for recovery through iLO or KVM serial console)_
   * shell history-stuffing
     _(stuff shell history with useful commands at every step)_
   * automatic recovery when possible, guided recovery when needed
