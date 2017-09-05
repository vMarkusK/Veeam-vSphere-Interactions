Veeam-vSphere-Interactions PowerShell Module
=============

# About

## Project Owner:

Markus Kraus [@vMarkus_K](https://twitter.com/vMarkus_K)

MY CLOUD-(R)EVOLUTION [mycloudrevolution.com](http://mycloudrevolution.com/)

## Project WebSite:

[mycloudrevolution.com](http://mycloudrevolution.com/)

## Project Documentation:

[Read the Docs - Veeam-vSphere-Interactions](http://veeam-vsphere-interactions.readthedocs.io)

## Project Description:

The 'Veeam-vSphere-Interactions' PowerShell Module enables you to interact via VMware PowerCLI with the Veeam Backup & Replication PowerShell Cmdlets.
It is possible to gather the Protection state of your VMware vSphere VMs, Restore VMs or manage VMs in existing Veeam Backup Jobs.

# Module Details

## Prerequirements

* VeeamPssnapin needs to be loaded
* VMware PowerCLI needs to be loaded
* Veeam Backup & Replication Server needs to be connected
* VMware vCenter Server needs to be connected
    * vCenter needs to be connected with the same name, FQDN or IP like it is configured in Veeam Backup & Replication Console
    * Only one vCenter can be connected

![vCenter](/media/vCenter.png)
## Functions

### Get-VeeamProtection

This Function checks the protections state of VMware vSphere VMs in Veeam Backup & Replication.
Protected means existing RestorePoints. Beeing a member of a Backup Job does not change the Protection State.

![Get-VeeamProtection](/media/Get-VeeamProtection.png)

## Add-VeeamJobObject

This Function adds VMware vSphere VMs to an existing Veeam Backup & Replication Backup Job.

* Only VMs can be added at the moment.


![Add-VeeamJobObject](/media/Add-VeeamJobObject.png)

## Remove-VeeamJobObject

This Function removes VMware vSphere VMs from a Veeam Backup & Replication Backup Job.

* Only VMs can be removed at the moment.

BUG: If all objects are removed from the Job, a output error occures!


![Remove-VeeamJobObject](/media/Remove-VeeamJobObject.png)

## Start-VeeamRestore

This Function restores VMware vSphere VMs to the original location.

* RestorePoint is the lastest one
* You will have to power up the VM manually.


![Start-VeeamRestore](/media/Start-VeeamRestore.png)

## Start-VeeamQuickBackup

This Function start a Quick Backup for VMware vSphere VMs.

* For a Quick Backup the VM must be added to a Backup Job and at least one Full Backup must exist.

![Start-VeeamQuickBackup](/media/Start-VeeamQuickBackup.png)
