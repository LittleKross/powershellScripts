#Imports
Import-Module posh-git
oh-my-posh init pwsh --config '~/AppData/Local/Programs/oh-my-Posh/themes/plague.omp.json' | Invoke-Expression

#Variables
$vimrc = '~/.vimrc'

#Aliases
Set-Alias code code-insiders
Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias touch New-Item
Set-Alias which where.exe

#Configuration
Set-PSReadlineOption -EditMode Vi -BellStyle None
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

#Functions
Function df() {
    Get-CimInstance -Class CIM_LogicalDisk | Select-Object @{Name="Size(GB)";Expression={$_.size/1gb}}, @{Name="Free Space(GB)";Expression={$_.freespace/1gb}}, @{Name="Free (%)";Expression={"{0,6:P0}" -f(($_.freespace/1gb) / ($_.size/1gb))}}, DeviceID, DriveType | Where-Object DriveType -EQ '3'
}

Function gig {
  param(
    [Parameter(Mandatory=$true)]
    [string[]]$list
  )
  $params = ($list | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
  Invoke-WebRequest -Uri "https://www.toptal.com/developers/gitignore/api/$params" | Select-Object -ExpandProperty content | Out-File -FilePath $(Join-Path -path $pwd -ChildPath ".gitignore") -Encoding ascii
}

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}

#End
#Clear-Host
