---
layout: default
title: Relax-and-Recover use cases
---

## Relax-and-Recover use cases
This chapter will describe some use cases in more detail.

### Integration of EMC NetWorker with Relax-and-Recover
The EMC NetWorker (or also known as Legato) versions tested with Rear were v8.0.0.1 (and higher?) For brief sake from now on we will use the abbreviation *NSR* for EMC NetWorker. Rear can work with NSR since rear-1.15 and higher.
We assuming the Linux system is a NSR client that is capable of making a *full backup* towards the NSR server. Be aware, if you rely on an external backup solution to make full backups of your system make sure you have a full backup before trying out a recover via rear. That said, when using an external backup solution as NSR rear will *not* make any backup of the internal disks!

To use NSR as backup solution with rear just add the following in the +/etc/rear/site.conf+ or +/etc/rear/local.conf+ file:

    BACKUP=NSR

To verify that the basic requirements are met just run now:

    rear mkrescue

If rear is able to communicate with the NSR server it will create an ISO image named +/var/lib/rear/output/rear-$(hostname).iso+ and you are done from the rear side. The ISO image will automatically being backed up to the NSR server by rear, so, in case of emergency you can always restore the ISO image to another computer to use it to recover this Linxu system.

Just in case you are curious, you could have a look in the +/var/lib/rear/recovery/+ directory. You will find there two files starting with +nsr_+

    nsr_server (contains the NSR server hostname)
    nsr_paths  (lists the mount points of file systems to restore via NSR)

To recover via NSR, then first of all boot from the ISO file created during the +mkrescue+ phase and at the root prompt just type

    rear -v recover

That should be it, after a full restoration via NSR of all internal file systems, rear will make the disk bootable and keeps everything mount under +/mnt/local+ for further inspection before rebooting.
