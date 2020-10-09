Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
Set-Alias code code-insiders
Set-Alias vi vim
Function prj() {
    Param(
        [Parameter(Position=0)]
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
    else{
        get-command prj -get-syntax
    }
}
Clear-Host
