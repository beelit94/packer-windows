:: Ensure C:\Chocolatey\bin is on the path
set /p PATH=<C:\Windows\Temp\PATH

:: add source of http to prevent block by systex's firewall
cmd /c choco sources add -name choco_insecure -source http://chocolatey.org/api/v2/

:: Install packages
cmd /c cinst javaruntime