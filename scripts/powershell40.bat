:: install powershell 4.0 windows 2012, windows 7, windows 2008 r2

if exist "%PROGRAMFILES(X86)%" goto :X64
if not exist "%PROGRAMFILES(X86)%" goto :X86
goto :DONE

:X64
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x64-MultiPkg.msu', 'C:\Windows\Temp\Windows6.1-KB2819745-x64-MultiPkg.msu')" <NUL
start /wait wusa C:\Windows\Temp\Windows6.1-KB2819745-x64-MultiPkg.msu /quiet /norestart
GOTO :DONE

:X86
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x86-MultiPkg.msu', 'C:\Windows\Temp\Windows6.1-KB2819745-x86-MultiPkg.msu')" <NUL
start /wait wusa C:\Windows\Temp\Windows6.1-KB2819745-x86-MultiPkg.msu /quiet /norestart
GOTO :DONE

:DONE
shutdown /r /t 5