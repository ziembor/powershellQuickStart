## Lab: Using the Help System 
		
1.	First, run Update-Help and ensure it completes without errors. That will get a copy of the help on your local computer. This requires an Internet connection, and requires that the shell be running under elevated privileges (which means it must say “Administrator” in the shell’s window title bar).
2.	Can you find any cmdlets capable of converting other cmdlets’ output into HTML?
3.	Are there any cmdlets that can redirect output into a file, or to a printer?
4.	How many cmdlets are available for working with processes? (Hint: remember that cmdlets all use a singular noun.)
5.	What cmdlet might you use to write to an event log?
6.	You’ve learned that aliases are nicknames for cmdlets; what cmdlets are available to create, modify, export, or import aliases?
7.	Is there a way to keep a transcript of everything you type in the shell, and save that transcript to a text file?
8.	It can take a long time to retrieve all of the entries from the Security event log. How can you get just the 100 most recent entries?
9.	Is there a way to retrieve a list of the services that are installed on a remote computer?
10.	Is there a way to see what processes are running on a remote computer?
11.	Examine the help file for the Out-File cmdlet. The files created by this cmdlet default to a width of how many characters? Is there a parameter that would enable you to change that width?
12.	By default, Out-File will overwrite any existing file that has the same filename as what you specify. Is there a parameter that would prevent the cmdlet from overwriting an existing file?
13.	How could you see a list of all aliases defined in PowerShell?
14.	Using both an alias and abbreviated parameter names, what is the shortest command line you could type to retrieve a list of running processes from a computer named Server1?
15.	How many cmdlets are available that can deal with generic objects? (Hint: remember to use a singular noun like “object” rather than a plural one like “objects”). 
16.	This chapter briefly mentioned arrays. What help topic could tell you more about them?
17.	The Help command can also search the contents of a help file. Are there any topics that might explain any breaking changes between PowerShell v1 and PowerShell v2?

## Lab: Running Commands 
Using just what you learned in this chapter, and in the previous chapter on using the help system, complete the following tasks in Windows PowerShell:
1.	Display a list of running processes.
2.	Display the 100 most recent entries from the Application event log (don’t use Get-WinEvent for this – We’ve shown you another command that will do this task).
3.	Display a list of all commands that are of the “cmdlet” type (this is tricky – we’ve shown you Get-Command, but you’re going to have to read the help to find out how to narrow down the list as we’ve asked).
4.	Display a list of all aliases.
5.	Make a new alias, so that you can run “d” to get a directory listing.
6.	Display a list of services that begin with the letter “M.” Again, read the help for the necessary command – and don’t forget that “*” is a near-universal wildcard in PowerShell.
7.	Display a list of all Windows Firewall rules. You’ll need to use Help or Get-Command to discover the necessary cmdlet!
8.	Display a list only of inbound Windows Firewall rules. Same cmdlet as above, but you’ll need to read its help to discover the necessary parameter and its allowable values

# Lab: Working with Providers
Complete the following tasks:
1.	In the registry, go to HKEY_CURRENT_USER\software\microsoft\Windows\currentversion\ explorer. Locate the Advanced key, and set its DontPrettyPath property to 1.
2.	Create a zero-length file named C:\Test.txt (use New-Item). 
3.	Is it possible to use Set-Item to change the contents of C:\Test.txt to TESTING? Or do you get an error? If you get an error, why?
4.	What are the differences between the –Filter, -Include, and –Exclude parameters of GetChildItem?

# Lab: Lab The Pipeline: Connecting Commands
1.	Create two similar, but different, text files. Try comparing them using Diff. To do so, run something like this: Diff -reference (Get-Content File1.txt) -difference (Get-Content File2.
txt). If the files have only one line of text that’s different, the command should work. 
2.	What happens if you run Get-Service | Export-CSV services.csv | Out-File from the console? Why does that happen?
3.	Apart from getting one or more services and piping them to Stop-Service, what other means does Stop-Service provide for you to specify the service or services you want to stop? Is it possible to stop a service without using Get-Service at all?
4.	What if you wanted to create a pipe-delimited file instead of a comma-separated file? You would still use the Export-CSV command, but what parameters would you specify?
5.	Is there a way to eliminate the # comment line from the top of an exported CSV file? That line normally contains type information, but what if you wanted to omit that from a particular file?
6.	Export-CliXML and Export-CSV both modify the system, because they can create and overwrite files. What parameter would prevent them from overwriting an existing file? What parameter would ask you if you were sure before proceeding to write the output file?
7.	Windows maintains several regional settings, which include a default list separator. On U.S. 
systems, that separator is a comma. How can you tell Export-CSV to use the system’s default separator, rather than a comma?



