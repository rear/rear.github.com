---
layout: default
title: Relax-and-Recover Release Notes
---

## Release Notes for Relax-and-Recover version 2.3

This document contains the release notes for the open source project
Relax-and-Recover.

[Relax-and-Recover website](http://relax-and-recover.org/)

[GitHub project](https://github.com/rear/)


This document is distributed with the following license: "Creative Commons
Attribution-NoDerivs 3.0 Unported (CC BY-ND 3.0)". To read the license deed
go to [http://creativecommons.org/licenses/by-nd/3.0/](http://creativecommons.org/licenses/by-nd/3.0/)


## Overview
Relax-and-Recover is a GNU/Linux system administrator tool used to
create disaster recovery images which makes bare metal restore easier.
System administrators use Relax-and-Recover as part of disaster recovery
policy which does not replace in any way a good backup policy.


### Product Features
The following features are supported on the most recent releases of
Relax-and-Recover.  Anything labeled as (*New*) was added as the
most recent release. New functionality for previous releases can be
seen in the next chapter that details each release.

The most recent release of Relax-and-Recover is supported on most GNU/Linux
based systems with kernel 2.6 or higher. It provides the following
functionality:

* Hot maintenance capability. A rescue image can be made online while
  the system is running

* Command line interface. Relax-and-Recover does not require a graphical
  interface to run, nor in creation mode, nor in rescue mode (console
  is enough)

* Support included for most common file systems, such as ext2, ext3, ext4
  and reiserfs. Other filesystems like jfs, xfs and btrfs are also
  implemented, but are less tested. _(Feedback is appreciated)_

* Selected Hardware RAID and (eg. HP SmartArray) and mirroring solutions (eg.
  DRBD) are supported

* NVME and mmcblk disks are supported

* LVM root volumes are supported

* Multipath support for SAN storage

* UEFI support (including UEFI USB booting

* Integrates with _internal_ backup solutions such as:

   - GNU tar (BACKUP=NETFS, BACKUP_PROG=tar)
   - GNU tar (BACKUP=NETFS, BACKUP_PROG=tar, BACKUP_TYPE=incremental, FULLBACKUPDAY="Mon") for using incremental backups with a weekly full backup. Be aware, old tar archives will not be removed automatically!
   - GNU tar (BACKUP=NETFS, BACKUP_PROG=tar, BACKUP_TYPE=differential, FULLBACKUPDAY="Mon") for using differential backups with a weekly full backup. Be aware, old tar archives will not be removed automatically!
   - GNU tar with openssl encryption (BACKUP=NETFS, BACKUP_PROG=tar, BACKUP_PROG_CRYPT_ENABLED=1)
   - rsync on local devices (BACKUP=NETFS, BACKUP_PROG=rsync), such USB and local disks
   - rsync over the network (BACKUP=RSYNC, BACKUP_PROG=rsync)
   - Multiple backup methods ([read the documentation](https://github.com/rear/rear/blob/master/doc/user-guide/11-multiple-backups.adoc))
   - Windows partitions via BACKUP=BLOCKCLONE. See [the documention about BLOCKCLONE](https://github.com/rear/rear/blob/master/doc/user-guide/12-BLOCKCLONE.adoc)
   - BACKUP=ZYPPER is SLES12 only (*Experimental*)
   - BACKUP=YUM is for RedHat architectures ony (*Experimental*)

* Integrates with _external_ backup solutions such as:

  - Tivoli Storage Manager (BACKUP=TSM)
  - HP Data Protector (BACKUP=DP)
  - Symantec NetBackup (BACKUP=NBU)
  - Galaxy 5, 6, and 7 (BACKUP=GALAXY)
  - Galaxy 10 [Commvault Simpana] (BACKUP=GALAXY10)
  - Bacula (BACKUP=BACULA)
  - Bareos (BACKUP=BAREOS) (A fork of Bacula)
  - Rsync Backup Made Easy (BACKUP=RBME)
  - Duplicity/Duply (BACKUP=DUPLICITY)
  - EMC Networker, also known as Legato (BACKUP=NSR)
  - SEP Sesam (BACKUP=SESAM)
  - FDR/Upstream (BACKUP=FDRUPSTREAM)
  - Novastor NovaBACKUP DC (BACKUP=NBKDC)
  - Borg Backup (BACKUP=BORG)

* Integrates with [Disaster Recovery Linux Manager (DRLM)](http://drlm.org)

* Udev support (except for some really ancient udev versions) which is
  the base for many new and important features:

  - kernel drivers for network cards and storage adapters are loaded via udev
  - deal with network persistent names in udev rules
  - firmware loading
  - persistent storage device names (though Relax-and-Recover does nothing with this)

* Systemd support for the more recent Linux distributions

* System reconfiguration

  - enable recovery on hardware, that is not the same as the original system
  - network and storage drivers are adjusted
  - map hard disks if they do not match (e.g. hda -> sda)
  - remap network MAC addresses
  - use another IP address, or using dhcp via templates or from kernel command line
  - rebuild the initial ramdisk if needed (for new storage drivers)
  - migration to SAN storaged

* Support backup software: Bacula, both locally attached tapes (with
  bextract) and network-based backups. Also, in combination with OBDR tapes.

* Create OBDR tapes with method `mkbackup` and put the backup onto the tape
  to have a single-tape bootable recovery solution

* Label the OBDR tape with the method `format` to avoid accidental
  overwrites with OBDR

* Create bootable disk (eSATA, USB ...) media with the backup included:

    BACKUP_URL=usb:///dev/device

    Together with `OUTPUT=USB` we have now a complete solution on hard disks
    (booting of it and restoring data).

* DHCP client support (IPv4 and IPv6). Dhcp client activation
  can be forced via the variable *USE_DHCLIENT=yes* (define in _/etc/rear/local.conf_).
  It is also possible to force DHCP at boot time with kernel option `dhcp`

* `USE_STATIC_NETWORKING=y`, will cause statically configured network settings to be applied even when `USE_DHCLIENT` is in effect

* Save layout and compare layouts for easy automation of making
  Relax-and-Recover snapshots (checklayout option)

* External USB booting now uses extlinux instead of syslinux, and
  therefore, the USB disk must first be formatted with an ext2, ext3, ext4
  or btrfs based file system

* cron job to check changes in disk layout and trigger `rear mkrescue` if required

* VLAN tagging and bridge support

* Add timestamp of ReaR run with rc code to the syslog or messages file; sending mail report is also possible

* The possibility to backup Windows partitions via new BACKUP type BLOCKCLONE

* Unattended ReaR recovery has been improved (*New*)

* Improved security model related to SSH keys (*New*)

*NOTE*: Features marked *Experimental* are prone to change with future releases.



## Relax-and-Recover Releases
The first release of Relax-and-Recover, version 1.0, was posted to the web
in July 2006. For each release, this chapter lists the new features and
defect fixes. Note that all releases are cumulative, and that all releases
of Relax-and-Recover are compatible with previous versions of
Relax-and-Recover, unless otherwise noted.

The references pointing to *fix #nr* or *issue #nr* refer to our [issues tracker](https://github.com/rear/rear/issues).

### Version 2.3 (December 2017)

* Use /etc/os-release and /etc/system-release before falling back to lsb_release check in function SetOSVendorAndVersion (issues #1611, #731)

* Make BACKUP_URL=iso for mkrescue and mkbackuponly no longer fatal (issue #1613)

* Add ntpdate support (issue #1608)

* Fix for XFS file system recreation code. In xfsprogs >= 4.7 log section sunit=0 is considered invalid (issue #1603) 

* Changed the macro fedora_release into fedora in the rear.spec file (issue #1192 and bz1419512)

* Borg backup as back end now displays progress, when ReaR is launched in verbose mode (issue #1594)

* With the new config variable NON_FATAL_BINARIES_WITH_MISSING_LIBRARY the user can specify an 'egrep' pattern what programs
(i.e. files in a /bin/ or /sbin/ directory) where the 'ldd' test in build/default/980_verify_rootfs.sh reports 'not found' libraries
are non-fatal so that those programs in the recovery system do not lead to an Error abort of "rear mkrescue/mkbackup".
This is a generic method so that the user can avoid issues in particular with third-party backup tools that soemtimes
have unexpected ways to use their specific libraries like https://github.com/rear/rear/issues/1533 (for TSM) and
https://github.com/rear/rear/pull/1560 (for FDR/Upstream). 

* Add a NSR_CLIENT_MODE to the backup method NSR (issue #1584)
 

* Let /bin/ldd detect *.so with relative paths (issue #1560)

* Add support for Bridge Interfaces. This patch enables configurations as shown below (issue #1570):

1. Bridge over simple Ethernet
2. Bridge over Bond
3. Bridge over Vlan interface

Usually, virtual interfaces are skipped, but for Bridges to work, we consider Bridges as physical interfaces,
because the Bridge interface holds the IP address, not the physical interface attached to the Bridge.

* Use UserInput in some more usual places to improve that 'rear recover' can run
unattended in migration mode (issues #1573, #1399)

* Error out for OUTPUT_URL=null together with OUTPUT=USB (issue #1571)

* Added/updated paths for FDR/Upstream 4.0 because FDR/Upstream 4.0 includes changes to some file paths (issue #1559)

* Fix copying kernel modules when module aliases are present (issue #1567)

* Netbackup agents not automatically started on RHEL 7 (issue #1523)

* Forbid mkrescue and mkbackuponly for iso backup scheme (issues #1547, #1548)

* Only support OpenSSH 3.1 and later for SSH setup (issue #1530)

* Implemented USB_DEVICE_FILESYSTEM_LABEL (issue #1535)

* Split network-functions.sh into DHCP setup and general ReaR functions (issue #1517) 

* Avoid leaking unprotected SSH private key files onto rescue medium (issues #1512, #1513)

* Improve cryptographic security and user-friendliness for LUKS volumes (issue #1493)

* Improve ReaR network migration (issues #1605, #1510, #1399)

* Improved encrypted password detection in 500_ssh.sh (issue #1503)

* Several code improvements in the way libraries are detected and copied (issues #1521, #1502, #1494)

* Allow btrfsmountedsubvol to be excluded via EXCLUDE_RECREATE (issue #1497)

* Avoid recreation of non-existing btrfs subvolumes (issue #1496) 

* Add automatically some important kernel parameters to KERNEL_CMDLINE (issue #1495)

* Cleanup and simplified default how any default input is what the user would enter.
In particular now a numeric default input is no longer the index of a choices array element (starting at '0')
(that array is an implementation detail of the UserInput function) but now a numeric default input is the choice number that is
shown to the user (starting at '1') which the user would type in (issue #1498)

* Avoid systemd log messages about multiple disk partitions with identical name that happened because ReaR used
a static 'rear-noname' for originally unnamed partitions. Original gpt disk partitions may be unnamed but parted
requires a name for each gpt partition. Now ReaR uses the basename of the partition device path
(e.g. sda1, sda2) for originally unnamed partitions (issue #1483)

* Enhanced how the ssh user is copied into the recovery system and improved detection of the ssh user (issue #1489)

* Use meaningful variable for automated UserInput. Enforce calling UserInput with a UserInput ID so that
automated UserInput is always possible for the user. Use and enforce uppercase letters in UserInput IDs
because the resulting variable names are meant as user config variables (issue #1473)

* Fix UEFI tools integration (issues #1477, #1478) 

* Added a new YUM backup method which will recreate the system by installing it from scratch via installing RPM packages.
The YUM backup method uses the yum package manager in the same manner as the ZYPPER backup method (issue #1464)

* BACKUP_PROG_OPTIONS used to be a string variable, turn it into an array (issue #1475)

* Now CLONE_ALL_USERS_GROUPS always extends the CLONE_USERS and CLONE_GROUPS arrays (issues #1471, #1464) 

* PXE code improvements (issue #1466)  

* Several improvements in the multipath code to allow full migration (issues #1449, #1450)

* Several improvements on the TSM code (issues #1539, #1461, #1452)

* Activate btrfs filesystem creation with uuid. Recent btrfs version finally added this option (issue #1463)

* By default a directories_permissions_owner_group file is created that saves permissions, owner, and group of basic directories
plus symbolic link names and link targets of basic directories. Those basic directories are the currently used mountpoints
(except some unwanted "noise" from all what there is mounted) plus the directories of the Filesystem Hierarchy Standard (FHS)
that actually exist on the system. Additionally with the new DIRECTORIES_TO_CREATE array the user can now explicitly
specify directories and symlinks that are still missing in his particular environment (issue #1459)
 
* Fix for cryptsetup hang on `cryptsetup luksOpen ...` when dmsetup is not present in recovery system (issue #1458)

* enhance MOUNTPOINTS_TO_RESTORE into DIRECTORIES_TO_CREATE (issue #1455) 

* Several improvements for ppc64le/ppc64 arch;  Systemd automatic serial console detection; lilo and yaboot improvements (issue #1446, #1442)

* Introduction of UserInput in 300_map_disks.sh (issues 1399 and 1431)

* Adapt /etc/motd when 'rear recover' is running to avoid the additional 'Run rear recover to restore your system' message that only

* SLES12 with btrfs but without snapshots failed to recreate/mount btrfs FS/subvolumes during recovery (issue #1036)

* Adapt chrp-boot option when xorrisofs is used. Xorrisofs use -chrp-boot-part option to generate PPC boot while mkisofs use -chrp (issue #1430)


### Version 2.2 (July 2017)

* Let the get_disk_size() function retry several times to be more fail-safe when udev needs some time until device files appear. This introduces the new generic helper function retry_command() plus the new config variables REAR_SLEEP_DELAY and REAR_MAX_RETRIES. For details see default.conf and lib/layout-functions.sh (issue #1370)

* ReaR failed to continue due incorrect check of presence of USB device (REAR-000) in /proc/mounts, despite foregoing script (060_mount_NETFS_path.sh) did mounting of this device (issue #1415)

* Add missing privilege separation dir to start sshd on Debian 9 (issue #1381)

* Redirect rsync verbose output to backup log (issue #1387)

* Load storage controllers in rescue system in same order as on host system (issue #1384):
  - Copy over modules from initrd on SUSE LINUX 
  - Prevent sorting of MODULES_LOAD array to keep the order intended

* Add /yaboot to ISO_FILE when running SUSE ppc64 (issue #1414)

* Add SSL cert directories so we can interact with Google Cloud Storage (issue #1402)

* Modified the "unattended" into "automatic" with ISO_DEFAULT required for automated recovery tests (issue #1397)

* Use the original fds when ReaR was launched (which are now saved as fd6, fd7, and fd8 for stdin, stdout, and stderr respectively) for actually intended user input and user output. To keep backward compatible behaviour all old deprecated usage of '>&8' is converted into '>/dev/null' but /dev/null usage in general should be cleaned up later (issues #887, #1395)

* Added new generic UserInput and UserOutput plus LogUserOutput functions that are intended to replace current user input functionality that calls select or read directly. For the next ReaR version 2.3 it is planned to also redirect stdout into the log file in addition to stderr (issues #885, #1366, #1398, #1399)

* The 'make rpm' now relies on 'make srpm' which creates the src.rpm package first. This src.rpm package can then be easily copied to another computer to rebuild a rpm package from it without needed the sources itself (or git checkout) (issue #1389)

* Replaced some perl regexp with grep native extended regexp (issue #1376)

* Introducing SECURE_BOOT_BOOTLOADER variable in default.conf This variable should enable users booting with Secure Boot, to use whatever custom signed boot loader they like, and removes hard coded entry “shim.efi” from ReaRs code (issue #1374)

* Enhanced and cleaned up making ISO on POWER (ppc64/ppc64le). Now the backup can be stored in the ISO (via BACKUP_URL=iso...) and even multiple ISOs work on POWER now (issues #697, #1383)

* Create multipath.conf only during migration (from non-mulitpath to multipath), and always copy /etc/multipath/bindings to the TARGET_FS_ROOT (issues #1382, #1393)


### Version 2.1 (June 2017)

* Support for Grub2 installation with software RAID1 on Linux on POWER (ppc64/ppc64le) (issue #1369)

* REBUILD_INITRAMFS variable was introduced. The new default.conf setting REBUILD_INITRAMFS="yes" rebuilds the initramfs/initrd during "rear recover" to be more on the safe side. With REBUILD_INITRAMFS="" the old behaviour can still be specified (issue #1321)

* ISO_RECOVER_MODE=unattended mode (issue #1351) - required for automated ReaR testing with OUTPUT=ISO

* MODULES variable supports now special values like 'all_modules', 'loaded_modules', 'no_modules' (issues #1202, #1355)

* Include systemd/network to preserve "Predictable Network Interface Names" (issue #1349)

* Various improvements regarding multipath (issues #1190, #1309, #1310, #1311, #1314, #1315, #1324, #1325, #1328, #1329, #1344, #1346)

* Show OUTPUT variables in `rear dump` (issue #1337)

* Added support for "grub PXE style" via PXE_CONFIG_GRUB_STYLE and PXE_TFTP_IP on non x86 platform (issue #1339)

* Try 'wipefs --force' and use 'dd' as fallback to better clean up disk partitions (issue #1327)

* Reorganized "finalize" scripts ordering and cleanup of the PPC bootloader installation (issue #1323)

* Avoid long default wait in 'dig' when DNS servers are not set (issue #1319)

* Fail-safe calculations in partitioning code (issues #1269, #1307)

* Improved support on ppc/ppc64/ppc64le architectures (issues #1178, #1311, #1313, #1322)

* Define hostname in both /etc/HOSTNAME and /etc/hostname in rescue image (for Arch) (issue #1316)

* Rename network interface when MAC not present in udev (issue #1312)

* Added support for 'nano' editor (in addition to 'vi') (issues #1298, #1306)

* mmcblk disk types are now supported (issues #1301, #1302)

* NETFS_RESTORE_CAPABILITIES variable was introduced to restore file capabilities in a proper way (issue #1283)

* Added required libs and files for 'curl' with HTTPs by default (issues #1267, #1279)

* More precise XFS file system creation during `rear recover` (issues #1208, #1213, #1276)

* DRLM management and security improvements (issue #1252)

* Improved BOOTLOADER support (issue #1242)

* DRLM support for multiple backups via multiple config files (issue #1229)

* FIRMWARE_FILES support to exclude firmware files in rescue image to reduce the size of image (issue #1216)

* Enable SELinux in the rescue image for tar internal backup method if BACKUP_SELINUX_DISABLE=0 (issue #1215)

* BOOT_OVER_SAN is now fully supported (issues #1190, #1309, #1314, #1315, #1325, #1329, #1344)

* NVME disks are now fully supported (issue #1191)

* Some initial basic support for new backup type ZYPPER was added (issues #1085, #1209)

* Finding UEFI boot loaders on non standard places (issues #1204, #1225, #1293)

* The USB UEFI partition size USB_UEFI_PART_SIZE for kernel image has been increased from 100 to 200 MB (issue #1205)

* REAR_INITRD_COMPRESSION variable was introduced to specify initrd compression (e.g. 'lzma' for PPC64) (issues #1142, #1218, #1290)

* New backup type BLOCKCLONE was added to backup non-Linux partitions (e.g. Windows NTFS partitions) (issues #1078, #1162, #1172, #1180)

* Bareos 16.2 is now supported (issue #1169)

* New USB_PARTITION_ALIGN_BLOCK_SIZE and USB_DEVICE_FILESYSTEM_PARAMS variables were added (issue #1217)

* Improved the USB backup selection menu during the recovery via USB (issue #1166)

* USB_SUFFIX variable was introduced to align backup on USB with backup on NFS (issues #1164, #1160, #1145)

* Forbid incremental backup to work on BACKUP_URL=usb:// (issue #1146)

* The USB_DEVICE_PARTED_LABEL=gpt setting is now honered while formatting the USB disk (issue #1153)

### Version 2.00 (January 2017)

(*Important Note*) ReaR 2.00 introduced the 3-digits scripts instead of the 2-digits script. This means all scripts must begin with 3 digits, e.g. 010-my-script.sh instead of 10-my-script. Therefore, if you wrote your own scripts make sure to renumber these. You could also use the *make validate* to check this.

* Bareos support: add missing directory /var/run/bareos in recovery system (issue #1148)

* Forbid BACKUP_URL=usb for BACKUP_TYPE=incremental/differential (issues #1141 and #1145)

* Improved and added new example configurations (issue #1068, #1058)

* Modified/Improved the exit code messages of ReaR (issues #1089, #1133)

* Fix documentation regarding OUTPUT_URL=null (issues #734, #1130)

* Better and fail safe progress messages while tar backup restore (issue #1116)

* Implement simulation mode with simulation with the workflows validate and shell (issue #1098)

* Update 11-multiple-backups.adoc : Multiple backups are in general not supported for
BACKUP_TYPE=incremental or BACKUP_TYPE=differential (issues #1074 and #1123)

* Using RUNTIME_LOGFILE in all scripts as needed (issue #1119)

* New Backup method was added - BORG (issues #1030, #1037, #1046, #1048, #1118)

* Multiple backups are now possible (issues #1088, #1102, #1096) - see the [documentation page](https://github.com/rear/rear/blob/master/doc/user-guide/11-multiple-backups.adoc) (*New*)

* Support partitioning and formatting huge USB devices (issue #1105)

* Skip remount async when systemd is used (issue #1097)

* Fixed and enhanced code for multiple ISOs (issue #1081)

* BACKUP_TYPE=incremental and BACKUP_TYPE=differential were updated (issues #974, #1069)

* Added support for setting a UUID on XFS with enabled CRC (RHEL 7) (issue #1065)

* Fix for ISO not bootable for SLES11 ppc64 with root LVM (issue #1061)

* PXE booting enhancement with new style of uploading the boot files (issue #193)

* Renumbering the ReaR scripts from 2-digits to 3-digits (issue #1051)

* Improved boot loader detection (issue #1038)

### Version 1.19.0 (October  2016)

* Save bootloader info from POWER architecture and rebuild initrd after migration (issues #1029, #1031)

* Improved documentation and man page in general (issues #918, #930, #1004, #1007, #1008)

* New SLE12-SP2-btrfs-example.conf file because since SLES12-SP2 btrfs quota setup for snapper via "snapper setup-quota" is needed (issue #999)

* Simplified reboot halt poweroff and shutdown in the rescue/recovery system in case of systemd (issue #953)

* If TSM parameters contain a dot, the dot is replaced by an underscore in the TSM_SYS variable names (issues #985 and #986)

* Check if /dev/disk/by-label/RELAXRECOVER exist (issues #979 and #326)

* Added PRE_BACKUP_SCRIPT and POST_BACKUP_SCRIPT to be able to do custom tasks in the mkbackup/mkbackuponly workflows (issue #977)

* Make TMPDIR work in compliance with Unix standards (issue #969)

* USE_STATIC_NETWORKING now really overrides USE_DHCLIENT (issue #964)

* Make it safe against wrong btrfs subvolumes on SLES12 (issues #963, #966)

* Encrypted incremental backup cannot read the tar label (issue #952)

* Introduction of the NETWORKING_PREPARATION_COMMANDS variable to prepare network setup in the rescue/recovery system (issue #960)

* After migration fs_uuid for root partition was not changed in ELILO config file /etc/elilo.conf (issue #956)

* Clarified rear man page and default.conf file around BACKUP_URL=rsync: (issues #930 and #918)

* Make "rear recover" work with default btrfs on SLES12-SP2 (issue #944)

* Dropped GRUB_SUPERUSER and GRUB_RESCUE_PASSWORD to avoid that GRUB_RESCUE could change the behaviour of the GRUB2 bootloader in the currently running system in unexpected ways. With the new optional GRUB_RESCUE_USER setting GRUB_RESCUE works in compliance with the existing GRUB2 configuration (issues #938, #942)

* Bail out if not enough disk space for GRUB and GRUB2 rescue image (issue #913)

* Use BACKUP_PROG_COMPRESS_OPTIONS as an array so that one can use it to provide more complex values (issue #904)

* Add /usr/lib/syslinux/bios to the search path for mbr.bin (issue #908)

* Always load modules in /etc/modules (issue #905)

* Ask user for EFI partition size on USB disk (issue #849)

* Insure /etc/rear/mappings directory exists before doing a recovery (issue #861)

* First steps for rescue/recovery system update support via RECOVERY_UPDATE_URL (issue #841)

* NFS mount points are not recreated after a recover (issue #818)

* Correcting ReaR return code handling in auto recover mode (issue #893)

* Added NFSv4 support for security 'sys' only so far (issue #754)

* Changed the usage of 'rpcinfo -p' a bit to have the same outcome of different Linux flavours (issue #889)

* RSYNC: /boot/efi needs --relative rsync option (issue #871)

* New variables added for Bareos: BAREOS_RESTORE_JOB and BAREOS_FILESET

* Multipath partition not found in rhel7.2 (issue #875)

* Adding support for ppc64le PowerNV (non-virtualized aka Bare-Metal) (issue #863)

* First steps to support new ftpfs BACKUP_URL scheme (issue #845)

* Clean up 'url_host()' (issue #856)

* Fix that libaio (needed for multipath) could be missing in rescue/recovery system because libaio can be located in different directories (issue #852)

* Improved the Relax-and-Recover menu for GRUB2 (issues #844, #849, #850)

* Check for valid BACKUP_URL schemes (issue #842)

* USB UEFI boot support (issue #831)

* Mitigate the problem that btrfs subvolums are not restored by default via TSM (issue #833)

* Determine EFI virtual disk size automatically (issue #816)

* ebiso image size is too small if BACKUP=TSM (issue #811)

* Improving the logics around ebiso usage in UEFI mode (issue #801)

* Fix for wrong UUID in initrd for bootfs (issues #649 and #851)



### Version 1.18.0 (March 2016)

* Support was added for NVME SSD type of disk devices (issue #787)

* For LUKS added the password libraries (issue #679)

* Script 99_sysreqs.sh was added to save the minimal system requirements necessary for cloning
  a system in a remote DRP data center (issue #798)

* New 99_move_away_restored_files.sh to remove restored files after recover (issue #799)
  New array was introduced to make this - BACKUP_RESTORE_MOVE_AWAY_FILES=()

* Improved 40-start-udev-or-load-modules.sh script for better udevd handling (issue #766)

* Run ldconfig -X before dhclient gets started at boot time (issue #772)

* Remove the "-c3" option fron rsyslogd start-up (issue #773)

* Add example configuration for NetBackup Master/Media server

* Added backup capabilities; getcap and setcap are used to backup and restore (issue #771)

* Correct bash syntax so ReaR is compatible with bash v3 and v4 (issue #765, #767)

* Added support for new backup method Novastor NovaBACKUP DC (BACKUP=NBKDC) (issue #669)

* Code was improved to have network teaming support (issue #655)

* Example configuration to put backup and rescue image on same ISO image, eg. DVD (issue #430)

* Improved the ReaR documentation

* remove the noatime mount option for cifs mount (issue #752)

* Replace option 'grep -P' to 'grep -E' due to SELinux errors (issues #565, #737)

* Hidding the encryption key while doing the restore in the rear.log (issue #749)

* is_true function was to uniform the different ways of enable/disble variable settings (issue #625)

* Added and use sysctl.conf; rescue mode should honor these settings (issue #748)

* The BACKUP_PROG_COMPRESS variable was not used during incremental backup (issue #743)

* prevent any other workflow in REAR rescue mode then recover (issue #719)

* Exclude Oracle ASM device directory from Rescue System (issue #721)

* SaveBashFlagsAndOptions and RestoreBashFlagsAndOptions in usr/share/rear/lib/framework-functions.sh were added (issue #700)

* /mnt/local became a global variable TARGET_FS_ROOT (issue #708)

* Copy rear.log from recovery into /var/log/rear/recovery/ directory after a 'rear recover' (issue #706)

* wipefs will be used when available (issue #649)

* SAN related improvements with btrfs (issue #695)

* Support for shim.efi (UEFI booting) added (issue #702)

* Added support for elilo (used by SLES 11/12) (issue #583, #691, #692, #693)

* Added option --debugscripts to rear (help-workflow) (issue #688)

* Removed dosfslabel as required program for vfat UEFI boot partition (issue #694)

* Bareos team added BAREOS_FILESET and ISO_DEFAULT to default.conf (for automated DR tests executed by Bareos team; issues #686, #719)

* Fix getty/agetty with upstart (issue #685)

* New SLE11-SLE12-SAP-HANA-UEFI-example.conf (issue #683)

* usr/share/rear/conf/examples/SLE12-SP1-btrfs-example.conf added as an example configuration file

* Added support for the SUSE specific gpt_sync_mbr partitioning scheme (issue #544)

* Improved btrfs snapshot support with SLES 12 (issue #556)

* Unload scsi_debug driver in recovery mode for RHEL 7.1 (issue #626)

* Saved the current mount points and permissions; in order to improve and avoid missing mount points after recovery (issue #619)

* NSR servername not defined causing ReaR to hang (issue #637)

* Removed mingetty as a required package (issue #661)

* Adding -scrollprompt=no to dsmc query  in script verify/TSM/default/40_verify_tsm.sh (issue #667)

* Fixed a bug around USB_DEVICE and OUTPUT_URL mis-match (issue #579)

* grub support for ppc64 (issue #673)

* grub2 supported was added for ppc64 (issue #672)

* ppc64le support was added into the rear.spec (issue #665)

* Network code partially rewritten to improve teaming (issue #662)

* Changed default value of USE_CFG2HTML from 1 to empty (means do not run cfg2html by default) (issue #643)

* Move the 50_selinux_autorelabel.sh script to the default location so it gets picked up by all backup methods. This was required for RHEL 7 (issue #650)

* Check via NSR if the ISO image is not obsolete (issue #653)

* Added ebiso support within ReaR (required for UEFI booting with SLES 11 & 12 (issue #657)

* FDR/Upstream (BACKUP=FDRUPSTREAM) (*New*) (issue #659)

### Version 1.17.2 (August 2015)

* Several fixed required to the Debian packaging rules needed so it builds correctly on OBS

* Fixed the NTP startup script (issue #641)

* Fixed the vfat label issue (issue #647)

* Improved the DUPLICITY method with finding all required libraries and python scripts

* Added the `/run` directory to the list of recreating missing directories (issue #619)

* Fix issue with USB disk and rsync as internal backup program (issue #645)

* Fix rsync restore: --anchored invalid rsync option (issue #642)

* A new variable was introduced `NSR_POOLNAME` (issue #640)

* Replaced almost all temporary files from `/tmp/` to `$TMP_DIR/` (issue #607)
  Related to security recommendations for Fedora and RHEL:
  - https://bugzilla.redhat.com/show_bug.cgi?id=1239009 (f22)
  - https://bugzilla.redhat.com/show_bug.cgi?id=1238843 (rhel 7.2)

* Move nfs-client from depends to recommends in Debian control file (issue #633)

* In `packaging/rpm/rear.spec` replaced "BuildArch: noarch" with "ExclusiveArch: %ix86 x86_64 ppc ppc64" that should tell the user that rear is known to work only on %ix86 x86_64 ppc ppc64 and removed "Requires: yaboot" for ppc ppc64 because that is the default installed bootloader on ppc ppc64 (issues #629 and #631)

* Support the Oracle Linux 6 ksplice module (issue #605)

* In script 27_hpraid_layout.sh added the missing `HPSSACLI_BIN_INSTALLATION_DIR` variable to the `COPY_AS_IS` array (issue #630)

* Modified the packaging Makefile and rules for debian to fix the failing OBS Debian builds (issue #604)

* Syslinux version > 5.00 is now supported (ISO and USB output) - works on Debian 8, Ubuntu 15.04 (issue #624)

* Bail out when syslinux/modules are not found in lib/bootloader-functions.sh (issues #467 and #596)
  You could also define a variable `SYSLINUX_MODULES_DIR` if ReaR cannot find it automatically (should not be necessary)

* Support was added for SLES11 on PPC64 hardware (issues #616 and #628)

* Support was added for new hardware - PPC64LE - RHEL and Ubuntu (issue #627)

* FIX the hashed password (`SSH_ROOT_PASSWORD` variable) and added a missing library libfreeblpriv3 (issue #560)

* Insert a 3 seconds sleep after a volume group restauration to give udevd or systemd-udevd time to create needed devices (issue #608 and #617)

* Variable `MANUAL_INCLUDE=YES` has been introduced to work with array `BACKUP_PROG_INCLUDE` (issue #597)

* Add new variable `NSR_DEFAULT_POOL_NAME` (defaulting to `Default`) to use a different default pool name. Renamed the `RETENTION_TIME` variable to `NSR_RETENTION_TIME` (issue #640)

* ReaR website shows the user guide which is part of the ReaR software (linked to GitHub)

* new document 10-integrating-external-backup.adoc which explains the steps to take for a new backup integration into ReaR

* All AsciiDoc documentation changed extention from .txt to .adoc

### Version 1.17.1 (June 2015)

* Removed the plain password in the logs (and output) coming from BACKUP_PROG_CRYPT_KEY to avoid crib (issue #568)

* Mount vfat file system without special mount options seems to work much better then with these options in recovery mode, therefore,
  we do not use these anymore (especially for /boot/efi) (issue #576)

* Elilo support has been added for SLES (not fully tested yet) - issue #583

* Grub2 rescue menu has been added (enable this feature with `GRUB_RESCUE=y`) - issue #589

* splitted script 31_include_uefi_tools.sh in two pieces: 31_include_uefi_tools.sh: to grab the UEFI tools (as long as /boot/efi is mounted), and 32_include_uefi_env.sh: to dig deeper into the configuration when UEFI is active (related to issue #214)

  This is necessary to have to UEFI tools on SLES 11/12 where we cannot create an UEFI bootable ISO image. We must boot in BIOS mode, and need the UEFI tools to make the system bootable over UEFI.

* It is now possible to format an USB disk with a vfat and ext3 partition (for UEFI booting) - issue #593

    `rear -v format -- --efi /dev/<usbdevice>`

* Simplified the code for ext* fs and added StopIfError calls to prevent divide by zero during recovery (issue #598)

* Syslinux version >6 requires some special handling due to splitting up the package (Ubuntu 15.04) (issue #584)

* Debian 8 support added with ISO booting with latest syslinux release as well (issues #596, #599 and #600)

* Changed the behavior of SSH_ROOT_PASSWORD - now saved as MD5 hash password, but backwards compatibility is still respected (issue #560)

* For EMC NetWorker server/client we added some exclude items to COPY_AS_IS_EXCLUDE_NSR (issue #571)

* Removed the Warning message from main rear script as it was misleading (issues #563 and #564)

* output/ISO/Linux-i386/80_create_isofs.sh: make sure ISO_FILES[@] are copied to isofs directory (issue #569)


## System and Software Requirements
Relax-and-Recover works on GNU/Linux kernel with version 2.6 and higher.
For lower kernel versions Relax-and-Recover cannot be used, and for these
systems, [mkcdrec](http://mkcdrec.sourceforge.net/) is still a good
alternative.

As Relax-and-Recover has been solely written in the *bash* language we need
the bash shell which is standard available on all GNU/Linux based systems.
The default backup program Relax-and-Recover uses is GNU/tar which is also
standard available.

Relax-and-Recover is known to work well on x86 and x86_64 based architectures.
Relax-and-Recover has also been ported to ia64 and ppc architectures, but
these are less tested.  Use the '`rear validate`' command after every
successful DR test please and mail us the results.


### Choosing the best compression algorithm
The default backup program with Relax-and-Recover is (`BACKUP_PROG=tar`)
GNU tar and the default compression used with tar is `gzip`. However, is
using `gzip` the best choice? We have done some tests and published the
results. See
[Relax-and-Recover compression tests](http://www.it3.be/2013/09/16/NETFS-compression-tests/)

## Support
Relax-and-Recover (rear) is an Open Source project under GPL v3 license which means
it is free to use and modify. However, the creators of ReaR have spend many, many hours in 
development and support. We will only give *free of charge* support in our free time (and when work/home balance
allows it).

That does not mean we let our user basis in the cold as we do deliver support as a service (not free of charge).

## Supported Operating Systems
We try to keep our wiki page [Test Matrix rear 2.3](https://github.com/rear/rear/wiki/Test-Matrix-rear-2.3) up-to-date with feedback we receive from the community.

ReaR-2.3 is supported on the following Linux based operating systems:

* Fedora 25 and 26
* RHEL 5, 6 and 7
* CentOS 5, 6 and 7
* ScientificLinux 6 and 7
* SLES 11 and 12
* openSUSE Leap and openSUSE Tumbleweed
* Debian 6, 7, 8 and 9
* Ubuntu 12, 13, 14 and 15

ReaR-2.3 dropped officially support for the following Linux based operating systems:

* Fedora < 25
* RHEL 3 and 4
* SLES 9 and 10
* openSUSE <= 13
* Debian < 6
* Ubuntu < 12

If you require support for *unsupported* Linux Operating System you must acquire a *ReaR support contract*.

Requests to port ReaR to another Operating System (not Linux) can only be achieved with **serious** sponsoring.

## Supported Architectures
ReaR-2.3 is supported on:

* Intel x86 type of processors
* AMD x86 type of processors

ReaR-2.3 may or may not fully work on:

* Intel Itanium processors
* PPC processors
* PPC64 processors
* PPC64LE processors

ReaR-2.3 does not support:

* ARM type of processors
* s390x type of processors

If you feel the need to get a fully functional ReaR working on one of the above mentioned type of processors please buy
consultancy from one of our official developers.

## Supported ReaR versions
ReaR has a long history (since 2006) and we cannot support all released versions. If you have a problem we urge you to install the latest stable ReaR version or the development version (available on GitHub) before submitting an issue.

However, we do understand that it is not always possible to install on hundreds of systems the latest version so we are willing to support previous versions of ReaR if you buy a support contract. Why do we change our policy? We cannot handle the big support requests anymore and we must give paid projects priority, therefore, we urge our customers to buy a support contract for one or more systems. You buy time with our core developers.


## Known Problems and Workarounds

*Issue Description*: rear package on ubuntu 14.04 depends on isolinux package (which does not exist)

* Workaround:

Read the comments in [issue #1403](https://github.com/rear/rear/issues/1403)


*Issue Description*: tar --test-label is not supported on Centos 5 who have tar version 1.15

* Workaround:

Read the comments in [issue #1014](https://github.com/rear/rear/issues/1014)


*Issue Description*: BACKUP=NSR on RHEL 6 could break yum

[Issue #387](https://github.com/rear/rear/issues/387) describes a problem seen on RHEL 6 where when `rear` uses NSR and afterwards the link `/lib64/libexpat.so.1` has been changed.

* Workaround:

So far there is *no* workaround for this issue.

*Issue Description*: usage of an alternative configuration directory is different in mkbackup or recover mode

Using `rear -v -c /etc/rear/mydir mkbackup` works fine in production, but when you try (once booted from rescue image) `rear -v -c /etc/rear/mydir recover` it will fail.

* Workaround:

The configuration files are copied to `/etc/rear/` into the rescue image, so you simply need to type: `rear -v recover`
See issue #512

*Issue Description*: Is there a possibility to add btrfs subvolume to a rsync backup

* Workaround:

At present (release 1.18) there is no workaround in place. If you happen to know how this could be fixed then add your ideas to [issue #417](https://github.com/rear/rear/issues/417)

*Issue Description*: UEFI ISO booting does not work on openSUSE 12.x, or SLES 11/12

* Workaround:

At present (release 1.18.x and higher) `genisoimage` cannot produce ISO images that can boot via UEFI on an openSUSE distribution (and also SLES). However, use the [`ebiso`](http://download.opensuse.org/repositories/Archiving:/Backup:/Rear/SLE_11_SP3/x86_64/ebiso-0.2.3-1.x86_64.rpm) package instead to create UEFI ISO images on SLES.


*Issue Description*: System reconfiguration still has some weaknesses.

* this has to be tested before relying on it, there are too many unknowns
involved so that we cannot guarantee anything in this area. It has been
developed mostly as a P2V tool to migrate HP servers to VMware Vms

* hard disks need to be at least of the same size and amount as in the
original system, ATM this is a simple 1:1 mapping of old to new disks,
there is no removal of RAID groups or merging of smaller disks onto a
bigger one or making stuff smaller.

* any use of _/dev/disk/by-path_ or _/dev/disk/by-id_ is untested and will
most likely not work. In some cases Relax-and-Recover will print a warning,
but we are not able to detect all cases. Typically this leads to unbootable
systems or bad _/etc/fstab_ files


*Issue Description*: If SELinux is not disabled during backup (variable
`BACKUP_SELINUX_DISABLE=` in _/etc/rear/local.conf_) then we might see
errors in the `rear-$(hostname).log` file such as:

    tar: var/cache/yum/i386/15/updates/packages: Cannot setfilecon: No such file or directory

* Workaround:

Make sure the `BACKUP_URL` destination understands extended attributes
(CIFS is out of the question and NFS is problematic). When using local
disks (or external USB devices) make sure the proper mount options are
given in the `BACKUP_OPTIONS` variable, e.g.:


    BACKUP_OPTIONS="rw,relatime,seclabel,user_xattr,acl,barrier=1,data=ordered"


(TIP) `BACKUP_SELINUX_DISABLE=1` variable has been introduced in the
_/usr/share/rear/conf/default.conf_ file to disable SELinux
while the backup is running (default setting).

*Issue Description*: ERROR: FindStorageDrivers called but STORAGE_DRIVERS is empty

Above error message might be seen after a fresh installation of the GNU/Linux kernel. ReaR got confused between the running kernel version number and the actual fresh kernel available.

* Workaround:

Reboot your server before using ReaR again, which is a good practice anyway after upgrading the GNU/Linux kernel.

