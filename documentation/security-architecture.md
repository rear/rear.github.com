---
layout: default
title: Relax-and-Recover Security Architecture
---

## Overview

Relax-and-Recover (ReaR) is a disaster recovery and system migration tool. This document describes the security architecture of ReaR and how it protects your data and systems.

In general, ReaR is designed to be secure by default. It does not expose any services or ports to the network. As ReaR is a disaster recovery tool, it requires full access to the system and its data. This means that ReaR must be run as root user. Otherwise ReaR won't be able to perform its core functions. Also, ReaR makes extensive use of low level system tools (e.g. to analyse the system and capture the system state) so that it is not feasible to run ReaR as unpriileged user. During the actual recovery, ReaR *is* the system and runs as primary process on the recovery system. This is why ReaR must be run as root user also during recovery, where it must partition the disks, format the filesystems, install the bootloader, etc.

Given this context, there are still several security measures in place that aim to protect your data and systems. The following sections describe these measures in more detail.

## Onwership for Security

The [ReaR Maintainers](https://github.com/rear/rear/blob/master/MAINTAINERS) own the security of the ReaR software. This means that the ReaR Maintainers are responsible for ensuring that the ReaR software is secure and that it follows best practices for security. The ReaR Maintainers are also responsible for responding to security incidents and vulnerabilities in the ReaR software. If you discover a security vulnerability in ReaR, please report it to the ReaR Maintainers via our [support](/support) options.

Specifically, we own the security of:

* Git checkout or source code archive downloaded from https://github.com/rear/rear/tree/master branch
* Packages downloaded from GitHub snapshots builds from https://github.com/rear/rear/releases/tag/snapshot 
* ReaR packages distributed by Red Hat and SUSE as part of their Enterprise Linux

For these we will do our best to ensure that there are no security issues and that the software is secure. We will also respond to security incidents and vulnerabilities and fix them as soon as possible. For other means of distributing ReaR packages or source code we unfortunately cannot feel responsible as they are outside of our control.

## Shared Responsibility Model

ReaR follows the shared responsibility model. This means that ReaR is responsible for the security of the ReaR software itself, while the user is responsible for the security of the data and systems that ReaR interacts with. This includes the data that ReaR backs up and restores, as well as the systems that ReaR runs on. The user is especially responsible for safeguarding the ReaR configuration files against potential attacks, see [below](#protecting-against-code-injections). Furthermore, the user is responsible for the security of the rescue media that ReaR creates. The biggest attack vector in the context of using ReaR is actually manipulating the rescue media. If an attacker can manipulate the rescue media, they can easily compromise the system that is being recovered. This is why it is important to protect the rescue media and ensure that it is only accessible to authorized users and only when actually needed.

To help our users protecting their systems, by default the ReaR rescue media *does not contain secrets*. This means that the rescue media does not contain any sensitive information like passwords, encryption keys, etc. This is a conscious design decision to reduce the attack surface of the rescue media. If you need to recover a system that requires secrets, you must *by default* provide these secrets manually during the recovery process. This ensures that the secrets are not stored on the rescue media and are only available when actually needed. However, to facilitate automated disaster recovery, ReaR can be configured to include secrets in the rescue media. This is a trade-off between security and convenience. If you choose to include secrets in the rescue media, you must take extra care and ensure that the rescue media is protected accordingly.

## ReaR Security Features

### Protecting Secrets In Configuration Variables

ReaR protects secrets in configuration variables, so that they are not exposed in the (debug) logs. The `--expose-secrets` option can be used to expose secrets in the logs for debugging purposes. This option is disabled by default.

To facilitate protecting secrets even from verbose tracing of the Bash scripts (`set -x`), it is important to wrap statements that handle secrets like this:

```bash
# set a variable with a secret
{ VAR='secret_value' ; } 2>>/dev/$SECRET_OUTPUT_DEV

# use the variable with the secret
{ COMMAND $SECRET_ARGUMENT ; } 2>>/dev/$SECRET_OUTPUT_DEV
```

### Protecting Against Code Injections

*NOTE: This is our plan, the implementation will follow with the next release. This section will be updated accordingly.*

ReaR is written in the Bash scripting language, the configuration is actually Bash script code and the ReaR system architecture is designed for easily extending ReaR functionality via dropping shell scripts into the ReaR script directories. Therefore the ReaR code is by nature more open than close, which is - from a security perspective - a trade-off for convenience and extensibility over security.

We differentiate between the following scenarios for potential code injections:

1. Reading data
   1. from trusted operating system configuration files like `/etc/os-release`
   2. from untrusted configuration files, for example provided by a backup tool that ReaR integrates with
2. Reading ReaR scripts
   1. when ReaR is installed
   2. when ReaR is running in portable mode (`--portable`) or from source checkout
3. Reading ReaR configuration files in `/etc/rear` or provided via the `-C` option

To mitigate the risk of code injections, the following checks are implemented:

* Trusted operating system configuration files defined as "shell compatible" are read with `source` as we must also support the different quoting styles that can be used there. This is considered safe, as the operating system configuration files are under the control of the operating system vendor and are not writable by unprivileged users.
* Untrusted configuration files are never read with `source`. Instead, we use `grep` and other tools to extract the required information. This is considered safe, as the configuration files are not executed as code.
* When ReaR is installed and not run from source or in portable mode, then we validate that ReaR scripts and configuration files are owned by `root` and are not writable by unprivileged users. This is considered safe, as the ReaR scripts are under the control of the ReaR package and are not writable by unprivileged users.

Unfortunately, when running ReaR from a source checkout or in portable mode, we cannot implement further safeguards without compromising on core ReaR functionality. This is a trade-off between security and usability in favour of ReaR doing its designated job. If you run ReaR from a source checkout or in portable mode, you must take extra care and ensure that the ReaR scripts and configuration files are protected accordingly.

The ReaR configuration is executable Bash code and this is an important feature to facilitate dynamic configuration. Therefore we cannot implement further checks or limits on the ReaR configuration files, but rely on the ReaR user to protect the configuration files accordingly.
