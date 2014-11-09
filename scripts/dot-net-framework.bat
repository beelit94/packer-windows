:: Net framework 4.5.1
:: Windows Vista SP2, Windows 7 SP1, Windows 8, Windows Server 2008 SP2 Windows Server 2008 R2 SP1 and Windows Server 2012

set URL=http://download.microsoft.com/download/1/6/7/167F0D79-9317-48AE-AEDB-17120579F8E2/NDP451-KB2858728-x86-x64-AllOS-ENU.exe
set TARGET=C:\Windows\Temp\NDP451-KB2858728-x86-x64-AllOS-ENU.exe

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%URL%', '%TARGET%')" <NUL
start /wait %TARGET% /q /norestart