# get info on load modules
Get-Module 
#What module we have locally available?
Get-Module -ListAvailable 
# Starting powershell 4.0 (or 3.0) modules are loaded automatically if needded, 
# but in powershell 2.0 we need do it manually 
Import-Module 	Defender
Remove-module   Defender
# what in module 
Get-Command -Module Defender  
# PowerShellGallery.com
Find-Module  PasswordsGenerator

# PS C:\WINDOWS\system32> Find-Module   PasswordsGenerator
#
#Version    Name                                Repository           Description
#-------    ----                                ----------           -----------
#2.5.0        PasswordsGenerator                PSGallery              PasswordsGenerator is a PowerShell module for automating the...
Install-Module   PasswordsGenerator
# Update 
Install-Module   PasswordsGenerator 
# Uninstall 
UnInstall-Module   PasswordsGenerator -whatif 