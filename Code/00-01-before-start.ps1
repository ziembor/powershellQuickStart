Start-Transcript $env:Temp\GettingStarted.txt -Force

Set-ExecutionPolicy RemoteSigned -Force -Scope CurrentUser

get-host 

Stop-Transcript
notepad $env:Temp\GettingStarted.txt