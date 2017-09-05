function Remove-VeeamJobObject {
<#
    .NOTES
    ===========================================================================
    Created by: Markus Kraus
    Twitter: @VMarkus_K
    Private Blog: mycloudrevolution.com
    ===========================================================================
    Changelog:
    2017.09 ver 1.0 Base Release
    ===========================================================================
    External Code Sources:
    -
    ===========================================================================
    Tested Against Environment:
    vSphere Version: 6.5
    Veeam Version: 9.5 U2
    PowerCLI Version: PowerCLI 6.3.1
    PowerShell Version: 5.1
    OS Version: Windows Server 2012 R2
    ===========================================================================
    Keywords vSphere, ESXi, VM, Veeam
    ===========================================================================

    .DESCRIPTION
    This Function removes VMware vSphere VMs to an existing Veeam Backup & Replication Backup Job.

    Only VMs can be removed at the moment.

    .Example
    Get-VM -Name test3 | Remove-VeeamJobObject -JobName "Backup Job 1"

#Requires PS -Version 4.0
#Requires -Modules VMware.VimAutomation.Core, @{ModuleName="VMware.VimAutomation.Core";ModuleVersion="6.3.0.0"}
#Requires -PSSnapin VeeamPssnapin
#>

  [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        [ValidateNotNullorEmpty()]
        	[VMware.VimAutomation.ViCore.Impl.V1.Inventory.InventoryItemImpl[]]
            $myVMs,
        [Parameter(Mandatory=$true, ValueFromPipeline=$false, Position=1)]
        [ValidateNotNullorEmpty()]
        	[String]
        	$JobName
    )
Begin {
    if ($global:DefaultVIServer) {
        Write-Verbose "VI Server Connected"
        if ($ViServer = Get-VBRServer -Name $global:DefaultVIServer.Name) {
            Write-Verbose "VI Server '$($ViServer.Name)' in Veeam Inventory found"
        }
        else {
            throw "VI Server not in Veeam Inventory found!"
        }
    }
    else {
        throw "No VI Server Connected!"
    }

    if ($VbrBackupJob = Get-VBRJob -Name $JobName) {
        Write-Verbose "Backup Job '$JobName' in Veeam Inventory found"
    }
    else {
        throw "Backup Job not in Veeam Inventory found!"
    }
}
Process {

    foreach ($MyVm in $MyVms) {

        if ($VbrBackupObject = $VbrBackupJob | Get-VBRJobObject -Name $MyVm.Name) {
            Write-Verbose "Backup Object '$($MyVm.Name)' found"
            $VbrBackupObject | Remove-VBRJobObject -Completely:$true
        }
        else {
            "Backup Object '$($MyVm.Name)' not found!"
        }

    }
}
End {

    (Get-VBRJobObject -Job $VbrBackupJob).GetObject() | Select-Object Name, ViType

}
}