function Get-VeeamProtection {
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
    PowerCLI Version: PowerCLI 6.5.1
    PowerShell Version: 5.1
    OS Version: Windows Server 2012 R2
    ===========================================================================
    Keywords vSphere, ESXi, VM, Veeam
    ===========================================================================

    .DESCRIPTION
    This Function checks the protections state of VMware vSphere VMs in Veeam Backup & Replication.

    Protections state is gathred by existing Backup SavePoints.

    .Example
    Get-VM | Get-VeeamProtection | Format-Table -AutoSize

#Requires PS -Version 4.0
#Requires -Modules VMware.VimAutomation.Core, @{ModuleName="VMware.VimAutomation.Core";ModuleVersion="6.3.0.0"}
#Requires -PSSnapin VeeamPssnapin
#>

  [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)]
        [ValidateNotNullorEmpty()]
        	[VMware.VimAutomation.ViCore.Impl.V1.Inventory.InventoryItemImpl[]]
        	$myVMs
    )
Begin {
    if ($global:DefaultVIServer) {
        Write-Verbose "VI Server Connected"
        if ($ViServer = Get-VBRServer -Name $global:DefaultVIServer.Name) {
            Write-Verbose "VI Server '$($ViServer.Name)' in Veeam Inventory found"
        }
        else {
            throw "VI Server not in Veeam found!"
        }
    }
    else {
        throw "no VI Server Connected!"
    }

    $VbrReastorePoints = Get-VBRRestorePoint
}
Process {
    $MyView = @()
    foreach ($MyVm in $MyVms) {
        $MoRef = $MyVm.ExtensionData.MoRef.Value
        if ($VeeamVm = Find-VBRViEntity -Server $ViServer | Where-Object {$_.Reference -eq $MoRef}) {
            [Array]$VmRestorePoints = $VbrReastorePoints | Where-Object {$_.InsideDir -match $MoRef}
            if ($VmRestorePoints.count -gt 0) {$IsProtected = $true} else {$IsProtected = $false}
            $LastRestorePoint = $VmRestorePoints | Sort-Object CreationTime | Select-Object -Last 1
            $LastBackupJob = Get-VBRBackup | Where-Object {$_.Id -eq $LastRestorePoint.BackupId}
            $FirstRestorePoint = $VmRestorePoints | Sort-Object CreationTime | Select-Object -First 1

            $Report = [PSCustomObject] @{
                VmName = $VeeamVm.name
                MoRef = $MoRef
                IsProtected = $IsProtected
                VmRestorePoints = $VmRestorePoints.count
                LastRestorePoint = $LastRestorePoint.CreationTime
                LastBackupJob = $LastBackupJob.Name
                FirstRestorePoint = $FirstRestorePoint.CreationTime
                }
            $MyView += $Report
        }

    }
    $MyView

	}
}