:start
@echo off
:loop1
SET loc=C:\Users\curryp.UMROOT\Desktop\Manual_RRFB\manual_RRFB_converted\ex_RRFB_Beal_EB\
for /f %%A in ('dir %loc% ^| find "File(s)"') do set cnt=%%A
echo Samples Left = %cnt%

echo press 1 to label as Flashing
echo press 2 to label as Not_Flashing 
echo press 3 to label as Unknown
echo press 4 to rewatch
echo press 5 to exit
echo.
for %%i in (%loc%/*) do (
	start %%i
	SET name=%%i
	choice /c 12345
	goto test
)
:test
cls
echo Errorlevel = %errorlevel%
if %errorlevel% == 1 goto 1
if %errorlevel% == 2 goto 2
if %errorlevel% == 3 goto 3
if %errorlevel% == 4 goto re
if %errorlevel% == 5 goto end

:1
echo.
echo Labeled %name% as Flashing
move "%name%" "%loc%\Flashing"
echo.
goto loop1
:2
echo.
echo Labeled %name% as Not_Flashing
move "%name%" "%loc%\Not_Flashing"
echo.
goto loop1
:3
echo.
echo Labeled %name% as Unknown
move "%name%" "%loc%\Not_Flashing"
echo.
goto loop1
:re
echo.
echo Replaying %name%
echo.
goto loop1
:end
echo ended
pause
Exit