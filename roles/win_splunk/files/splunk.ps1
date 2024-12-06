# Install Splunk Universal Forwarder using the .msi file
msiexec /i "C:\Path\To\splunkforwarder-9.2.2-x64.msi" /quiet LAUNCHSPLUNK=1 AGREETOLICENSE=Yes SPLUNKUSER=SplunkFWD

# Ensure the Splunk Forwarder service is set to start automatically on boot
Set-Service -Name splunkforwarder -StartupType Automatic

# Start the Splunk service
Start-Service splunkforwarder

# Create deploymentclient.conf
$deploymentClientConf = @"
[target-broker:deploymentServer]
targetUri = 10.10.10.201:8089
"@

$deploymentClientConf | Out-File -Encoding ASCII "C:\Program Files\SplunkUniversalForwarder\etc\system\local\deploymentclient.conf"

# Set permissions for the deploymentclient.conf file
$acl = Get-Acl "C:\Program Files\SplunkUniversalForwarder\etc\system\local\deploymentclient.conf"
$acl.SetOwner([System.Security.Principal.NTAccount]"LocalService")
Set-Acl "C:\Program Files\SplunkUniversalForwarder\etc\system\local\deploymentclient.conf" $acl

# Restart the Splunk service to apply changes
Restart-Service splunkforwarder