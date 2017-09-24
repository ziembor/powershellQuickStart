# cls 
#region Getting Commands/help
#get commands
Get-command -Noun Process
Get-command -Verb Get
Get-command | ? { $_.name -match "proc" }

#--- get help about command
update-help
get-help Get-Process
get-help -Full get-process
get-help -examples get-process
help get-ChildItem
help get-ChildItem -examples 
help get-ChildItem -detailed
help get-ChildItem -full 
help get-ChildItem -online
help about*
help about_variables -ShowWindow
Get-Help Get-ChildItem -ShowWindow
show-command Get-ChildItem 
#endregion


#region comments
#### comments with pound sign
<#
Multiline comment
#>
#endregion


#region Not scripting, but running commands
get-executionpolicy -List
[Microsoft.PowerShell.ExecutionPolicy].GetEnumNames()
Set-ExecutionPolicy -ExecutionPolicy TABULATOR 
Get-executionpolicy | gm
Set-executionpolicy remotesigned
## exec powershell 
dir 
simple-script.ps1
#????
.\simple-script.ps1 
c:\code\simple-script.ps1
. c:\code\simple-script.ps1
{.\.\simple-script.ps1}
& c:\bash.exe
## deal with errors 
getcommand
<#PS C:\Users\ziemb> getcommand
getcommand : The term 'getcommand' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that t
he path is correct and try again.
At line:1 char:1
+ getcommand
+ ~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (getcommand:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
#>	
#endregion


#region Manipulating dates

get-date -format s
$vardate = get-date
$vardate = get-date -hour 14 -Minute 0 -Second 0 -Millisecond 0
$vardate
$vardate.DayOfWeek
$vardatenextyear = $vardate.AddYears(1)
$vardate
$vardate.hour 
$vardate.hour = 4
$strdate=(get-date -format s).Replace(':','')

#endregion


#region constructing new object
#first get type name
$(get-date).gettype().FullName
<#
PS> $(get-date).gettype().FullName
System.DateTime
#>
[System.DateTime].GetConstructors() | foreach-object {
        $c = $_
        write-host "constructor("
        foreach ($p in $c.GetParameters())
        {
                  "`t{0} {1}," -f $p.ParameterType.FullName, $p.Name 
        }
        write-host ")"
}
New-Object -TypeName System.DateTime -ArgumentList 2014,2,1,0,0,0,0

#what are values for enums
$(Get-executionpolicy).GetType() | select fullname, basetype
<#
PS C:\Users\Ziemeko> $(Get-executionpolicy).GetType() | select fullname, basetype

FullName                                                                                        BaseType                                                                                      
--------                                                                                        --------                                                                                      
Microsoft.PowerShell.ExecutionPolicy                                                            System.Enum        
#>
[Microsoft.PowerShell.ExecutionPolicy].GetEnumNames()

#get member (functions or properties of object)
get-date | Get-Member
get-date | gm

#endregion

#region where dir -Recurse | where {$_.isContainer -eq $true}#endregion 

#region Variables
$varint = 6
$varint

$varstring = 'any text'
$varstring

$varstring2 = "let``s display `$varstring $varstring"
$varstring2 

#literal string with signle quotes
$varstring2 = 'let``s display `$varstring $varstring'
$varstring2 

#with escape
"what is string 1 `$varstring"
"what is string 1 `$varstring `t tab `nmultiline"

#casting
[int]$int = 3
[int]$int = "text"

#xml data type
[xml]$x = '<?xml version="1.0"?><helloworld><greeter>An XSLT Programmer</greeter><greeting><string lang="en-US">Hello, World!</string><string lang="pl-PL">Witaj swiecie!</string></greeting></helloworld>'
$x.helloworld.greeter
$x.helloworld.greeting.string[0].'#text'

#arrays
$vararray = @("String1","String2","String3")
$vararray
$vararray.Count
$vararray[0]
$mergedarray = $vararray + @("String4","String5")
$mergedarray
$mergedarray += "String6"
$mergedarray

#arraylist
$varlist = New-Object System.Collections.ArrayList
$varlist.add("String1"); $varlist.add("String2")
$varlist[0]
$varlist.remove("String1")
$varlist[0]

#hash list
$mailadr = @{"john"="john@foo.com"; "dave"="dave@foo.com"}
$mailadr
$mailadr["john"]
$mailadr
$mailadr["Ziemek"] = "Ziemek@foo.com"
$mailadr
$mailadr.remove("dave") 
$mailadr

#multi array
$array2 = New-Object 'object[,,]' 10,20,10
$array3 = (0,0,0),(0,0,0)
$array4 = ,(0,5,0)
$array4 += ,(3,0,1)
#endregion


#region Creating custom objects
$Ziemek=New-Object PSObject
$Ziemek | Add-Member Noteproperty -Name Name -value "Ziemek"
$Ziemek | Add-Member Noteproperty -Name Sex -value "m"
$Ziemek

$dave = New-Object -TypeName PSObject -Property @{ Name="Dave";Sex="m" }
$dave

$list = $Ziemek,$dave
$list
#endregion


#region Use of execute variable $()
Write-host get-date
Write-host $(get-date)
#endregion


#region Writing with format string
$who = "world"
$greeter = "Ziemek"

Write-Host "hello $who from $greeter"
Write-Host ("hello "+$who+" from "+$greeter)
Write-Host ("hello {0} from {1}" -f $who,$greeter)
Write-Host ("hello {0} from {1} on {2:dd/MM/yyyy}" -f $who,$greeter,$(get-date))
Write-Host ("{3,2:##} hello {0} from {1} on {2:HH:mm:ss}" -f $who,$greeter,$(get-date),1)
Write-Host ("{3,2:##} hello {0} from {1} on {2:HH:mm:ss}" -f $who,$greeter,$(get-date),10)
Write-Host "hello $who from $greeter" -foregroundcolor DarkGreen -backgroundcolor white

<#
http://msdn.microsoft.com/en-us/library/txafckwd(v=vs.110).aspx

It is visual basic and c sharp examples but you can easily convert these
"Name = {0}, hours = {1:hh}", myName, DateTime.Now
to
#>
$varname = "Tom"
write-host ("Name = {0}, hours = {1:hh}" -f $varname, $(get-date))
<#
Dim MyInt As Integer = 100
Console.WriteLine("{0:C}", MyInt)
to
#>
$varint = 100
write-host ("{0:C}" -f $varint)
#endregion


#region If then else
$human = New-Object -TypeName PSObject -Property @{ Name="Dave";Sex="m" }
If ($human.sex -eq "m") { 
	write-host $human.name" is a dude"
} Else {
	write-host $human.name" is a girl" 
}

$human = New-Object -TypeName PSObject -Property @{ Name="Tracy";Sex="f" }
If ($human.sex -eq "m") { 
	write-host ($human.name+" is a dude")
} 
ElseIf ($human.sex -eq "f") {
    write-host ($human.name+" is a girl")
}
Else {
    write-host ($human.name+" is unknown")
}

#endregion


#region switch case
$today = get-date
Switch ($today.dayofweek)
{
	Monday { Write-host "Don’t want to work today"}
	Friday { Write-host "Almost weekend" }
	Saturday { Write-host "Weekend!" }
	Sunday { Write-host "A good day to rest" }
	Default { Write-host "Business as usal" }
}

#endregion


#region Loop
$varlist = @("Ziemek","Dave","John")
#foreachloop !!!
Foreach($name in $varlist) {
	Write-Host $name
}
#loop while
$counter = 0
While ($counter -lt $varlist.count) { 
	Write-Host  $varlist[$counter]
	$counter++
}
$nextminute = ($(get-date).minute+1)%60
While($(get-date).minute -ne $nextminute)
{	
	Write-Host ("Counting down {0,2}" -f (60-$(get-date).second))
	start-sleep -s 1
}
#for loop
For($counter=0;$counter -lt $varlist.count;$counter++) {
	Write-Host  $varlist[$counter]
}
#foreachloop with index
(0..5)
Foreach($counter in (0..($varlist.count-1))) {
	Write-Host  $varlist[$counter]
}
#endregion


#region alias
get-alias -definition where-object
Get-alias ls

#endregion


#region object array and pipeline
$cars = @()
$cars += New-Object -TypeName PSObject -Property @{ Name="Golf";Engine=1.9;Brand="Volkswagen"}
$cars += New-Object -TypeName PSObject -Property @{ Name="Polo";Engine=1.2;Brand="Volkswagen"}
$cars += New-Object -TypeName PSObject -Property @{ Name="Vanquish";Engine=6;Brand="Aston Martin"}
$cars += New-Object -TypeName PSObject -Property @{ Name="1";Engine=1.6;Brand="BMW"}
$cars += New-Object -TypeName PSObject -Property @{ Name="CLS";Engine=3.5;Brand="Mercedes"}

$cars

$cars | where { $_.engine -lt 2 }
$cars | % { 
	$fullname = $_.Brand+" "+$_.name
	write-host $fullname
}
$cars | sort-object -descending engine
$cars | sort-object engine  | where { $_.engine -lt 2 }
$cars | sort-object engine  | select -first 3 | select brand,name
$cars | sort-object engine  | select -first 3 | select brand,name | ConvertTo-Csv
$cars | sort-object engine  | select -first 3 | select brand,name | ConvertTo-Html | Out-File "C:\d\cars.html"


#endregion


#region functions
Function repeat-text {
	param ([string]$string="I will never write on the blackboard again",[int]$repeat=5)
	foreach ( $count in 1..$repeat) { Write-Host "$count : $string" }
}
Repeat-text -string "I will start powershell every day"
Repeat-text  -repeat 10 -string "I will start powershell every day"

#with advanced function 
Function repeat-text {
	param (
		[parameter(Mandatory=$true, Position=1)]
		[alias("s")]
		[string]$string,
		[int]$repeat=5
	)
	foreach ( $count in 1..$repeat) { Write-Host "$count : $string" }
}

Repeat-text
get-help repeat-text -full
Repeat-text -s "I will start powershell every day"


#endregion


#region Errors 
$x = 1/0
$? ; $LASTEXITCODE 
#We can pull out the most recent error if necessary
$Error[0]
$Error[0] | gm

#Try/Catch/Finally allow us to better handle errors. 
$x = 1
try{ $x = 1/0 } 
catch {     Write-Warning "Operation failed."}
finally{  $x = 0 }

"`$x is $x"

#We can use throw or Write-Error to generate error messages
Write-Error "Something is wrong on the holodeck!"

#endregion


#region Creating a pipeline command
function SimpleWrite-Object {
    BEGIN { 
        #before pipeline starts
    }
    PROCESS {
        #for everyobject in the pipe
        Write-Host "Writing object:"$_.name
    }
    END { 
        #after eachobject
    }
}
Get-Process | SimpleWrite-Object
#or with more decoration
function SimpleWrite-Object {
 param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [PSObject[]]$InputObject
    )
    BEGIN { 
        #before pipeline starts
    }
    PROCESS {
        #for everyobject in the pipe
        Write-Host "Writing object:"$InputObject.name
    }
    END { 
        #after eachobject
    }
}
Get-process | SimpleWrite-Object
#filters
filter NotepadFilter { if ($_.Name -eq 'notepad') { $_ } }
get-process | NotepadFilter
#endregion


#region regex

$helloworld = "Hello World"
$helloworld -match "Hello ([a-z][A-Z]+)"
$matches

$helloworld = "Replace Hello World"
$helloworld -replace "World","All"
$helloworld -replace "Hello ([a-z][A-Z]+)",’Goodbye $1’

$multiplematches = "matcha jiberish matchb jiberish matchc"
$regex = [regex]"match([a-z])"
$regex.Matches($multiplematches) | % { Write-Host ("{0} -> {1}" -f $_.Groups[0].Value, $_.Groups[1].Value ) }


$wc = new-object system.net.webclient
$patchpage = $wc.DownloadString("http://www.veeam.com/patches.html")

$regextable = [regex]"(?is)<table[^>]+downloads_table[^>]+>(.*?)</table>"
$regexname = [regex]"(?is)<td[^>]+id=.name.[^>]+><a href=.([^`"]+)[^>]+>([^<]+)</a></td>"
$patches = @()

$regextable.Matches($patchpage) | % {
	$tablecontent = $_.Groups[1].Value
	$regexname.Matches($tablecontent) | % {
		$obj = new-object -typename PSObject -Property @{name=$_.Groups[2].Value;url=$_.Groups[1].Value}
		$patches +=$obj	
	}
}
$patches
#endregion



#region remoting

#on target host
Enable-PSRemoting -Force

#test
Test-WsMan 172.20.1.2

#if not in domain, enable psremoting on both then add thrustedhost to client
Set-Item wsman:\localhost\client\trustedhosts "192.168.0.*"
Get-item wsman:\localhost\client\trustedhosts

#start session to execute commands
Enter-PSSession -ComputerName 192.168.0..2  -credential domain\Ziemeko

#invoke a command directly
Invoke-Command -ComputerName 192.168.0.2  -credential domain\Ziemeko -ScriptBlock {
HOSTNAME.EXE}

#storing credentials with securestring and encrypting
$creds = get-credential
$encryptedpassword = $creds.password | ConvertFrom-SecureString 
$storablecredentials = New-Object -TypeName PSObject -Property @{username=$creds.username; password=$encryptedpassword  }
$storablecredentials | ConvertTo-Csv | Set-Content C:\d\creds\auth

$storablecredentials = Get-Content C:\d\creds\auth | ConvertFrom-Csv 
$securedstring = $storablecredentials.password | ConvertTo-SecureString
$credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $storablecredentials.username, $securedstring 
Invoke-Command -ComputerName 172.20.1.2  -credential $credentials -ScriptBlock {systeminfo}
#endregion



#region Mail with powershell
set-alias -name html -value convertto-html
$softwareWMI = Get-WmiObject -Class Win32_Product
$software = $softwareWMI | select Name,Version | html -fragment -pre "<h2>Products Installed</h2>"
$envvars = dir env: | select Name,Value | html -fragment -pre "<h2>System Variables</h2>"

$htmlhead = "<title>System Report</title><style type='text/css'>h1,h2,body,p {font-family:verdana;}</style>"
$htmlout = html -head $htmlhead -body ("<h1>System Report</h1>"+$envvars+$software)

$smtp = New-Object System.Net.Mail.SmtpClient("localhost")
$message = New-Object System.Net.Mail.MailMessage "automail@foo.com","Ziemeko@foo.com"
$message.Subject = "System Report"
$message.IsBodyHTML = $true
$message.Body = $htmlout
$smtp.Send($message)
#### or just 
show-command send-mailmessage 
#endregion

