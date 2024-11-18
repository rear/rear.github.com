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

The references pointing to 'issue NNNN' refer to [GitHub issues tracker](https://github.com/rear/rear/issues).


# Relax-and-Recover Version 2.8 (November 2024)

## New features, bigger enhancements, and possibly backward incompatible changes:





## Details (mostly in chronological order - newest topmost):







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


