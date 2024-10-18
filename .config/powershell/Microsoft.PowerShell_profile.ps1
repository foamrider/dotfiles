Function Convert-AzureAdObjectIdToSid {
<#
.SYNOPSIS
Convert an Azure AD Object ID to SID
 
.DESCRIPTION
Converts an Azure AD Object ID to a SID.
Author: Oliver Kieselbach (oliverkieselbach.com)
The script is provided "AS IS" with no warranties.
 
.PARAMETER ObjectID
The Object ID to convert
#>

    param(
        [Parameter(Mandatory=$true)]
        [String] $ObjectId
    )

    $bytes = [Guid]::Parse($ObjectId).ToByteArray()
    $array = New-Object 'UInt32[]' 4

    [Buffer]::BlockCopy($bytes, 0, $array, 0, 16)
    $sid = "S-1-12-1-$array".Replace(' ', '-')

    return $sid
}

Function Convert-AzureAdSidToObjectId {
<#
.SYNOPSIS
Convert a Azure AD SID to Object ID
 
.DESCRIPTION
Converts an Azure AD SID to Object ID.
Author: Oliver Kieselbach (oliverkieselbach.com)
The script is provided "AS IS" with no warranties.
 
.PARAMETER ObjectID
The SID to convert
#>

    param(
        [Parameter(Mandatory=$true)]
        [String] $Sid
    )

    $text = $sid.Replace('S-1-12-1-', '')
    $array = [UInt32[]]$text.Split('-')

    $bytes = New-Object 'Byte[]' 16
    [Buffer]::BlockCopy($array, 0, $bytes, 0, 16)
    [Guid]$guid = $bytes

    return $guid
}


Function Connect-AdminHost {
<#
.SYNOPSIS
Connect to a remote host using a stored password in the keychain

.PARAMETER RemoteHost
RemoteHost - The host to connect to
#>

    param (
        [Parameter(Mandatory=$true)]
        [string]$RemoteHost
    )

    $keychainItem = security find-generic-password -a "admin-tkg@kvaleco.local" -s "Kvale TKG Admin" -w
    $password = ConvertTo-SecureString $keychainItem -AsPlainText -Force
    $secureCredential = New-Object System.Management.Automation.PSCredential ("admin-tkg@kvaleco.local", $password)
    $remoteSession = New-PSSession -ComputerName $RemoteHost -Credential $secureCredential
    Enter-PSSession -Session $remoteSession
}


Function New-LocalIntuneWinPackage {
<#
.SYNOPSIS
Create a new IntuneWin package from a source folder

.DESCRIPTION
Creates a new IntuneWin package from a source folder. The source folder must contain a Deploy-Application.ps1 file.

.PARAMETER CurrentDirectory
The current directory to use as the base for the source and destination path
#>
    param (
        [string]$CurrentDirectory = (Get-Location)
    )

    $sourcePath = Join-Path -Path $CurrentDirectory -ChildPath "Source"
    $setupFile = "Deploy-Application.ps1"
    $destinationPath = Join-Path -Path $CurrentDirectory -ChildPath "Output"

    New-IntuneWinPackage -SourcePath $sourcePath -SetupFile $setupFile -DestinationPath $destinationPath
}

Set-Alias New-Pkg New-LocalIntuneWinPackage