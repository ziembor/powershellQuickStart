# PowerShell Quick Start
very quick - up to 6 hours
delivered (or not :)) by Ziemek Borowski, with some lab, homework and code review

--- 

## Summary
Quick PowerShell course for people with limited experience on system administrator scripting (5 hours in person meeting + homework + online homework review session). The course is based on ["Learn Windows PowerShell 3 in a Month of Lunches, Second Edition' by Don Jones and Jeffery Hicks"](https://www.safaribooksonline.com/library/view/learn-windows-powershell/9781617291081/).  

---
## Method of participation
- 5 hours in person meeting
- homework 
- 1 hour online (WebEx/telco) meeting to review homework

---

### Participant requirements

#### Required knowledge / skills
- basic knowledge on Windows Server administration and basic knowledge on computer programming (simple VBA macros, Lego Robotics, VBScript or cmd.exe are enough). 

#### Required equipment
- Windows 7 or Windows 10 virtual machine  
- working access to 'Laboratory' with Windows Server 2016 

---
## Agenda
- What is PowerShell
- How to apply for everyday tasks 
- Running commands      
- The pipeline: connecting commands 
- Adding commands: function, snap-ins, modules 
---
### Agenda cont'ed
- Objects: data by another name    
- Formatting: how to do it properly
- Filtering and comparison
- Simple function & script
- Homework selection: write script for specific needs
---
### Homework
I expect one week for homework done. In middle of that time, I will organize office hours using WebEx remote conference tool. After homework submission date, we will meet and discuss selected works. 

---
## Supporting sources
* ['Using Windows PowerShell'](https://docs.microsoft.com/en-us/powershell/scripting/getting-started/fundamental/using-windows-powershell) / free
* ['Learn Windows PowerShell 3 in a Month of Lunches, Second Edition' by Don Jones and Jeffery Hicks Publisher: Manning Publications](https://www.safaribooksonline.com/library/view/learn-windows-powershell/9781617291081/) / paid, here Safair Books Online 
* [MikeFal/IntroToPowershell](https://github.com/MikeFal/IntroToPowershell) / free
* Rafał Kraik [Powershell dla administratora Windows - kompletny kurs](https://www.udemy.com/powershell-dla-administratora-windows/) / paid, Udemy

Note:
Windows PowerShell Survival Guide @ TechNet Wikihttps://social.technet.microsoft.com/wiki/contents/articles/183.windows-powershell-survival-guide.aspx

--- 
## What is PowerShell? 
> * PowerShell is a command-line interface (CLI),
> * that contains a rich, yet simplified scripting language for automating complex, multi-step tasks
> * Built on the .NET Framework
> * Extensible, so various products and technologies can be managed by “snapping in” tech-specific extensions

--- 
> * Most importantly... it’s **discoverable**! It can teach you how to use itself!

<small>Windows PowerShell - Crash Course](https://channel9.msdn.com/Events/TechEd/NorthAmerica/2012/WSV321) by Don Jones and Jefferey Snover. 

--- 
### ... some facts 
#### before 
- DOS's `command.com`, [cmd.exe](https://ss64.com/nt/), [KixStart](http://www.kixtart.org/), [VBScript](https://ss64.com/vb/)/[JScript]() (based on Windows Scripting Host (WHS)
- bash, python, perl (on Unicses or via Cygwin or native ports)

---
## Envisioned by [Jeffery Snover]() - 2002 
- [The Monad Manifesto](https://www.jsnover.com/blog/2011/10/01/monad-manifesto/)
- long time known as Project 'Monad'
- released as PowerShell RC1 - 2006-04
- first product requiring it was Exchange Server 2007
- PowerShell 2.0 - basic remoting 
- Windows Server 2008 R2 - PowerShell 3.0 
- Windows Server 2012 - PowerShell 4.0 - DSC - Desired State Configuration
- Windows Server 2016 - PowerShell 5.1 
---
### PowerShell scope of use 
- [PowerShell System Requirements](https://docs.microsoft.com/en-us/powershell/wmf/5.1/install-configure)
- [Installing PowerShell v5.1](https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell?view=powershell-5.1) on Windows
- PowerShell Core is a cross-platform (Windows, Linux, and macOS)... You can download and install a PowerShell package for any of the platforms
- ... but do not expect exectly the same experience

---
| Operating System Version | [WMF 5.1](https://aka.ms/wmf51download) | [WMF 5.0](https://aka.ms/wmf5download) | [WMF 4.0](https://aka.ms/wmf4download) |  [WMF 3.0](https://aka.ms/wmf3download) | [WMF 2.0](https://aka.ms/wmf2download) |
| ------------------------ | ----------- | ----------- | ----------- | ------------ |  ------------- |
| Windows Server 2016 | Ships in-box |  |  |  |  |
| Windows Server 2012 R2| Yes | Yes | Ships in-box |  |  |
| Windows Server 2008 R2 SP1 | Yes | Yes | Yes |  Yes| Ships in-box |
| Windows 7 SP1  | Yes | Yes | Yes | Yes | Ships in-box |
| Windows Server 2003| | | |  | Yes |
| Windows XP | | | |  | Yes |

---
### How to apply for everyday tasks
- interactive shell 
- ad-hoc scripts 
- tools 
- CI/CD (Contionous Integration/Contionous Delivery) 

---
### Let's start
`powershell.exe` or `ise.exe` 
```
Start-Transcript $env:Temp\GettingStarted.txt -Force

Set-ExecutionPolicy RemoteSigned -Force -Scope CurrentUser

get-host 

Stop-Transcript
notepad $env:Temp\GettingStarted.txt
```
* The console window vs `Integrated Scripting Environment`
* Common Points of Confusion
    - 32- and 64-bit
    - Running as Administrator

--- 
### Using help

* on fresh system execute <code>update-help </code> <small>require Internet access and escalate shell.</small>
* `get-help` is main command for geting help :)  
```
help get-ChildItem
help get-ChildItem -examples 
help get-ChildItem -detailed
help get-ChildItem -full 
help get-ChildItem -examples
Get-Help Get-ChildItem -ShowWindow
```
* show-command Get-ChildItem 

---?image=_Memes/CopingAndPasting.png&size=auto 90%

--- 
# Discover - commands 
```
get-command 
get-command | out-grid 
get-module | out-grid 
Get-command -Module Microsoft.PowerShell.Management

---
# Discover - parameters 
get-command get-member | get-member  
---
# Running commands
- any execution should have provided patch to those file. 
- so if we have such case: 
```

```
[The anatomy of a command ](./assets/CommandParameters.png)

Note:
![4.2](https://www.safaribooksonline.com/library/view/learn-windows-powershell/9781617291081/04fig01.jpg) 
--- 
# # The pipeline: connecting commands
--- 

## Adding commands: function, snap-ins, modules
```
PS C:\code\powershellQuickStart> Get-PSSnapin -Registered
Name        : Microsoft.BDD.PSSnapIn
Description : This Microsoft Deployment Toolkit 2010 snap-in contains cmdlets used to administer the contents of a deployment share.

PS C:\code\powershellQuickStart> Add-PSSnapin Microsoft.BDD.PSSnapIn
```

---
or 
```
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
```
--- 
## Objects: data by another name
```
$string="This is a variable"
$string

#We can use Get-Member to find out all the information on our objects
$string | Get-Member

$string.Length
$string.IndexOf('s')

# Powershell uses .Net objects.

$date=Get-Date
$date
$date | gm #gm is the alias of Get-Member

# Variables contains objects, so they has properties and methods 
$date.Day
$date.DayOfWeek
$date.DayOfYear
$date.ToUniversalTime()
$date.addDays(365)
```
--- 
## Formatting: how to do it properly
```
dir | ft #ft is alias for Format-Table 
dir | select-object 
```
--- 
## Filtering and comparison
`where-object`

--- 
## Variables, input, output

--- 
## Simple script 
```
PS C:\code> echo "param(`$zmienna) `necho `$zmienna" >  .\script.ps1
PS C:\code> .\script.ps1 -zmienna "To jest argument zmiennej"
To jest argument zmiennej
````

---
# Homework selection: write script for specific needs
* return date and time of the last restart - it should return at least two properties: name of machine and datetime of event 
* test if a specified application has been installed and if it happens after a date of creating a new version of the software (stored somewhere in local machine as MSI package). if the test goes OK: install unattended that newer version of the software. 
* write script which will remove all logs older than one year, and compress older than 30 days in c:\
--- 
# ??? 
