---
layout: default
title: Relax-and-Recover - Linux Disaster Recovery
---

Relax-and-Recover (ReaR) is a setup-and-forget *Linux bare metal disaster recovery* solution.
It is easy to set up and requires no maintenance so there is no excuse for not using it.

Learn more about Relax-and-Recover from the selected usage scenarios below:

<table>
<tr>
    <th>Single Computer / Home User</th> <th>Server Farm / Data Center / Enterprise User</th>
</tr>
<tr class="images">
    <td><img src="images/laptop.png" alt="Laptop"/></td> <td><img src="images/servers.png" alt="Servers"/></td>
</tr>
<tr>
<td>
    <ul>
        <li>recover from a broken hard disk using a <a href="usage/#recovery_from_usb">bootable USB stick</a></li>
        <li>recover a broken system from your <a href="usage/#rescue_system">bootloader</a></li>
    </ul>
</td>
<td>
    <ul>
        <li>collect small ISO images on a <a href="usage/#storing_on_a_central_nfs_server">central server</a></li>
        <li>integrate with your commercial <a href="usage/#backup_integration">backup solution</a></li>
        <li>integrate with your <a href="usage/#monitoring_integration">monitoring solution</a></li>
    </ul>
</td>
</tr>
</table>

Or watch a 4-minute complete backup and restore demo. Real time, no cheating!

<iframe width="720" height="400" src="https://www.youtube-nocookie.com/embed/33326XobwYg?si=feOvXf8OlI9jvNEk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
    <a href="https://www.youtube.com/embed/33326XobwYg" target="_blank">Relax-and-Recover demo video</a>
</iframe>

Try Relax-and-Recover now. The [Quickstart guide](documentation/getting-started) takes only a few minutes!

Your environment not supported? Relax-and-Recover is modular and easy to extend.
It is GPL licensed and we welcome all feedback and contributions.

## ReaR Backup Methods

The complete list of backup methods (`BACKUP=...`) is:

* `AVA` Dell EMC Avamar / EMC Avamar
* `BACULA` Bacula
* `BAREOS` [Bareos](https://docs.bareos.org/Appendix/DisasterRecoveryUsingBareos.html#linux)
* `BLOCKCLONE` block device cloning via `dd`
* `BORG` Borg Backup
* `CDM` Rubrik Cloud Data Management
* `DP` OpenText Data Protector
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

## ReaR Concepts, Advanced Usage and Project History

To learn more about the Relax-and-Recover concepts, basic &amp; advanced usage and project history watch this 45-minute introduction by <a href="https://schlomo.schapiro.org/" target="_blank">Schlomo Schapiro</a>, project founder and maintainer:

<iframe width="720" height="315" src="https://www.youtube-nocookie.com/embed/QN6vk5DfzAk?si=7_taajKAWkDvLTN5" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
    Watch <a href="https://youtu.be/QN6vk5DfzAk" target="_blank">Relax and Recover (ReaR) - Automated Linux Recovery &amp; Open Source Project</a>
</iframe>
