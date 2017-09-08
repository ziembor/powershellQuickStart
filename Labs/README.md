## Lab: Using the Help System 
1. First, run Update-Help and ensure it completes without errors. That will get a copy of the help on your local computer. This requires an Internet connection, and requires that the shell be running under elevated privileges (which means it must say “Administrator” in the shell’s window title bar).
2. Can you find any cmdlets capable of converting other cmdlets’ output into HTML?
3. Are there any cmdlets that can redirect output into a file, or to a printer?
4. How many cmdlets are available for working with processes? (Hint: remember that cmdlets all use a singular noun.)
5. What cmdlet might you use to write to an event log?
6. You’ve learned that aliases are nicknames for cmdlets; what cmdlets are available to create, modify, export, or import aliases?
7. Is there a way to keep a transcript of everything you type in the shell, and save that transcript to a text file?
8. It can take a long time to retrieve all of the entries from the Security event log. How can you get just the 100 most recent entries?
9. Is there a way to retrieve a list of the services that are installed on a remote computer?
10. Is there a way to see what processes are running on a remote computer?
11. Examine the help file for the Out-File cmdlet. The files created by this cmdlet default to a width of how many characters? Is there a parameter that would enable you to change that width?
12. By default, Out-File will overwrite any existing file that has the same filename as what you specify. Is there a parameter that would prevent the cmdlet from overwriting an existing file?
13. How could you see a list of all aliases defined in PowerShell?
14. Using both an alias and abbreviated parameter names, what is the shortest command line you could type to retrieve a list of running processes from a computer named Server1?
15. How many cmdlets are available that can deal with generic objects? (Hint: remember to use a singular noun like “object” rather than a plural one like “objects”). 
16. This chapter briefly mentioned arrays. What help topic could tell you more about them?
17. The Help command can also search the contents of a help file. Are there any topics that might explain any breaking changes between PowerShell v1 and PowerShell v2?

## Lab: Running Commands 
Using just what you learned in this chapter, and in the previous chapter on using the help system, complete the following tasks in Windows PowerShell:
1. Display a list of running processes.
2. Display the 100 most recent entries from the Application event log (don’t use Get-WinEvent for this – We’ve shown you another command that will do this task).
3. Display a list of all commands that are of the “cmdlet” type (this is tricky – we’ve shown you Get-Command, but you’re going to have to read the help to find out how to narrow down the list as we’ve asked).
4. Display a list of all aliases.
5. Make a new alias, so that you can run “d” to get a directory listing.
6. Display a list of services that begin with the letter “M.” Again, read the help for the necessary command – and don’t forget that “*” is a near-universal wildcard in PowerShell.
7. Display a list of all Windows Firewall rules. You’ll need to use Help or Get-Command to discover the necessary cmdlet!
8. Display a list only of inbound Windows Firewall rules. Same cmdlet as above, but you’ll need to read its help to discover the necessary parameter and its allowable values

## Lab: Working with Providers
Complete the following tasks:
1. In the registry, go to HKEY_CURRENT_USER\software\microsoft\Windows\currentversion\ explorer. Locate the Advanced key, and set its DontPrettyPath property to 1.
2. Create a zero-length file named C:\Test.txt (use New-Item). 
3. Is it possible to use Set-Item to change the contents of C:\Test.txt to TESTING? Or do you get an error? If you get an error, why?
4. What are the differences between the –Filter, -Include, and –Exclude parameters of GetChildItem?

## Lab: Lab The Pipeline: Connecting Commands
1. Create two similar, but different, text files. Try comparing them using Diff. To do so, run something like this: Diff -reference (Get-Content File1.txt) -difference (Get-Content File2.
txt). If the files have only one line of text that’s different, the command should work. 
2. What happens if you run Get-Service | Export-CSV services.csv | Out-File from the console? Why does that happen?
3. Apart from getting one or more services and piping them to Stop-Service, what other means does Stop-Service provide for you to specify the service or services you want to stop? Is it possible to stop a service without using Get-Service at all?
4. What if you wanted to create a pipe-delimited file instead of a comma-separated file? You would still use the Export-CSV command, but what parameters would you specify?
5. Is there a way to eliminate the # comment line from the top of an exported CSV file? That line normally contains type information, but what if you wanted to omit that from a particular file?
6. Export-CliXML and Export-CSV both modify the system, because they can create and overwrite files. What parameter would prevent them from overwriting an existing file? What parameter would ask you if you were sure before proceeding to write the output file?
7. Windows maintains several regional settings, which include a default list separator. On U.S. systems, that separator is a comma. How can you tell Export-CSV to use the system’s default separator, rather than a comma?

## Lab: Objects: Just Data by Another Name
This chapter has probably covered more, and more difficult, new concepts than any chapter so far. Hopefully we were able to make it all make sense, but these exercises should help you cement everything. See if you can complete them all, and remember that there are companion videos and sample solutions at MoreLunches.com. Some of these tasks will draw on skills you learned in previous chapters, as a way of refreshing your memory and keeping you sharp.
1. Identify a cmdlet that will produce a random number.
2. Identify a cmdlet that will display the current date and time.
3. What type of object does the cmdlet from task #2 produce? (What is the type name of the object produced by the cmdlet?)
4. Using the cmdlet from task #2 and Select-Object, display only the current day of the week in a table like this (caution: The output will right-align, so make sure your PowerShell window doesn’t have a horizontal scroll bar):
5. Identify a cmdlet that will display information about installed hotfixes.
6. Using the cmdlet from task #5, display a list of installed hotfixes. Sort the list by the installation date, and display only the installation date, the user who installed the hotfix, and the hotfix ID.
7. Repeat task #6, but this time sort the results by the hotfix description, and include the description, the hotfix ID, and the installation date. Put the results into an HTML file.
8. Display a list of the 50 newest entries from the Security event log (you can use a different log, such as System or Application if your Security log is empty). Sort the list so that the oldest entries appear first and so that entries made at the same time are sorted by their index. Display the index, time, and source for each entry. Put this information into a text file (not an HTML file, just a plain text file). You may be tempted to use Select-Object and its –first or –last parameters to achieve this; don’t. There’s a better way. Also, avoid using Get-WinEvent for now – there’s a better cmdlet to work with for this particular task.

# Lab The Pipeline, Deeper Lab
Consider the Get-ADComputer command. This command is installed on any Windows Server 2008 R2 or later domain controller – but you don’t need one! You only need to know two things:
* The Get-ADComputer command has a –filter parameter; running Get-ADComputer –filter * will retrieve all computer objects in the domain.
* Domain computer objects have a Name property, which contains the computer’s host name.
* Domain computer objects have the TypeName ADComputer. So, Get-ADComputer produces objects of the type ADComputer.
That’s all you should need to know. With that in mind, complete these tasks:
NOTE: You’re not being asked to run these commands. Instead, you’re being asked if these commands will function or not, and why. You’ve been told how Get-ADComputer works, and what it produces; you can read the help to discover what other commands expect and accept.
1. Would the following command work to retrieve a list of installed hotfixes from all domain controllers in the specified domain? Why or why not? Write out an explanation, similar to the ones we provided earlier in this chapter.
```
Get-Hotfix -computerName (get-adcomputer -filter * | Select-Object -expand name)
```
2. Would this alternative command work to retrieve the list of hotfixes from the same computers? Why or why not? Write out an explanation, similar to the ones we provided earlier in this chapter.
```
get-adcomputer -filter * |Get-HotFix
````
3. Would this third version of the command work to retrieve the list of hotfixes from the domain controllers? Why or why not? Write out an explanation, similar to the ones I provided earlier in this chapter.
```
get-adcomputer -filter * |
Select-Object @{l=’computername’;e={$_.name}} |
Get-Hotfix
```

4. Write a command that uses pipeline parameter binding to retrieve a list of running processes from every computer in an AD domain. Don’t use parentheses.
5. Write a command that retrieves a list of installed services from every computer in an AD domain. Don’t use pipeline input; instead use a parenthetical command (a command in parentheses). 
6. Sometimes Microsoft forgets to add pipeline parameter binding to a cmdlet. For example, would the following command work to retrieve information from every domain controller in the domain? Write out an explanation, similar to the ones we provided earlier in this chapter.
```
get-adcomputer -filter * |
   Select-Object @{l=’computername’;e={$_.name}} |
Get-WmiObject -class Win32_BIOS
```

# Lab Formatting – and Why It’s Done on the Right 

See if you can complete the following tasks:
1. Display a table of processes that includes only the process names, IDs, and whether or not they’re responding to Windows (the Responding property has that information). Have the table take up as little horizontal room as possible, but don’t allow any information to be truncated.
2. Display a table of processes that includes the process names and IDs. Also include columns for virtual and physical memory usage, expressing those values in megabytes (MB).
3. Use Get-EventLog to display a list of available event logs. (Hint: you’ll need to read the help to learn the correct parameter to accomplish that.) Format the output as a table that includes, in this order, the log display name and the retention period. The column headers must be “LogName” and “RetDays.”
4. Display a list of services so that a separate table is displayed for services that are started and services that are stopped. Services that are started should be displayed first. (Hint: you’ll use a -groupBy parameter).

## Lab Filtering and Comparisons

Following the principle of filter left, try to accomplish the following:
1. Import the NetAdapter module (available in the latest version of Windows, both client and server). Using the Get-NetAdapter cmdlet, display a list of non-virtual network adapters (that is, adapters whose Virtual property is False, which PowerShell represents with the special $False constant).
2. Import the DnsClient module (available in the latest version of Windows, both client and server). Using the Get-DnsClientCache cmdlet, display a list of A and AAAA records from the cache. Hint: If your cache comes up empty, try visiting a few Web pages first to force some items into the cache.
3. Display a list of hotfixes that are security updates.
4. Using Get-Service, is it possible to display a list of services that have a start type of Automatic, but that aren’t currently started?
5. Display a list of hotfixes that were installed by the Administrator, and which are updates. Note that some hotfixes won’t have an “installed by” value – that’s okay.
6. Display a list of all processes running as either Conhost or Svchost.





