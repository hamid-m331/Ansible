set autorun=0
set custom=Pub
cls
@echo off
echo off
color A

:checkaccess
FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
IF (%adminTest%)==(Access) goto noaccess



echo -------------------------------------------------------------
echo Windows Audit Config - General
echo -------------------------------------------------------------
echo --------------Account Logon----------------------------------
echo Kerberos Authentication Service:
auditpol /set /subcategory:"Kerberos Authentication Service" /success:enable /failure:enable
echo.
echo Kerberos Service Ticket Operations:
auditpol /set /subcategory:"Kerberos Service Ticket Operations" /success:enable /failure:enable
echo.
echo Credential Validation:
auditpol /set /subcategory:"Credential Validation" /success:enable /failure:enable
echo --------------Account Management-----------------------------
echo User Account Management:
auditpol /set /subcategory:"User Account Management" /success:enable /failure:enable
echo.
echo Computer Account Management:
auditpol /set /subcategory:"Computer Account Management" /success:enable /failure:Disable
echo.
echo Security Group Management:
auditpol /set /subcategory:"Security Group Management" /success:enable /failure:Disable
echo.
echo Other Account Management Events:
auditpol /set /subcategory:"Other Account Management Events" /success:enable /failure:Disable
echo --------------DS Access-----------------------------
echo  Directory Services Changes:
Auditpol /set /subcategory:"Directory Service Changes" /success:enable /failure:Disable
echo.
echo  Audit Directory Service Access:
Auditpol /set /subcategory:"Audit Directory Service Access" /success:enable /failure:Disable
echo --------------Logon/Logoff-----------------------------
echo Logon:
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
echo.
echo Logoff:
auditpol /set /subcategory:"Logoff" /success:enable /failure:Disable
echo.
echo Special Logon:
auditpol /set /subcategory:"Special Logon" /success:enable /failure:Disable
echo.
echo Group Membership:
auditpol /set /subcategory:"Group Membership" /success:enable /failure:Disable
echo.
echo User / Device Claims:
auditpol /set /subcategory:"User / Device Claims" /success:enable /failure:Disable
echo.
echo  Account Lockout:
auditpol /set /subcategory:"Account Lockout" /success:enable /failure:Disable
echo.
echo --------------Object Access-----------------------------
echo File Share:
auditpol /set /subcategory:"File Share" /success:enable /failure:enable
echo.
echo Other Object Access Events:
auditpol /set /subcategory:"Other Object Access Events" /success:enable /failure:disable
echo.
echo SAM:
auditpol /set /subcategory:"SAM" /success:enable
echo.
echo Detailed File Share:
auditpol /set /subcategory:"Detailed File Share" /success:enable /failure:enable
echo Removable Storage:
auditpol /set /subcategory:"Removable Storage" /success:enable
echo.
echo --------------Policy change-----------------------------
echo Audit Policy Change:
auditpol /set /subcategory:"Audit Policy Change" /success:enable /failure:Disable
echo.
echo Authentication Policy Change:
auditpol /set /subcategory:"Authentication Policy Change" /success:enable /failure:Disable
echo.
echo Authorization Policy Change:
auditpol /set /subcategory:"Authorization Policy Change" /success:enable /failure:Disable
echo --------------Privilege Use-----------------------------
echo Sensitive Privilege Use:
auditpol /set /subcategory:"Sensitive Privilege Use" /success:enable /failure:enable
echo --------------System -----------------------------------
echo Security State Change:
auditpol /set /subcategory:"Security State Change" /success:enable /failure:enable
echo.
echo Security System Extension:
auditpol /set /subcategory:"Security System Extension" /success:enable /failure:enable
echo ---------------------Powershell-----------------------------------
echo Powershell EnableScriptBlockLogging:
REG ADD HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging /v EnableScriptBlockLogging /t REG_DWORD /d 1 /f
echo.
echo Powershell EnableScriptBlockInvocationLogging:
REG ADD HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging /v EnableScriptBlockInvocationLogging /t REG_DWORD /d 1 /f
echo.
echo Powershell EnableModuleLogging:
REG ADD HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ModuleLogging /v EnableModuleLogging /t REG_DWORD /d 1 /f
echo.
echo Powershell ModuleNames:
REG ADD HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames /v * /t REG_SZ /d * /f
echo ----------------------------------------------------------------
goto end

:noaccess
cls
echo -------------------------------------------------------------
echo Privilege Access Error
echo -------------------------------------------------------------
echo You must run this script as an Administrator!
echo.
echo ^> press any key to exit..
pause >nul 2>nul
goto end