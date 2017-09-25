# cls 
#region Getting Commands/help
#get commands
Get-command -Noun Process
Get-command -Verb Get
Get-command | ? { $_.name -match "proc" }

#--- get help about command
update-help
get-help Get-Process
help get-process -Full
help get-process -examples
get-help *process* 
help get-ChildItem
help get-ChildItem -examples 
help get-ChildItem -detailed
help get-ChildItem -online
help about*
help about_variables -ShowWindow
Get-Help Get-ChildItem -ShowWindow
show-command Get-ChildItem 
#endregion
#region alias
get-alias -definition where-object
Get-alias ls

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
get-date -format g
Get-Date -UFormat "%Y%m%d"
# https://ss64.com/ps/syntax-dateformats.html
$vardate = get-date
$vardate = get-date -hour 14 -Minute 0 -Second 0 -Millisecond 0
$vardate
$vardate.DayOfWeek
$vardatenextyear = $vardate.AddYears(1)
$vardatenextyear = $vardate.AddHours(-72)
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

#region where dir
dir -Recurse -Directory 
fsutil file createnew "file.txt" (1MB)
foreach ($f in (1..10)) {fsutil file createnew "$($f)_file.txt" (get-random -minimum 90KB -maximum 3MB)
dir  -Recurse | where {$_.Length -eq 1MB} 
#the same 
dir | ? Length -eq 1MB
dir | where {$_.Length -eq 1MB}  
dir | where-object {$_.Length -eq 1MB}  

<# 
$_ is special variable for current item in iterator (in pipelines, loops)
$_.Name is property Name in current iterator 

#> 						}
### Comment 
dir | get-member | where {$_.Name -eq 'Length'}

#endregion 

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

#arrays
$vararray = @("String1","String2","String3")
$vararray
$vararray.Count
$vararray[0]
$mergedarray = $vararray + @("String4","String5")
$mergedarray
$mergedarray += "String6"
$mergedarray = $mergedarray "String6"									 
$mergedarray

#arraylist
$varlist = New-Object System.Collections.ArrayList
$varlist.add("String1"); $varlist.add("String2")
$varlist[0]
$varlist.remove("String1")
$varlist[0]

#hash list
$mailadr = @{"Jan"="Jan@Test.com"; "Henryk"="Henryk@Test.com"}
$mailadr
$mailadr["Jan"]
$mailadr
$mailadr["Ziemek"] = "Ziemek@Test.com"
$mailadr
$mailadr.remove("Henryk") 
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

$Henryk = New-Object -TypeName PSObject -Property @{ Name="Henryk";Sex="m" }
$Henryk

$list = $Ziemek,$Henryk
$list
#endregion

#region Use of execute variable $()
Write-host get-date
Write-host $(get-date)
#endregion

#region Writing with format string
cls 

$who = "world"
$greeter = "Ziemek"

Write-Host "hello $who from $greeter"
Write-Host ("hello "+$who+" from "+$greeter)
Write-Host ("hello {0} from {1}" -f $who,$greeter)
Write-Host ("hello {0} from {1} on {2:yyyyMd}" `
-f $who,$greeter,$(get-date))
Write-Host ("hello {0} from {1} on {2:yyyyMMdd}" `
-f $who,$greeter,$(get-date))
Write-Host ("{3,2:##} hello {0} from {1} on {2:HH:mm:ss} {3}" `
-f $who,$greeter,$(get-date),1)
"{3,2:##} hello {0} from {1} on {2:HH:mm:ss}" `
-f $who,$greeter,$(get-date),10
Write-Host "hello $who from $greeter" -foregroundcolor DarkGreen -backgroundcolor white
# Other usage - generate hostname 
$servialNumber = 341
"nor431ash{0:0000000}" -f $servialNumber
# other methods 
$serialString  = $servialNumber.ToString("0000000")
"nor431ash$serialString"
# end other methods 
<#
http://msdn.microsoft.com/en-us/library/txafckwd(v=vs.110).aspx

It is visual basic and c sharp examples but you can easily convert these
"Name = {0}, hours = {1:hh}", myName, DateTime.Now
to
#>
#endregion

#region If then else
$human += New-Object -TypeName PSObject `
-Property @{ Name="Henryk";Sex="m" }
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

#region Comparison_Operators
help about_Comparison_Operators -ShowWindow
<#     Windows PowerShell includes the following comparison operators:

      -eq
      -ne
      -gt
      -ge   
      -lt
      -le
      -Like
      -NotLike
      -Match
      -NotMatch
      -Contains
      -NotContains
      -In
      -NotIn
      -Replace
#> 	  

#endregion

#region switch case
$today = get-date
Switch ($today.dayofweek)
{
	Monday { Write-host "Don't want to work today"}
	Friday { Write-host "Almost weekend" }
	Saturday { Write-host "Weekend!" }
	Sunday { Write-host "A good day to rest" }
	Default { Write-host "Business as usal" }
}

#endregion

#region Loop
$varlist = @("Ziemek","Henryk","Jan")
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
#endregion

#region object array and pipeline
$cars = @()
$cars += New-Object -TypeName PSObject -Property @{ Name="Golf";Engine=1.9;Brand="Volkswagen"}
$cars += New-Object -TypeName PSObject -Property @{ Name="Polo";Engine=1.2;Brand="Volkswagen"}
$cars += New-Object -TypeName PSObject -Property @{ Name="Vanquish";Engine=6;Brand="Aston Martin"}
$cars += New-Object -TypeName PSObject -Property @{ Name="1";Engine=1.6;Brand="BMW"}
$cars += New-Object -TypeName PSObject -Property @{ Name="CLS";Engine=3.5;Brand="Mercedes"}

$cars

$cars | ? { $_.engine -lt 2 }
$cars | % { 
	$fullname = $_.Brand+" "+$_.name
	write-host $fullname
}
$cars | sort-object -descending engine
$cars | sort-object engine  | where { $_.engine -lt 2 }
$cars | sort-object engine  | select -first 3 | select brand,name
$cars | sort-object engine  | select -first 3 | select brand,name | Export-Csv plik.csv
$cars | sort-object engine  | select -first 3 | select brand,name | ConvertTo-Html | Out-File "cars.html"; ii cars.html 


#endregion

#region collecing objects 
dir -File -Recurse | select Name,@{n="KBytes";e={ ($_.Length/1KB).ToString("0000.0")}} 
#or 
cls 
$dir = @()
foreach ($item in (dir -File -Recurse)) {
[int]$SizeKB = $item.Length/1KB

$itemObj = New-Object PSObject
$itemObj | Add-Member NoteProperty -Name FileName -Value $item.Name 
$itemObj | Add-Member NoteProperty -Name SizeKB -Value $SizeKB
$dir += $itemObj
										}
$dir 			| select -first 1
							
#endregion
#region functions
Function repeat-text {
	param ([string]$string="Please learn how to create object",[int]$repeat=5)
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

#region simple-script.ps1
cat simple-script.ps1 
.\simple-script.ps1 -argument "That's argument"#endregion

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

#endregion

#region Homework 
" Homework selection: write one script some specific needs (preferably your, but you can take from list bellow"
$r= (' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ')
$r[0] = " return date and time of the last restart - it should return at least two properties: name of machine and datetime of event "
$r[1] = " test if a specified application has been installed and if it happens after a date of creating a new version of the software (stored somewhere in local machine as MSI package). if the test goes OK: install unattended that newer version of the software. "
$r[2] = " write script which will remove all logs older than one year, and compress older than 30 days in c:\oldLogs" 
$r[3] = " test if specified (as a parameter of a script) service is installed, is working. If not - start it. "
$r[4] = " test if specified website is working, if not send mail to admin or write event to Windows Eventlog "
$r[5] = " test if www.test.com is available on ICMP test, if not set route to specified network to new router"
$r[6] = " copy all files with extension *.pdf to the same folder (with making sure that you will don't overwrite copies)"
$r[$(get-random -maximum $(($r.count -1)))]

#endregion 