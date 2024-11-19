---
layout: default
title: Relax-and-Recover Release Notes
---


# Release Notes for Relax-and-Recover Version 2.8

This document contains the latest release notes for the Free and Open Source Software project Relax-and-Recover.

[Relax-and-Recover website](http://relax-and-recover.org/)

[GitHub project](https://github.com/rear/)


# Overview

Relax-and-Recover (abbreviated ReaR) is the de facto standard disaster recovery framework on Linux.

It is particular used on enterprise Linux distributions like Red Hat Enterprise Linux (RHEL)
and SUSE Linux Enterprise Server (SLES).

ReaR is a system administrator tool and framework to create a bootable disaster recovery system image
for bare metal disaster recovery with data backup restore on physical or virtual replacement hardware.

For bare metal disaster recovery the ReaR recovery system is booted on plain replacement hardware.
On replacement hardware first the storage setup/layout is recreated (disk partitioning, filesystems, mount points),
then a backup restore program is called to restore the data (system files) into the recreated storage,
and finally a boot loader gets installed.

System administrators use the ReaR framework to set up a disaster recovery procedure
as part of their disaster recovery policy (which complements their existing backup policy).

ReaR complements backup and restore of data but ReaR is neither a backup software
nor a backup management software and it is not meant to be one.
Data backup and restore happens via dedicated backup software which is called by ReaR.

ReaR has built-in support for some 'internal' backup programs like 'tar' and 'rsync'.

ReaR integrates with various external (third-party) backup software solutions, for example:

  - IBM Storage Protect (TSM) / Tivoli Storage Manager / IBM Spectrum Protect
  - Data Protector (DP)
  - Veritas NetBackup (NBU) / Symantec NetBackup
  - Commvault Simpana (GALAXY10) / Galaxy 10
  - Bacula (BACULA)
  - Bareos (BAREOS)
  - Rsync Backup Made Easy (RBME)
  - Duplicity/Duply (DUPLICITY)
  - Dell NetWorker (NSR) / EMC NetWorker / Legato NetWorker
  - Dell EMC Avamar (AVA) / EMC Avamar
  - SEP Sesam (SESAM)
  - Borg (BORG)
  - Rubrik Cloud Data Management (CDM)

ReaR integrates with [Disaster Recovery Linux Manager (DRLM)](http://drlm.org)


# Relax-and-Recover Releases

The first release of ReaR, version 1.0, was posted to the web in July 2006.
For each release, this document lists new features, backward incompatible changes, and defect fixes.
Unless otherwise noted releases of ReaR are intended to work reasonably backward compatible with previous versions.
In addition to the GPL disclaimer of warranty and liability there is no guarantee that all works backward compatible.
In general the older a system is the less likely it is that a newer ReaR version works.
For each ReaR version upgrade and for each change of a software that is used by ReaR and
for each change of your basic system you must re-validate that your disaster recovery procedure still works for you.


# Relax-and-Recover Version 2.8 (November 2024)

Things like 'issue NNNN' or only '#NNNN' refer to [GitHub issues tracker](https://github.com/rear/rear/issues).

## New features, bigger enhancements, and possibly backward incompatible changes:


New -e/--expose-secrets option.

New non-interactive mode.

NFS4SERVER as new restore method

New OpalPBA AuthToken feature

Add support for Commvault Galaxy 11

Layout changes and fixes for S/390 DASDs (major code overhauling)

Initial basic 'barrel' support, see https://github.com/aschnell/barrel  

By default "rear recover" wipes disks that get completely recreated          
via DISKS_TO_BE_WIPED="" in default.conf          




## Details (mostly in chronological order - newest topmost):

Only changes of the ReaR software and its documentation that could be of common interest are listed here.
For example changes of ReaR GitHub infrastructure things (like GitHub workflows, actions, CI, and package building)
or minor changes in documentation (like unimportant typo fixes) are not listed here.
To see all changes use the 'git log' command on a local git clone/checkout
or view the [ReaR 2.8 changes at GitHub](https://github.com/rear/rear/commits/rear-2.8)
or the current [ReaR GitHub master code changes](https://github.com/rear/rear/commits/master).

The following entries are basically excerpts of what the command
"git log --format="%ae %H %ad%n%s :%n%b%n" --graph | fmt -w 160 -u -t | less"
shows in a local git clone:






Merge pull request #3124 :
Take AUTOEXCLUDE_PATH into account in layout doc:
Since PR #2261, /media is included in the default AUTOEXCLUDE_PATH. This
means that a filesystem mounted on a directory like /media/backup will
not be included in the layout. This makes the example invalid, as it
describes how a filesystem mounted under /media/backup will be included
in the layout and what manual steps are needed to exclude it.
To preserve the validity of the example, change all paths in the example
from /media/backup to /backup.
Take this opportunity to also describe the AUTOEXCLUDE_PATH variable
among other autoexclusions.

More clear AUTOEXCLUDE_PATH description in default.conf :
In default.conf make it more clear how the defaults for 
AUTOEXCLUDE_PATH and BACKUP_PROG_EXCLUDE interact 
when /tmp is a separated filesystem, see 
https://github.com/rear/rear/pull/2261#discussion_r1444282008

Set 'dmesg -n [4-6]' in new 'setup' script 007_set_dmesg_level.sh (#3113) :
The new 'setup' stage script setup/default/007_set_dmesg_level.sh 
sets 'dmesg -n [4-6]' for the worksflows 
recover layoutonly restoreonly finalizeonly mountonly 
depending on verbose and debug modes for ReaR. 
This is related to https://github.com/rear/rear/pull/3108 

Set 'dmesg -n 5' in etc/scripts/boot (#3108) :
In [skel/default]/etc/scripts/boot set 'dmesg -n 5'
to limit console logging for 'dmesg' messages to level 5 
so that kernel error and warning messages appear 
(intermixed with ReaR messages) on the console 
so that the user can notice when things go wrong 
in kernel area which helps to understand problems, 
see the related issue 
https://github.com/rear/rear/issues/3107 

Fixed 800_enforce_usb_output.sh (#3110) :
Overhauled build/USB/default/800_enforce_usb_output.sh 
Now LogPrintError infos and BugError when OUTPUT=USB 
got somehow modified in $ROOTFS_DIR/etc/rear/local.conf 
plus explanatory comments in the code. 
Triggered by https://github.com/rear/rear/pull/3103 
and replacing this by a new pull request. 

Error() instead of BugError() in 850_make_USB_bootable.sh (#3104) :
In output/USB/Linux-i386/850_make_USB_bootable.sh replaced the 
BugError "Filesystem ... on $RAW_USB_DEVICE could not be found" 
with explanatory LogPrintError plus Error what the actual reason is, 
similar as in the related https://github.com/rear/rear/pull/3102 
because in most cases this is not a bug in ReaR but an error 
like a user configuration error for OUTPUT=USB e.g. 
see https://github.com/rear/rear/issues/1571 
and https://github.com/rear/rear/issues/3098 
Use first LogPrintError for an additional info message 
and then Error for the actual error message. 
In those LogPrintError plus Error message pairs 
show both $BUILD_DIR/outputfs and $RAW_USB_DEVICE 
because $BUILD_DIR/outputfs is a meaningless directory 
of the form /var/tmp/rear.XXXXXXXXXXXXXXX/outputfs 
so $RAW_USB_DEVICE provides some context to the user 
that those two messages are about his USB or disk device. 

Merge pull request #3105 :
Do not touch $BUILD_DIR/outputfs :
Remove a forgotten mkdir -p $BUILD_DIR/outputfs/$NETFS_PREFIX command in
restore/NETFS/default/400_restore_backup.sh.
Should have been deleted in 7dda23d708854db2d09db1308c159aea667763c0
with other code that touched the backup location.
For the YUM method, the same change was already done in 6b9d8d8508183144f56eec92b828ae037c03a6f7

Merge pull request #3102 :
OUTPUT=USB: add a check that OUTPUT_URL is mounted :
If OUTPUT_URL uses the file:// scheme, ReaR aborts with a weird error
message "BUG: Filesystem where the booting related files are on ...
could not be found" in output/USB/Linux-i386/850_make_USB_bootable.sh.

Tell WHY in DebugPrint in 320_autoexclude.sh :
In layout/save/default/320_autoexclude.sh tell WHY in DebugPrint message: 
Before (e.g. when something is mounted below tmp): 
"Automatically excluding filesystem /tmp/sdb" 
Now: 
"Automatically excluding filesystem /tmp/sdb (belogs to /tmp in AUTOEXCLUDE_PATH)" 
Noticed while reproducing https://github.com/rear/rear/issues/3101

New RECOVERY_COMMANDS array (#3089) :
New RECOVERY_COMMANDS array (plus RECOVERY_COMMANDS_LABEL) 
to specifiy the "rear recover" commands which are automatically called 
after the ReaR recovery system has started up to recreate the system 
in 'auto_recover'/'automatic' or 'unattended' mode. 
By default "rear recover" is called (which was hardcoded before). 
See https://github.com/rear/rear/pull/3070#discussion_r1397363473 
Additionally in skel/default/etc/scripts/system-setup call bash 'read' 
with a 'timeout' (normally 30 seconds or 3 seconds in unattended mode) 
to automatically proceed (in particular in unattended mode), 
cf. https://github.com/rear/rear/issues/1366 

Merge pull request #3070 :
New REBOOT_COMMANDS config array variable: 
In skel/default/etc/scripts/system-setup 
replaced the hardcoded 'reboot' 
by using a REBOOT_COMMANDS array 
(plus REBOOT_COMMANDS_LABEL string) 
so the user could specify a alternative command 
like 'shutdown' or 'poweroff' 
see https://github.com/rear/rear/issues/3068 
or a sequence of commands if needed 
(plus a label that is shown to the user). 
Additionally in skel/default/etc/scripts/system-setup: 
Use USER_INPUT_INTERRUPT_TIMEOUT 
and USER_INPUT_UNATTENDED_TIMEOUT 
instead of hardcoded 'sleep' timeout values 
to speed up things in 'unattended_recovery' mode. 
Show non-zero exit codes to the user 
when sourcing config files failed. 
Abort when /usr/share/rear/conf/default.conf 
does not exist (or is empty). 
Set SECRET_OUTPUT_DEV="null" 
also for sourcing other config files (e.g. local.conf), cf. 
https://github.com/rear/rear/commit/9629b29dbbb73efb6229c4bfc509d1fcb70b29e3 

Merge pull request #3079 :
Do not mount /sys if already mounted:
Newer versions of systemd (starting with Fedora 39) seem to mount /sys
themselves. Mounting it again leads to errors on the recovery system
startup (startup scripts failing with status=219/CGROUP ), see
https://github.com/rear/rear/issues/3017.
Check if /sys is already mounted using the `mountpoint` tool and mount it
only if it is not.
Do the same for the other system mountpoints like /proc, /dev, /dev/pts.
Not sure if they suffer from the same problem, but they probably could.
N.B. the 'mountpoint' command is already among REQUIRED_PROGS.

Merge pull request #3078 :
Mention xorrisofs when no ISO image tool is found:
xorrisofs is supposed to be the preferred method, so mention it first
among the suggested tools that the user can install to produce an ISO
image if none is found.

Merge pull request #3073 :
Link back to the PR & issue #3064 from code.
Resolve libs for executable links in COPY_AS_IS :
Do not skip symbolic links when adding libraries required by executables
in COPY_AS_IS. The symlink targets will be copied later by
build/default/490_fix_broken_links.sh.  We thus need library
dependencies for symlinked executables just like for normal executables
and build/default/490_fix_broken_links.sh does not perform library
dependency scan, so we need to do it at the same place as for normal
executables (in build/GNU/Linux/100_copy_as_is.sh). Otherwise it can
happen that we add a (broken) symlink via COPY_AS_IS, the actual
executable is then added by build/default/490_fix_broken_links.sh, but
without its libraries, and "rear mkrescue" then fails because required
libraries are missing. Happens for example with
/usr/lib/systemd/systemd-sysv-install, which is a symlink to
/bin/chkconfig and gets added to COPY_AS_IS in
prep/GNU/Linux/280_include_systemd.sh.
Gets rid of one exception for symlinks, which looks good in any case
(shorter and simpler code).

Merge pull request #3072 :
New USER_INPUT_UNATTENDED_TIMEOUT config variable 
to specify the timeout in seconds (by default 3) 
for how long UserInput() waits for user input 
when ReaR is run in 'unattended' or 'non-interactive' mode. 

Update default.conf :
In default.conf describe that 
with MIGRATION_MODE='TRUE' ('TRUE' in uppercase letters) 
one can enfore MIGRATION_MODE also when 
"rear recover" is run in 'unattended' or 'non-interactive' mode.

Update 250_compare_disks.sh :
In layout/prepare/default/250_compare_disks.sh 
use USER_INPUT_INTERRUPT_TIMEOUT (default 30) 
instead of USER_INPUT_TIMEOUT (default 300) 
because USER_INPUT_INTERRUPT_TIMEOUT matches better 
the intent of the user confirmation dialog 
when "Disk configuration looks identical"

Merge pull request #3061 :
Fix comments and error message obsolete since #2903.
Explain the use of LV options in disklayout.
Save LVM pool metadata volume size in disk layout:
Instead of letting LVM use the default pool metadata volume size when
restoring a layout with thin pools, use the size from the original
system. The pool metadata size will be saved in disklayout.conf as the
new key "poolmetadatasize" on the thin pool LV.
This makes the layout of the recovered system closer to the original
system.
Prevents some cases of recovery failures during layout restoration: if
the original system used a non-default (in particular, smaller) metadata
volume size, and the space in the VG was fully used, there would not be
enough space in the VG for recovery of all LVs (as layout restoration
would create a larger pool metadata size than before and if restoring to
disks of the same size, the space will be missing elsewhere).

Merge pull request #3058 :
Skip useless xfs mount options when mounting during recovery:
The mount command displays all mount options for a filesystem, including
those that are not explictitly set in fstab, and ReaR saves them to disk
layout. In the case of XFS, some of them can be harmful for mounting the
filesystem during layout restoration:
The logbsize=... mount option is a purely performance/memory usage
optimization option, which can lead to mount failures, because it must
be an integer multiple of the log stripe unit and the log stripe unit
can be different in the recreated filesystem from the original
filesystem (for example when using MKFS_XFS_OPTIONS, or in some exotic
situations involving an old filesystem, see GitHub issue #2777 ). If
logbsize is not an integer multiple of the log stripe unit, mount fails
with the warning "XFS (...): logbuf size must be greater than or equal
to log stripe size" in the kernel log (and a confusing error message
"mount: ...: wrong fs type, bad option, bad superblock on ..., missing
codepage or helper program, or other error." from the mount command),
causing the layout restoration in the recovery process to fail.
Wrong sunit/swidth can cause mount to fail as well, with this in the
kernel log: "kernel: XFS (...): alignment check failed: sunit/swidth vs.
agsize".
Therefore, remove the logbsize=... and sunit=.../swidth=... from XFS
mount options before mounting the file system.
(Another possibility would be to remove them already when saving the
layout, in layout/save/GNU/Linux/230_filesystem_layout.sh, but I decided
to follow the example of btrfs here.)

Update 450_check_BACULA_client_configured.sh :
In prep/BACULA/default/450_check_BACULA_client_configured.sh 
show the command or file name to the user if one is missing 
to make it clear to the user what exactly is missing. 
This enhancement was triggered by 
https://github.com/rear/rear/issues/3060

Merge pull request #2961 :
For the automated serial console setup for the recovery system 
use only the 'console=...' kernel arguments from the original system 
which fixes https://github.com/rear/rear/issues/2843 
and it means that no longer all "real serial devices" get 
auto-enabled as serial consoles in the recovery system, see 
https://github.com/rear/rear/pull/2749#issuecomment-1196650631 
That new default behaviour is described in default.conf. 
In particular prep/GNU/Linux/200_include_serial_console.sh 
and lib/serial-functions.sh were overhauled which results 
that rescue/GNU/Linux/400_use_serial_console.sh is obsolete. 

Update 510_current_disk_usage.sh :
In layout/save/GNU/Linux/510_current_disk_usage.sh 
USB_DEVICE_FILESYSTEM_LABEL must not be empty, otherwise 
readlink -f "/dev/disk/by-label/$USB_DEVICE_FILESYSTEM_LABEL" 
would result '/dev/disk/by-label'

Update 400_save_directories.sh :
In prep/default/400_save_directories.sh 
USB_DEVICE_FILESYSTEM_LABEL must not be empty, otherwise 
grep -vE "this|that|$USB_DEVICE_FILESYSTEM_LABEL" 
would output nothing at all.

Merge pull request #3054 :
Fail safe USB_DEVICE_BOOT_LABEL setting and fallback: 
In output/USB/Linux-i386/300_create_grub.sh 
check with "lsblk -no LABEL $RAW_USB_DEVICE" 
if something with USB_DEVICE_BOOT_LABEL exists on the USB device 
and if not try to use USB_DEVICE_FILESYSTEM_LABEL 
if something with that label exists on the USB device 
and if yes use that as USB_DEVICE_BOOT_LABEL, 
otherwise error out

Update default.conf :
In default.conf better (more generic) description 
of USB_DEVICE_FILESYSTEM_PERCENTAGE 
that also takes a possible 'bios_grub' partition 
and an optional boot partition into account.

Merge pull request #3053 :
Better description of BACKUP=RBME in default.conf - triggered by 
https://github.com/rear/rear/issues/3050#issuecomment-1748197886

Merge pull request #3047 :
Skip invalid disk drives (zero sized, no media) when saving layout:
Explain what a disk validation error means.
Revert "Update 200_partition_layout.sh":
This reverts commit 0a1d634ed15500bb21f37ac1bbb11c8a4bb11545.
We now skip disks with no data (like when there is no medium), so
incomplete disk entries (without partition type) should not occur
anymore. Restore the code that aborted when such disks were encountered.
Incomplete entries should not be allowed to occur, as they could confuse
the layout restoration code. Moreover, the layout restoration wipes
all disks in the layout, so if during layout restoration there happens
to be a medium in the drive that was empty during layout save, the data
on the medium would get overwritten and lost. And if there is not medium,
the layout recreation script would fail.
See the discussion at https://github.com/rear/rear/issues/2958#issuecomment-1479588829
Validate disk when saving layout :
Introduce function is_disk_valid, which performs checks for disk
usability beyond validating the device name. In some cases the device
name may be valid, but there are no data, typically because it is a
drive with removable media and there is no medium in the tray. Happens
typically with card (e.g. SD card) readers with empty slot.
This is a normal occurrence, so do not Error out, only display a message
and skip the device.
Move "parted $devname" after validation of $devname:
This prevents errors when parted is called on an invalid device.

Merge pull request #3043 :
Remove the lvmdevices file at the end of recovery :
The file /etc/lvm/devices/system.devices restricts LVM to disks with
given (hardware) IDs (serial numbers, WWNs). See lvmdevices(8).
Unfortunately, when restoring to different disks than in the original
system, it will mean that LVM is broken in the recovered system (it
won't find any disks).  Therefore it is safer to remove the file to
force the old behavior where LVM scans all disks. This used to be the
LVM default (use_devicesfile=0).

Merge pull request #3038 :
In the DoExitTasks function skip 'sleep 3' 
when all went well and DoExitTasks is called at normal exit 
to avoid needless 3 seconds delay of normal end of program.

Merge pull request #3037 :
Avoid multiple 'set -x' messages for one message output function call (like LogPrint): 
In lib/_input-output-functions.sh use '2>>/dev/$DISPENSABLE_OUTPUT_DEV' 
for all functions that output messages (print on the terminal or log something) 
to avoid that in debugscript mode 'set -x' debug messages 
about message output functions appear more than once in the log file. 
E.g. for "LogPrint 'text'" such 'set -x' debug messages appeared three times: 
The first one for the initial "LogPrint 'text'" call plus two more 
for the subsequently resulting "Log 'text'" and "echo 'text" calls. 
Now only one 'set -x' debug message appears in the log: 
Only the first one for the initial message output function call.

Merge pull request #3039 :
In doc/rear.8.adoc describe the new -e/--expose-secrets option 
see https://github.com/rear/rear/pull/3006 
and https://github.com/rear/rear/issues/2967 
Additionally a more exact description what the non-interactive mode does 
and some general simplifications of other GLOBAL OPTIONS texts.

Set SECRET_OUTPUT_DEV in etc/scripts/system-setup :
In usr/share/rear/skel/default/etc/scripts/system-setup 
set SECRET_OUTPUT_DEV="null" before sourcing default.conf 
see https://github.com/rear/rear/pull/3034#issuecomment-1691609782

Merge pull request #3036 :
Overhauled init/default/998_dump_variables.sh 
so that its intended functionality happens 
only when explicitly requested by the user 
by calling 'rear' with the 'expose-secrets' option 
to avoid that possibly confidential values 
are output into the log file by accident, see 
https://github.com/rear/rear/issues/2967

Merge pull request #3034 :
Use '{ SECRET COMMAND ; } 2>>/dev/$SECRET_OUTPUT_DEV' 
instead of '{ SECRET COMMAND ; } 2>/dev/null' 
because '{ ... ; } 2>>/dev/$SECRET_OUTPUT_DEV' 
makes debugging still possible for the user 
by calling rear with the '--expose-secrets' option 
and SECRET_OUTPUT_DEV makes it clear which redirections 
are explicitly meant to hide secrets to distinguish them 
from usual unwanted output discard via '2>/dev/null' 
see https://github.com/rear/rear/pull/3006 
and https://github.com/rear/rear/issues/2967 

Update authtoken-functions.sh :
In lib/authtoken-functions.sh 
added a comment that explains that the functions 
in lib/authtoken-functions.sh are currently meant 
to be only executed within the environment where 
the ReaR system startup script /etc/scripts/unlock-opal-disks is running 
which is a pre-boot volatile environment 
where all secret user-input happens only in that pre-boot environment, 
and the image is immutable (PBA-area is RO on locked drive), 
see https://github.com/rear/rear/issues/3035

Merge pull request #3031 :
Secure Boot support for OUTPUT=USB: 
In output/USB/Linux-i386/100_create_efiboot.sh 
added SECURE_BOOT_BOOTLOADER related code that is based 
on the code in output/ISO/Linux-i386/250_populate_efibootimg.sh 
with some adaptions to make it work within the existing USB code. 
The basic idea for Secure Boot booting of the ReaR recovery system 
is to "just copy" the (signed) EFI binaries of the Linux distribution 
(shim*.efi and grub*.efi as first and second stage UEFI bootloaders) 
instead of let ReaR make its own EFI binary via build_bootx86_efi() 
see https://github.com/rear/rear/pull/3031

Merge pull request #3030 :
In format/USB/default/200_check_usb_layout.sh 
error out if USB_DEVICE_FILESYSTEM is invalid 
instead of silently using the default value 'ext3' 
because it is clearer to abort for configuation errors 
than silently "correcting" a users's specified value, 
see https://github.com/rear/rear/issues/3029 

Merge pull request #3025 :
Fixed create_grub2_cfg function usage: 
Introduced GRUB2_SET_ROOT_COMMAND config variable 
in addition to the existing GRUB2_SEARCH_ROOT_COMMAND 
to get consistency how GRUB2 sets and/or searches its 'root' device 
and adapted the create_grub2_cfg function calls accordingly. 
Furthermore enhanced some messages regarding Secure Boot setup.

Merge pull request #3027 :
In build/GNU/Linux/100_copy_as_is.sh 
ensure to really get all COPY_AS_IS files copied by using 
'tar ... -i' when extracting to avoid a false regular exit of 'tar' 
in particular when padding zeroes get added when a file being read shrinks 
because for 'tar' (without '-i') two consecutive 512-blocks of zeroes mean EOF, 
cf. https://github.com/rear/rear/pull/3027

Update 830_copy_kernel_initrd.sh :
In output/USB/Linux-i386/830_copy_kernel_initrd.sh 
make it clear in the log file that the log file on USB is unfinished 
so when one is looking at such a log file on USB from another user 
one gets not confused why things are missing (e.g. the 'backup' stage) in such a log file 
cf. https://github.com/rear/rear/issues/3017#issuecomment-1620385835

Merge pull request #3023 :
In prep/SESAM/default/400_prep_sesam.sh 
do no longer add SESAM_WORK_DIR to COPY_AS_IS_EXCLUDE. 
After the SESAM excludes have been fixed 
via https://github.com/rear/rear/pull/3019 
tests with more recent sesam client versions have shown 
that the service fails to start up during recovery image boot 
due to missing semaphore files. Removing the sesam work directory 
where those information is stored from the excludes solves this problem. 
See https://github.com/rear/rear/issues/3018

Merge pull request #3019 :
In lib/sesam-functions.sh 
fix default exlude paths for BACKUP=SESAM 
because the exclude paths did contain a trailing '/' 
so 'tar' did not match ('tar' is picky about exclude items) 
and then things ended up in the ISO image, 
see https://github.com/rear/rear/issues/3018

Merge pull request #3006 :
New --expose-secrets option plus SECRET_OUTPUT_DEV: 
In sbin/rear added --expose-secrets option and SECRET_OUTPUT_DEV. 
Script code usage example: 
{ SECRET COMMAND ; } 2>>/dev/$SECRET_OUTPUT_DEV 
In lib/_input-output-functions.s added LogSecret function. 
Script code usage example: 
{ LogSecret "secret text" || Log "public text" ; } 2>>/dev/$SECRET_OUTPUT_DEV 
Both are requirements to solve 
https://github.com/rear/rear/issues/2967 

Merge pull request #2991 :
ISO OUTPUT Improvements to filter RESULT_FILES transferred

Merge pull request #2980 :
SYSLINUX timeout is now a configuration item

Merge pull request #2988 :
Implement non-interactive mode to abort on repeated UserInput calls in the absence of user interaction.
Add fully automated restore to REQUESTRESTORE, where ReaR waits for a signal file to appear.
Mention experimental state of non-interactive mode in README.

In layout/save/GNU/Linux/200_partition_layout.sh 
also show the disk device in the 
"Unsupported partition table" error message 
to make it meaningful on systems with more than one disk.
Add fallback wipefs command for CentOS 6.
Add -f (force) option to wipefs command in 120_include_raid_code.sh

Do not leak the SSH_ROOT_PASSWORD value into the log file: 
In build/default/500_ssh_setup.sh 
rescue/default/500_ssh.sh 
restore/YUM/default/970_set_root_password.sh 
restore/ZYPPER/default/970_set_root_password.sh 
run commands that deal with SSH_ROOT_PASSWORD 
in a confidential way via { confidential_command ; } 2>/dev/null 
see https://github.com/rear/rear/issues/2967

Do not leak the OPAL_PBA_DEBUG_PASSWORD value into the log file :
In prep/OPALPBA/Linux-i386/001_configure_workflow.sh 
run commands that deal with OPAL_PBA_DEBUG_PASSWORD 
in a confidential way via { confidential_command ; } 2>/dev/null 
see https://github.com/rear/rear/issues/2967

Merge pull request #2985 :
Do not leak the GALAXY11_PASSWORD value into the log file: 
In verify/GALAXY11/default/420_login_to_galaxy_and_setup_environment.sh 
run commands that deal with GALAXY11_PASSWORD 
in a confidential way via { confidential_command ; } 2>/dev/null 
see https://github.com/rear/rear/issues/2967

Update 04-scenarios.adoc :
In doc/user-guide/04-scenarios.adoc 
explain that when a command like 
export VAR='secret_value' 
is run on the original system, then one must ensure 
to not keep that command in a shell history file. 
This is an addedum to 
https://github.com/rear/rear/pull/2156 
which was triggered by what was done in 
https://github.com/rear/rear/pull/2982

Update default.conf :
In default.conf cleaned up all cases of variables for secret values 
by having a generic explanatory comment at the beginning 
(instead of several similar comments at each place) and 
by setting such variables always via { VAR=... ; } 2>/dev/null 
to mark them for us and our users that they are meant for secret values 
and also to provide templates how to set such variables properly 
in user config files (e.g. local.conf or site.conf).
In default.conf incresed the default USER_INPUT_INTERRUPT_TIMEOUT 
from 10 seconds to 30 seconds because 10 seconds is far too little time 
to read and understand the possibly unexpected UserInput() message 
and then some more time to make a decision whether or not 
the automated action is actually the right one.
In default.conf make it clear that 
BACKUP_PROG_ARCHIVE is the backup file basename for BACKUP=NETFS 
but for BACKUP=RSYNC it is the backup log file basename and that 
RSYNC_PREFIX is the destination prefix directory 
where a 'backup' sub-directory will be created, see 
https://github.com/rear/rear/issues/2978

NFS4SERVER as new restore method (#2973) :
Added new backup method NFS4SERVER for restore via NFSv4 export (restore only)
Add ability to abort NFS4SERVER restore.

Merge pull request #2878 :
Exclusions for Veritas Cluster Filesystem, solving https://access.redhat.com/solutions/3214491 by default.

Merge pull request #2963 :
OBDR fixes for modern systems using hpsa driver:
Add more details in comment why and how we need to better handle output from lsscsi.
Previosly we would search only on fixed character possitions 2 4 6 8 in a line,
which on some systems with larger nubmber of devices doesn't have to be correct.
Search exactly only for 'cciss' and 'hpsa' modules. 
We need ISO to be created already in /var/lib/rear/output/rear-${HOSTNAME}.iso,
so add from ISO ../../ISO/Linux-i386/820_create_iso_image.sh.
Subsequentlyt we'll need to rename writing of ISO to tape to later stage,
so rename it from 810_write_image.sh to 840_write_image.sh.
Refactor how we'll look for a device.
In case of large number of connected devices f.x. [6:0:15:0] tape HP Ultrium 5-SCSI Y6PW /dev/st11
devices might not be recognized properly.
HP cciss driver was replaced by hpsa driver so consider it when checking tapes.

Merge pull request #2965 :
Add proper Python support / fix GALAXY11-related issues.
Add Galaxy Home Dir to checklayout verification.
Notice changes in GALAXY11 client to trigger recreation of rescue image.
Use dynamically determined path where galaxy home dir is located.
This is an example implementation for #2951 to run the complete prep stage
for checklayout as the Galaxy client configuration is determined there.
Include Python and dependencies.
Handling symlinks for Python interpreter.
Choose Python interpreter and stdlib only.
Copy full site and dist packages as well.

Update rear :
In sbin/rear quoting is mandatory in test -d "$TMP_DIR" 
otherwise 'test -d' falsely succeeds if $TMP_DIR is empty, cf. 
https://github.com/rear/rear/issues/2966#issuecomment-1497825493

Merge pull request #2950 :
ReaR in Docker for development & fix package dependencies.
Simple way to run a command via Docker in all, 
some or specific distros that are relevant for ReaR.
multi-arch support for run-in-docker

Merge pull request #2907 :
In rescue/GNU/Linux/310_network_devices.sh 
use now output of 'ls /sys/class/net/' to select all available interfaces 
regardless whether or not interfaces are configured / have an IP address 
(to exclude unwanted interfaces use EXCLUDE_NETWORK_INTERFACES) 
instead of before 'ip r' that defaults to 'ip -4 r' (so 'ip -6 r' was ignored) 
in particular to make networking also work with IPv6 only NICs 
see https://github.com/rear/rear/issues/2902 

Merge pull request #2956 :
New OpalPBA AuthToken feature: 
Added AuthToken generation & disk-unlocking into OpalPBA image. 
Currently encrypted tokens are stored on and read from 
plain Linux block device (e.g. USB drive, SDCard, etc). 
Supports TPM2-assisted encryption, so tokens can be made 
secure and tightly bound to device/boot environment. 
Supports 2FA authentication (additional password/pin to decrypt token) 
with basic brute-force protection. 
Allows for unattended cold booting optionally restricted 
to SecureBoot-active environment only. 
See https://github.com/rear/rear/pull/2956 

Update default.conf :
In default.conf added 'mt' command to REQUIRED_PROGS_OBDR 
because 'mt' is required for restore (e.g. seek with fsf), see 
https://github.com/rear/rear/issues/2637#issuecomment-1475690995

Merge pull request #2909 :
Inform the user when it could not umount something in certain cases: 
In output/ISO/Linux-i386/700_create_efibootimg.sh 
make umounting the EFI virtual image more fail-safe: 
When normal 'umount' fails 'sleep 1' and retry normal 'umount' 
and if it still fails log 'fuser' info and try 'umount --lazy' and if that 
also fails show the user a LogPrintError and proceed bona fide 
so the user can understand why later at the end 
cleanup_build_area_and_end_program() may show 
"Could not remove build area" 
if lazy umount could not clean up things until then, 
cf. https://github.com/rear/rear/issues/2908 
In restore/NETFS/default/400_restore_backup.sh and 
same also in restore/YUM/default/410_restore_backup.sh 
it calls umount "$BUILD_DIR/outputfs" 
because BUILD_DIR/outputfs is needed as mountpoint 
to mount something (a medium that contains the backup) 
so inform the user about an umounting failure 
(if there was something mounted at BUILD_DIR/outputfs) 
so he can understand why the subsequent mounting fails 
or why several things got mounted stacked one over the other.

Merge pull request #2937 :
Add support for Commvault Galaxy 11
New feature DISABLE_DEPRECATION_ERRORS to error out for deprecated code paths with option to override this.
New variable USE_RAMDISK configures rescue system to use a ramdisk for tools that need to check for free disk space.
Rework GALAXY11 to use ramdisk feature and set PATH globally.
Use Ramdisk for older Galaxy versions too.
Improve rear shell to stay in SHARE_DIR after using Source and add show helper.
Support multiple -C options and log runtime configuration.
Enable running from checkout and specify -C /etc/rear/local.conf to use host ReaR configuration.

Update 100_include_partition_code.sh :
In layout/prepare/GNU/Linux/100_include_partition_code.sh 
verify we could read the intended 'disk /dev/sdX ' entry (with trailing space) 
from disklayout.conf and BugError if that fails, cf. 
https://github.com/rear/rear/issues/2958#issuecomment-1477963982

Update 950_verify_disklayout_file.sh :
In layout/save/default/950_verify_disklayout_file.sh 
add 'dasd' to the error message because 'dasd' is 
also an allowed partition label in disklayout.conf 
since https://github.com/rear/rear/pull/2142

Merge pull request #2954 :
Better user messages for finalize/default/060_compare_files.sh 
In particular show some keywords to trigger the right idea 
in the user's mind what this stuff actually is about: 
Consistency of what was recreated with his restored backup. 
See https://github.com/rear/rear/issues/2952 
and https://github.com/rear/rear/pull/2954

Update 200_run_layout_code.sh :
lsblk MOUNTPOINTS works on SLES15-SP4 but not on SLES15-SP3 
(on SLES15-SP3 only MOUNTPOINT works)

Merge pull request #2953 :
New prep/default/990_verify_empty_rootfs.sh 
to verify untouched ROOTFS_DIR at the end of 'prep' 
plus enhanced prep/README to better explain 
why ROOTFS_DIR must not be touched by 'prep' scripts, 
see https://github.com/rear/rear/issues/2951

Update 001_verify_config_arrays.sh :
In init/default/001_verify_config_arrays.sh 
do not check comment lines for falsely assigned array variables 
cf. https://github.com/rear/rear/pull/2932 
and https://github.com/rear/rear/issues/2930

Merge pull request #2947 :
In layout/save/GNU/Linux/240_swaps_layout.sh
layout/save/GNU/Linux/230_filesystem_layout.sh
layout/save/GNU/Linux/200_partition_layout.sh
replaced the subshell that appends its stdout to DISKLAYOUT_FILE 
by a group command with redirection: { ... } >> $DISKLAYOUT_FILE 
see https://github.com/rear/rear/issues/2927#issuecomment-1440044143

Merge pull request #2943 :
s390x (IBM Z) disk formatting fixes
Enable DASDs also during "rear mountonly".
Add default value for FORMAT_DASDS to default.conf :
The default value is "" and it means to format the DASDs by default, in
an analogy with DISKS_TO_BE_WIPED.
Allow the user to skip DASD formatting entirely :
Allow to choose to skip DASD formatting from the DASD format script
confrmation dialog. Can be also set by setting the FORMAT_DASDS variable
to a false value.
Use mapping hints for comparing and mapping disks :
When disk mapping hints (DISK_MAPPING_HINTS) indicate we know the
correct mapping for a disk, use them in preference to device name and
size comparison. They are supposed to be more reliable and also they
are set by the s390-specific code for disks (DASDs) that are not yet
formatted and thus their size is not yet known, so guessing according to
disk size does not work properly.
Skip excluded components when creating DASD format :
520_exclude_components.sh excludes them as well, we run before it, so we
have to reimplement it here.
Always let the user confirm the DASD format script :
Reformatting is a dangerous operation, equivalent to wiping disks (which
we also let the user always confirm).
Adapt DASD activation and formatting :
Adapt to the new format of disklayout.conf entries (dasd_channel and
disk directives).
Move the DASD formatting code after the mapping code. Otherwise when
device names change, the code would format the old names, not the new
names.
Generate the DASD formatting code as a separate script and let the
user confirm it before it gets executed. Heavily inspired by the disk
wiping code (it is similarly destructive), but executed during the
"layout/prepare" stage and not during the "layout/recreate" stage. The
reason is that unformatted DASDs do not have their size in bytes known
(it depends on format), but other scripts in the "layout/prepare"
stage need to know the disk sizes (e.g. for resizing partitions).
The disk comparison and mapping script will now be less accurate,
because it won't know the current sizes if disks are not formatted. To
compensate, introduce a variable called DISK_MAPPING_HINTS that allows
the DASD activation code to pass the information on changed disk names
to the rest of the layout code (the identification is based on virtual
device numbers).
Layout changes and fixes for S/390 DASDs :
Simplify syntax of dasd_channel directive. The previous syntax had
some useless fields, like the major:minor number and status.
Fix obtaining the entry from lsdasd output: "grep $blockd" did not
work properly, because if $blockd == dasda and there also disks named
dasdaa and dasdab (this will be the case with more than 26 DASDs), the
command would print all three lines instead of just the correct one
and break the resulting format.
Eliminate the "dasdfmt" directive, merge its fields into
the "disk" directive. This has the advantage that the exclusion code
eliminates the "disk" lines for unused disks automatically.
Previously, the "dasdfmt" lines for unused disks stayed in the layout
file, which later caused the unused disks to be reformatted
unconditionally (including disk with the backup itself on
it if one used a local storage for backup).
Unfortunately it means that the format of the "disk" directive now
depends on the disk label type: dasd disks have extra fields that
other disk types don't have.
Add information about number of cylinders to the disk directive for
DASDs, it is more stable than the size in bytes (which depends on
the format). Currently unused.

Update rear :
In usr/sbin/rear show different messages for different things 
(config file cannot be read versus config file cannot be sourced) 
to avoid that the user gets two times the same message 
which looks like an unintended duplicated output 
but actually it is two messages for two similar things. 
Triggered by https://github.com/rear/rear/issues/2936

Merge pull request #2932 :
check for wrong syntax of array assignments in user configs
(disabled on ancient systems with bash 3)

Update 330_find_isolinux.sh :
In prep/ISO/Linux-i386/330_find_isolinux.sh 
less misleading error message when isolinux.bin cannot be found 
(no longer show a distribution specific software package name), 
see https://github.com/rear/rear/issues/2921

Update 230_filesystem_layout.sh :
In layout/save/GNU/Linux/230_filesystem_layout.sh 
add 'chattr' to REQUIRED_PROGS (and not only to PROGS) 
because 'chattr' is called in diskrestore.sh 
see https://github.com/rear/rear/issues/2927

Update 420_autoresize_last_partitions.sh :
Fixed fallback assignments of mandatory values 
to not let them evaluate to nonsense commands, see 
https://github.com/rear/rear/issues/2926

Merge pull request #2915 :
In lib/serial-functions.sh make the 
get_serial_console_devices() function 
fail-safe if no serial device node exists, see 
https://github.com/rear/rear/issues/2914

Merge pull request #2910 :
In finalize/Linux-ppc64le/660_install_grub2.sh remove the 
"mount --bind <proc|sys|dev> at TARGET_FS_ROOT" 
section because that is meanwhile done generically in 
finalize/default/110_bind_mount_proc_sys_dev_run.sh 
since https://github.com/rear/rear/issues/2045 
but there the file finalize/Linux-ppc64le/..._install_grub2.sh 
was accidentally forgotten (see its initial description), 
see https://github.com/rear/rear/pull/2910 

Merge pull request #2905 :
OUTPUT=USB: Use target=i386-pc for legacy BIOS GRUB2 install on EFI systems: 
grub-install defaults to '--target=x86_64-efi' when the system is booted with EFI. 
So setting a legacy BIOS target is needed when the system is booted with EFI. 
See https://github.com/rear/rear/issues/2883

Merge pull request #2904 :
In output/USB/Linux-i386/850_make_USB_bootable.sh 
install extlinux for OUTPUT=USB also for a vfat boot partition 
because since SYSLINUX version 4.00 extlinux also works for vfat 
see https://github.com/rear/rear/issues/2884

Merge pull request #2903 :
Protect against colons in pvdisplay output :
LVM can be configured to show device names under /dev/disk/by-path
in command output. These names often contain colons that separate fields
like channel and target (for example /dev/disk/by-path/pci-*-scsi-0:0:1:0-*,
similarly the pci-* part, which contains colon-separated PCI bus and
device numbers). Since the "pvdisplay -c" output also uses colons as
field separators and does not escape embedded colons in any way,
embedded colons break parsing of this output.
As a fix, use the pipe character '|' as the field separator in pvdisplay
output. (This would break if a PV device has a '|' in its name, but this
is very much less likely than having a ':' .)
Also, configure explicitly what fields to output - "pvdisplay -c"
prints many fields, but I have not found documentation about what fields
is it using exactly, so one had to guess what the output means. Using
"pvdisplay -C" and selecting the fields explicitly is much clearer.
This also changes the PV size field to match documentation, the comment
says that size is in bytes, but it actually was not in bytes. As nothing
is actually using the PV size field, this inconsistency has not caused
any problem in practice, and no code needs adjusting for the change.

Merge pull request #2901 :
BACKUP=BAREOS: fix bconsole CLI argument format in 
prep/BAREOS/default/500_check_BAREOS_bconsole_results.sh 
Bareos 22 introduced a breaking change how its CLI tools 
(such as bconsole) parse the arguments. 
Before it was "bconsole -xc" but since Bareos 22 it must be "bconsole --xc" 
(otherwise it terminates with exit code 113 so "rear mkrescue" will fail). 
Before "bconsole ...xc" is called, it now checks the bconsole version 
and uses the new argument format '--xc' when version >= 22. 
The backward compatible fallback is "bconsole -xc".

Update 340_generate_mountpoint_device.sh :
Fix a false and misleading comment in 
layout/save/default/340_generate_mountpoint_device.sh 
because var/lib/rear/recovery/mountpoint_device does not contain 
"the list of mountpoints and devices to exclude from backup". 
Instead it contains the list of mountpoints and devices 
to be automatically / implicitly included in the backup via 
backup/NETFS/default/400_create_include_exclude_files.sh 
except those where the mountpoint is in the excluded_mountpoints array 
which is generated from what is specified in EXCLUDE_BACKUP, see also 
https://github.com/rear/rear/issues/2906#issuecomment-1369902659

Merge pull request #2894 :
For BACKUP=SESAM with SESAM version 5.x two more directories 
$SM_BIN_SESAM/python3/ and $SM_BIN_SMS are needed 
in SESAM_LD_LIBRARY_PATH to avoid missing libraries 
(SM_BIN_SMS is defined in the config file set in sesam2000ini_file). 
The reason behind is that SEP has obsoleted python2 to python3, 
and additional libraries are now included within the python3 subdirectory. 
Additionally RTS components need additional libraries from the SMS subfolder. 
See https://github.com/rear/rear/pull/2894 

Update default.conf :
In default.conf tell what gets stored in the ESP on a USB disk: 
The ReaR recovery system kernel and initrd and BOOTX64.efi 
cf. https://github.com/rear/rear/pull/2829#issuecomment-1168547117 
and https://github.com/rear/rear/issues/2881
In default.conf also tell that grub.cfg is stored in the ESP 
on a USB disk to have that part of the description complete 
cf. https://github.com/rear/rear/pull/2829#issuecomment-1168547117

Merge pull request #2876 :
Implement initial basic 'barrel' support as a first step 
mainly in layout/recreate/default/200_run_layout_code.sh 
and in the new layout/save/default/550_barrel_devicegraph.sh 
Barrel is a command-line program for storage management 
in particular for a SUSE specific storage layout 
which is available since SLES15-SP4, see 
https://github.com/aschnell/barrel 
Barrel can save and recreate a whole storage layout, see 
https://github.com/rear/rear/issues/2863 
The current basic 'barrel' support is implemented as optional 
and additional possibility when the 'barrel' program is there. 
ReaR's native method via disklayout.conf and diskrestore.sh 
is still used and working unchanged as before in parallel 
so that when 'barrel' is used during "rear recover" but it fails, 
the user can switch back to recreating with diskrestore.sh 
which is the reason for some new choices during "rear recover", 
in particular "Again wipe the disks in DISKS_TO_BE_WIPED" 
to wipe what 'barrel' had setup before diskrestore.sh is run. 
Additionally during "rear recover" it shows now 'lsblk' output 
on the user's terminal to make it easier for the user to see 
what disk layout got recreated to decide if that is right or wrong. 
Furthermore there is now the new choice to 
"Confirm what is currently on the disks and continue 'rear recover'" 
so that the user can manually fix things (in particular smaller things) 
by only using the ReaR shell and then confirm what he created 
on his disks and continue with restoring the backup, see 
https://github.com/rear/rear/pull/2876 

Merge pull request #2873 :
Fix initrd regeneration on s390x and Fedora/RHEL :
For some reason, the 550_rebuild_initramfs.sh script was not included
for s390x on Fedora/RHEL so the initrd was not regenerated after backup
restore on this architecture.
Since all other architectures were actually using the same script,
let's just move it one level up to fix this bug and to also simplify
the directory structure a bit.

Merge pull request #2872 :
In default.conf more accurate description of BACKUP=EXTERNAL 
and PING to better match what is actually implemented, see 
https://github.com/rear/rear/issues/2870#issuecomment-1261045942 
plus some general improvements of all the comments 
e.g. removed the colloquial word 'stuff' where not useful and 
made blocks of config variables that belong together more clear 
by using '####' as indicators where a block begins and ends. 

Merge pull request #2868 :
In the UserInput function drain stdin if stdin is a terminal (i.e. in interactive mode): 
The primarily intended use case is to discard possibly already existing characters 
(in particular ENTER keystrokes) from stdin to avoid that 
when the user had accidentally hit ENTER more than once 
in (or after) a previous UserInput dialog (or another dialog) 
then those additional ENTER characters would be already in stdin 
and let the next UserInput dialog proceed unintendedly automatically 
without an explicit ENTER from the user for this current dialog, 
see https://github.com/rear/rear/issues/2866 

Merge pull request #2857 :
In output/PXE/default/810_create_pxelinux_cfg.sh 
insert missing '$pxe_link_prefix' for the IP case 
also for the "if has_binary gethostip" part, see 
https://github.com/rear/rear/pull/2851#issuecomment-1237939248 
Additionally clean up the indentation in 
output/PXE/default/810_create_pxelinux_cfg.sh 
plus some more "cleanup" code and comments changes 
(including minor bug fixes).

Merge pull request #2859 :
By default let "rear recover" wipe disks that get completely recreated 
via DISKS_TO_BE_WIPED="" in default.conf 
In ReaR 2.7 default.conf has DISKS_TO_BE_WIPED='false' 
but now after ReaR 2.7 release this feature should be used 
by default by users who use our GitHub master code 
so that we could use it by default in ReaR 2.8. 
See https://github.com/rear/rear/pull/2514 
and https://github.com/rear/rear/issues/799

Update _input-output-functions.sh :
Since https://github.com/rear/rear/commit/74de0966a5f21fb41531e9d4711932b6df83856a 
the default USER_INPUT_INTERRUPT_TIMEOUT is 10 seconds 
so set the same default value in the UserInput() function.

Merge pull request #2851 :
In output/PXE/default/810_create_pxelinux_cfg.sh 
insert missing '$pxe_link_prefix' for the MAC case 
because PXE_CONFIG_GRUB_STYLE=y 
did not work with PXE_CREATE_LINKS=MAC 
see https://github.com/rear/rear/issues/2850

Merge pull request #2846 :
Implement a new config variable BORGBACKUP_IGNORE_WARNING 
which ignores Borg warnings (see its description in default.conf). 
Borg warnings can happen if a file changed while backing it up. 
See https://github.com/rear/rear/pull/2846

Update global-functions.sh :
Better syntax of the explanation comments 
for the is_true and is_false functions.

Merge pull request #2849 :
Use STRING+=" additional words" everywhere, 
see https://github.com/rear/rear/issues/2848

Merge pull request #2844 :
Overhauled rescue/GNU/Linux/290_kernel_cmdline.sh 
in particular to make it possible to add several already existing 
kernel options by this script with same kernel option keyword 
for example when /proc/cmdline contains 
... console=ttyS0,9600 ... console=tty0 ... 
then via COPY_KERNEL_PARAMETERS+=( console ) 
cf. https://github.com/rear/rear/pull/2749#issuecomment-1197843273 

Merge pull request #2839 :
Pass -y to lvcreate instead of piping the output of yes

Better description of COPY_KERNEL_PARAMETERS in default.conf, 
cf. https://github.com/rear/rear/pull/2749#issuecomment-1197843273


# System and Software Requirements

ReaR is written entirely in the native language for system administration: as shell (bash) scripts.
The intent is that experienced users and system admins can adapt or extend the ReaR scripts
as needed to make things work for their specific cases.

We need Bash version 4 which is standard on current GNU/Linux systems.

The default backup software used by ReaR is standard GNU/tar.

ReaR is known to work on x86 (32bit and 64bit) and ppc64le architectures.
ReaR was also ported to ia64 and arm architectures, but these are rarely tested.


# Support

Relax-and-Recover (ReaR) is a Free and Open Source Software project under GPLv3 license.

The creators of ReaR have spend many, many hours in development and support.
We may give voluntary support, but only as work-life balance allows it.
We also provide support as a service (not free of charge).

ReaR has a long history (since 2006) and we cannot support all released versions.
If you have a problem we urge you to install the latest stable ReaR version
or the development version (available on GitHub) before submitting an issue.
We understand that it is not always possible to install the latest version on hundreds of systems
so we are willing to support previous versions of ReaR when you buy a support contract.
We cannot handle all those various support requests on a voluntary base
and we give paid projects priority, therefore, we urge our customers
to buy a support contract for one or more systems.
You buy time with the core developers.

## Supported and Unsupported Operating Systems

We try to keep our "Test Matrix" wiki pages up-to-date with feedback we receive from the community.
For example for ReaR 2.8 see
[Test Matrix ReaR 2.8](https://github.com/rear/rear/wiki/Test-Matrix-ReaR-2.8)

ReaR 2.8 is supported on the following Linux operating systems:

* Fedora 29, 30, 31, 32, 33, and 34
* RHEL 6, 7, 8, and 9
* CentOS 6, 7, and 8
* Scientific Linux 6 and 7
* SLES 15
* openSUSE Leap 15.x
* Debian 8, and 9
* Ubuntu 16, 17, and 18

ReaR 2.8 dropped official support for the following Linux operating systems:

* Fedora < 29
* RHEL < 6
* CentOS < 6
* Scientific Linux < 6
* SLES < 15
* openSUSE Leap < 15.x and older openSUSE versions
* openSUSE Tumbleweed
* Debian < 8
* Ubuntu < 16

Usually ReaR 2.7 should also work on newer versions of the above listed supported Linux operating systems
but sometimes arbitrary failures can happen when software that is used by ReaR
(like partitioning tools, filesystem tools, bootloader tools, ISO image creating tools, networking tools, and so on)
changes in not fully backward compatible ways or when there are innovations of the basic system
(like kernel, storage, bootloader, init, networking, and so on)
that are not yet supported by ReaR.

In theory ReaR 2.8 should work on openSUSE Tumbleweed
but in practice arbitrary failures could happen at any time
because the Tumbleweed distribution is a pure rolling release version of openSUSE
containing the latest stable versions of all software
(cf. https://en.opensuse.org/Portal:Tumbleweed)
so arbitrary changes of any software are possible at any time
that could arbitrarily break how ReaR works.

ReaR 2.8 may still work for SLES < 15 and openSUSE Leap < 15.x
but it is no longer tested there so arbitrary regressions could appear,
in particular on systems with Bash before version 4.

ReaR 2.8 and earlier versions are known to no longer work
for the following Linux operating systems:

* RHEL 5 (and probably also CentOS 5): See issue #1766
* SLES 9 and 10: See issue #1842

If you need support for an unsupported Linux operating system you must acquire a ReaR support contract.

Requests to port ReaR to another operating system (not Linux) can only be achieved with serious sponsoring.

## Supported and Unsupported Architectures

ReaR 2.8 is supported on:

* Intel x86 (32bit and 64bit) architectures
* AMD x86 (64bit) architecture
* PPC64LE architecture

ReaR 2.8 may or may not work on:

* PPC64 processors
* Intel Itanium processors
* ARM type of processors
* IBM Z "s390x" type of processors

ReaR 2.8 is known to not support:

* old PPC (32bit) processors

If you need to get ReaR working on an architecture that is currently not supported,
you can buy consultancy from one of our official developers.


