Start Commands
=========================

This page contains details on **Start** commands.

Start-VeeamQuickBackup
-------------------------


NAME
    Start-VeeamQuickBackup
    
SYNOPSIS
    
    
SYNTAX
    Start-VeeamQuickBackup [-myVMs] <InventoryItemImpl[]> [<CommonParameters>]
    
    
DESCRIPTION
    This Function starts a Quick Backup for VMware vSphere VMs.
    
    For a Quick Backup the VM must be added to a Backup Job and at least one Full Backup must exist.
    

PARAMETERS
    -myVMs <InventoryItemImpl[]>
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Get-VM -Name test | Start-VeeamQuickBackup
    
    Requires -Version 4
    Requires -Modules VMware.VimAutomation.Core, @{ModuleName="VMware.VimAutomation.Core";ModuleVersion="6.3.0.0"}
    Requires -PSSnapin VeeamPssnapin
    
    
    
    
REMARKS
    To see the examples, type: "get-help Start-VeeamQuickBackup -examples".
    For more information, type: "get-help Start-VeeamQuickBackup -detailed".
    For technical information, type: "get-help Start-VeeamQuickBackup -full".


Start-VeeamRestore
-------------------------

NAME
    Start-VeeamRestore
    
SYNOPSIS
    
    
SYNTAX
    Start-VeeamRestore [-myVMs] <InventoryItemImpl[]> [<CommonParameters>]
    
    
DESCRIPTION
    This Function restores VMware vSphere VMs to the original location.
    
    RestorePoint is the lastest one. You will have to power up the VM manually.
    

PARAMETERS
    -myVMs <InventoryItemImpl[]>
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Get-VM | Start-VeeamRestore
    
    Requires -Version 4
    Requires -Modules VMware.VimAutomation.Core, @{ModuleName="VMware.VimAutomation.Core";ModuleVersion="6.3.0.0"}
    Requires -PSSnapin VeeamPssnapin
    
    
    
    
REMARKS
    To see the examples, type: "get-help Start-VeeamRestore -examples".
    For more information, type: "get-help Start-VeeamRestore -detailed".
    For technical information, type: "get-help Start-VeeamRestore -full".




