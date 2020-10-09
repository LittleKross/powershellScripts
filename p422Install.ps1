echo "installing chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
echo "chocolatey installed!"

Set-ExecutionPolicy RemoteSigned

RefreshEnv

echo "installing git..."
Choco install git -y --force
echo "git installed!"
echo "installing nodejs..."
Choco install nodejs -y --force
echo "nodejs installed!"
echo "installing mongodb and tools..."
Choco install mongodb -y --force
Choco install mongodb-compass -y --force
Choco install mongodb-shell -y --force
echo "mongodb and tools installed!"

echo "your installation is complete!"