Get Commands
=========================

This page contains details on **Get** commands.

Get-VeeamProtection
-------------------------


NAME
    Get-VeeamProtection
    
SYNOPSIS
    
    
SYNTAX
    Get-VeeamProtection [-myVMs] <InventoryItemImpl[]> [<CommonParameters>]
    
    
DESCRIPTION
    This Function checks the protections state of VMware vSphere VMs in Veeam 
    Backup & Replication.
    
    Protections state is gathred by existing Backup SavePoints.
    

PARAMETERS
    -myVMs <InventoryItemImpl[]>
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, 
    see 
        about_CommonParameters 
    (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Get-VM | Get-VeeamProtection | Format-Table -AutoSize
    
    Requires -Version 4
    Requires -Modules VMware.VimAutomation.Core, 
    @{ModuleName="VMware.VimAutomation.Core";ModuleVersion="6.3.0.0"}
    Requires -PSSnapin VeeamPssnapin
    
    
    
    
REMARKS
    To see the examples, type: "get-help Get-VeeamProtection -examples".
    For more information, type: "get-help Get-VeeamProtection -detailed".
    For technical information, type: "get-help Get-VeeamProtection -full".




