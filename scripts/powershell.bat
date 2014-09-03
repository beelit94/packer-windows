:: install powershell 4.0

IF EXIST "%PROGRAMFILES(X86)%" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x86-MultiPkg.msu', 'C:\Windows\Temp\Windows6.1-KB2819745-x86-MultiPkg.msu')" <NUL
	wusa.exe C:\Windows\Temp\Windows6.1-KB2819745-x86-MultiPkg.msu /quiet /forcerestart
) ELSE (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x64-MultiPkg.msu', 'C:\Windows\Temp\Windows6.1-KB2819745-x64-MultiPkg.msu')" <NUL
	wusa.exe C:\Windows\Temp\Windows6.1-KB2819745-x64-MultiPkg.msu /quiet /forcerestart	
)

shutdown /r /t 5