#Imports
Import-Module posh-git
oh-my-posh init pwsh --config '~/AppData/Local/Programs/oh-my-Posh/themes/plague.omp.json' | Invoke-Expression

#Variables
$vimrc = '~/.vimrc'
#Once ssh is running add these commands back
#remove-item env:\SSH_AGENT_PID
#remove-item env:\SSH_AUTH_SOCK

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

Function prj() {
    Param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$command,
        [Parameter(Mandatory=$true,Position=1,ParameterSetName='new')]
        [string]$projectName,
        [Parameter(ParameterSetName='new')]
        [string]$path,
        [Parameter(ParameterSetName='new')]
        [switch]$private
    )
    if($command -eq "generate"){
        Write-Host 'Creating' $projectName '...' -ForegroundColor green
        if($path -ne ('')){
            Write-Host $path
            Set-Location $path
        }
        else{
            Set-Location '~/Sync/Git'
        }
        if($private){
            gh repo create $projectName -y --private
        }
        else{
            gh repo create $projectName -y --public
        }
        Set-Location $projectName
        New-Item README.md
        git add .
        git commit -m "initial commit"
        git push --set-upstream origin master
    }
else{get-command prj -get-syntax}
}

<#Function email() {
	Param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$From,
        [Parameter(Position=1)]
        [string]$To,
        [Parameter(Position=2)]
        [string]$Header,
        [Parameter(Position=3)]
        [switch]$Body
    )

	$c = Get-Credential -UserName $account
	Write-Host $c.GetNetworkCredential().Password
	$SMTPClient = New-Object Net.Mail.SmtpClient('smtp.gmail.com',465)
	$SMTPClient.EnableSsl = $true
	$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($account,$c.GetNetworkCredential().Password);
	$SMTPClient.Send($account,'littlekross47@gmail.com','test','test')

}#>

#End
#Clear-Host

#If (Test-Path "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1")         *
#*      {& "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1" [PARAMETERS]}     *
#*  Learn more with this:                                                             *
#*    Get-Help "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1"               *
#*  Or here:                                                                          *
#*    https://github.com/DarwinJS/ChocoPackages/blob/master/openssh/readme.md
