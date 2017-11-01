Remove Commands
=========================

This page contains details on **Remove** commands.

Remove-VeeamJobObject
-------------------------


NAME
    Remove-VeeamJobObject
    
SYNOPSIS
    
    
SYNTAX
    Remove-VeeamJobObject [-myVMs] <InventoryItemImpl[]> [-JobName] <String> [<CommonParameters>]
    
    
DESCRIPTION
    This Function removes VMware vSphere VMs to an existing Veeam Backup & Replication Backup Job.
    
    Only VMs can be removed at the moment.
    

PARAMETERS
    -myVMs <InventoryItemImpl[]>
        
    -JobName <String>
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Get-VM -Name test3 | Remove-VeeamJobObject -JobName "Backup Job 1"
    
    Requires -Version 4
    Requires -Modules VMware.VimAutomation.Core, @{ModuleName="VMware.VimAutomation.Core";ModuleVersion="6.3.0.0"}
    Requires -PSSnapin VeeamPssnapin
    
    
    
    
REMARKS
    To see the examples, type: "get-help Remove-VeeamJobObject -examples".
    For more information, type: "get-help Remove-VeeamJobObject -detailed".
    For technical information, type: "get-help Remove-VeeamJobObject -full".




