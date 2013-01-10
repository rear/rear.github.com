---
layout: default
title: Relax-and-Recover installation
---

## Relax-and-Recover installation
Before Relax-and-Recover, abbreviated rear, can be installed on your Linux system you need to download it from our download page or clone it via git.

### Build a rear package from the source tree
Type `make help` to see all the options to build a rear package from within the source tree

    Relax-and-Recover make targets:
    
      validate        - Check source code
      install         - Install Relax-and-Recover (may replace files)
      uninstall       - Uninstall Relax-and-Recover (may remove files)
      dist            - Create tar file
      deb             - Create DEB package
      rpm             - Create RPM package
      pacman          - Create Pacman package
      obs             - Initiate OBS builds
    
    Relax-and-Recover make variables (optional):
    
      DESTDIR=        - Location to install/uninstall
      OFFICIAL=       - Build an official release

As seen above you can build a rpm, deb or a pacman package from the sources. However, it is likely you will see some errors due to missing packages like asciidoc and xmlto (these are needed to build the man-page of rear). You must install the missing packages before you can successfully build the rear package.

Once the rear package has been saved in the top directory of rear source tree you may install it as any other package according rpm, deb or pacman style.

### Rear dependencies before installation
As rear is written in bash you need bash as a bare minimum. Other requirements are:

    mkisofs (or genisoimage)
    syslinux (for i386 based systems)
    nfs-utils (when using NFS to store the archives)
    cifs-utils (when using SMB to store the archives)

### Install rear package
A RPM package of rear can be install as follows:

    rpm -ivh rear-1.14-1.git201211211655.fc17.noarch.rpm
