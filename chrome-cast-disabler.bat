@echo Off
REM Ensures administrative privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )


set KeyPath=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome
set ValueName=EnableMediaRouter

cls
:start
echo.
echo This tool can disable and re-enable chrome cast functionality on chrome.
echo Please pick an option:
echo    1. Disable
echo    2. Enable
echo.
set choice=
set /p choice=Select an option: [1,2].
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' reg add "%KeyPath%" /v "%ValueName%" /t REG_DWORD /d 0 /f && echo. && echo Chrome Cast disabled! && goto end
if '%choice%'=='2' reg add "%KeyPath%" /v "%ValueName%" /t REG_DWORD /d 1 /f && echo. && echo Chrome Cast enabled. && goto end
echo "%choice%" is not valid, try again
echo.
goto start

:end
echo You may need to restart Chrome for changes to take effect.
pause