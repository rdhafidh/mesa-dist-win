@rem Install missing python packages.
@rem State tracking is irrelevant for Python packages as they can easily be added via Pypi if missing.
@rem Meson is the exception because its a Python 3 only package and as a result it can be missing.

@set pypack=0
@set firstpyinstall=1
@set pywin32com=n

:pypackmissing
@rem Check for Python packages availability.
@if %pythonver%==2 IF NOT EXIST %pythonloc:~0,-10%Lib\site-packages\markupsafe (
@set pypack=MarkupSafe
@GOTO pypackinstall
)
@if %pythonver%==2 IF NOT EXIST %pythonloc:~0,-10%Lib\site-packages\mako (
@set pypack=Mako
@GOTO pypackinstall
)
@if %pythonver%==2 if NOT EXIST %pythonloc:~0,-10%Lib\site-packages\win32 (
@set pypack=pywin32
@GOTO pypackinstall
)
@if %pythonver%==2 if NOT EXIST %pythonloc:~0,-10%Scripts\wheel.exe (
@set pypack=wheel
@GOTO pypackinstall
)
@if %pythonver%==2 IF NOT EXIST %pythonloc:~0,-10%Scripts\scons.py  (
@set pypack=scons
@GOTO pypackinstall
)
@if %pythonver%==2 set mesonstate=0
@if %pythonver%==2 GOTO pyupdate

@SET mesonloc=meson.exe
@set mesonstate=2
@SET ERRORLEVEL=0
@where /q meson.exe
@IF ERRORLEVEL 1 set mesonloc=%pythonloc:~0,-10%Scripts\meson.py
@IF %mesonloc%==%pythonloc:~0,-10%Scripts\meson.py IF NOT EXIST %mesonloc% (
@set pypack=meson
@GOTO pypackinstall
)
@IF %mesonloc%==%pythonloc:~0,-10%Scripts\meson.py set mesonloc=%pythonloc% %mesonloc%
@GOTO pyupdate

:pypackinstall
@rem Found a missing package. Install it.
@IF %firstpyinstall%==1 IF NOT %pypack%==0 (
@%pythonloc% -m pip install -U pip
@echo.
@%pythonloc% -m pip install -U setuptools
@echo.
@set firstpyinstall=0
)
@IF NOT %pypack%==0 (
@%pythonloc% -m pip install -U %pypack%
@echo.
)
@IF %pypack%==pywin32 set /p pywin32com=Do you want to install COM and services support - y/n. You'll be asked for admin privileges:
@IF %pypack%==pywin32 echo.
@IF %pypack%==pywin32 IF /I "%pywin32com%"=="y" (
@echo %pythonloc%>%mesa%\mesa-dist-win\buildscript\assets\pythonloc.txt
@powershell -Command Start-Process "%mesa%\mesa-dist-win\buildscript\assets\pywin32.cmd" -Verb runAs
)
@set pypack=0
@GOTO pypackmissing

:pyupdate
@rem Check for python packages updates.
@set pyupd=n
@set /p pyupd=Install/update python packages (y/n):
@echo.
@if /I "%pyupd%"=="y" if %pythonver% GEQ 3 RD /S /Q "%LOCALAPPDATA%\pip"
@if /I "%pyupd%"=="y" for /F "skip=2 delims= " %%m in ('%pythonloc% -m pip list -o --disable-pip-version-check') do @if NOT "%%m"=="pywin32" if NOT "%%m"=="pypiwin32" %pythonloc% -m pip install -U "%%m"
@if /I "%pyupd%"=="y" echo.