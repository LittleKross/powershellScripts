echo "uninstalling git..."
Choco uninstall git -y
echo "git uninstalled!"
echo "uninstalling nodejs..."
Choco uninstall nodejs -y
echo "nodejs uninstalled!"
echo "uninstalling mongodb and tools..."
Choco uninstall mongodb -y
Choco uninstall mongodb-compass -y
Choco uninstall mongodb-shell -y
echo "mongodb and tools uninstalled!"

echo "your uninstall is complete!"