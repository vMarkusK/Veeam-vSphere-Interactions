function Start-VeeamQuickBackup {
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
    This Function starts a Quick Backup for VMware vSphere VMs.

    For a Quick Backup the VM must be added to a Backup Job and at least one Full Backup must exist.

    .Example
    Get-VM -Name test | Start-VeeamQuickBackup

#>
#Requires -Version 4
#Requires -Modules VMware.VimAutomation.Core, @{ModuleName="VMware.VimAutomation.Core";ModuleVersion="6.3.0.0"}
#Requires -PSSnapin VeeamPssnapin

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

}
Process {

    foreach ($MyVm in $MyVms) {
        $MoRef = $MyVm.ExtensionData.MoRef.Value
        if ($VeeamVm = Find-VBRViEntity -Server $ViServer | Where-Object {$_.Reference -eq $MoRef}) {

            $Result = Start-VBRQuickBackup -VM $VeeamVm -Wait

            if ($Result) {
                $Result | Select-Object JobName, Result, CreationTime, EndTime
            }

            if ($Result.Result -eq "Failed") {
                Throw "Quick Backup Failed. See Veeam B&R Console for more details!"
            }

        }

    }


	}
}