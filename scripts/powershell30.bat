:: install powershell 3.0 on windows 2008 r2 sp1 & windows 7 sp1

if exist "%PROGRAMFILES(X86)%" goto :X64
if not exist "%PROGRAMFILES(X86)%" goto :X86
goto :DONE

:X64
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x64.msu', 'C:\Windows\Temp\Windows6.1-KB2506143-x64.msu')" <NUL
wusa.exe C:\Windows\Temp\Windows6.1-KB2506143-x64.msu /quiet /norestart
GOTO :DONE

:X86
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x86.msu', 'C:\Windows\Temp\Windows6.1-KB2506143-x86.msu')" <NUL
wusa.exe C:\Windows\Temp\Windows6.1-KB2506143-x86.msu /quiet /norestart
GOTO :DONE

:DONE
timeout /t 60
shutdown /r /t 0