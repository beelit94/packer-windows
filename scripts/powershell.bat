:: install powershell 4.0

if exist "%PROGRAMFILES(X86)%" goto :X64
if not exist "%PROGRAMFILES(X86)%" goto :X86
goto :DONE

:X64
echo "debug: on x64"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x64-MultiPkg.msu', 'C:\Windows\Temp\Windows6.1-KB2819745-x64-MultiPkg.msu')" <NUL
wusa.exe C:\Windows\Temp\Windows6.1-KB2819745-x64-MultiPkg.msu /quiet /norestart || echo "install failed"
GOTO :DONE

:X86
echo "debug: on x86"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x86-MultiPkg.msu', 'C:\Windows\Temp\Windows6.1-KB2819745-x86-MultiPkg.msu')" <NUL
wusa.exe C:\Windows\Temp\Windows6.1-KB2819745-x86-MultiPkg.msu /quiet /norestart || echo "install failed"
GOTO :DONE

:DONE
echo "debug: prepare to reboot..."
timeout /t 60
shutdown /r /t 0


::IF EXIST "%PROGRAMFILES(X86)%" (
::	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x86-MultiPkg.msu', 'C:\Windows\Temp\Windows6.1-KB2819745-x86-MultiPkg.msu')" <NUL
::	wusa.exe C:\Windows\Temp\Windows6.1-KB2819745-x86-MultiPkg.msu /quiet /norestart
::) ELSE (
::	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x64-MultiPkg.msu', 'C:\Windows\Temp\Windows6.1-KB2819745-x64-MultiPkg.msu')" <NUL
::	wusa.exe C:\Windows\Temp\Windows6.1-KB2819745-x64-MultiPkg.msu /quiet /norestart	
::)
