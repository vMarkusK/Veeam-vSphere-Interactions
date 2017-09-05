function Start-VeeamRestore {
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
    This Function checks restores VMware vSphere VMs to the original location.

    RestorePoint is the lastest one. You will have to power up the VM manually.

    .Example
    Get-VM | Start-VeeamRestore

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

    foreach ($MyVm in $MyVms) {
        $MoRef = $MyVm.ExtensionData.MoRef.Value
        if ($VeeamVm = Find-VBRViEntity -Server $ViServer | Where-Object {$_.Reference -eq $MoRef}) {
            [Array]$VmRestorePoints = $VbrReastorePoints | Where-Object {$_.InsideDir -match $MoRef}
            if ($VmRestorePoints.count -lt 1) {throw "No RestorePoints for '$($VeeamVm.Name)' found"}
            $LastRestorePoint = $VmRestorePoints | Sort-Object CreationTime | Select-Object -Last 1

            $Result = Start-VBRRestoreVM -RestorePoint $LastRestorePoint -Reason "Automatic PowerShell Restore" -ToOriginalLocation

            if ($Result) {
                $Result | Select-Object Name, Result, CreationTime, EndTime
            }

        }

    }


	}
}