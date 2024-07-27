::+-+-+-+-+
::BATlister
::+-+-+-+-+
::Batch Script that creates a list of all files in a given directory.

::Author:
::Mister Riley
::sorzkode@proton.me
::https://github.com/sorzkode

::MIT License

@echo off

echo BATlister Script
echo Create a .txt list of all files and folders in a given directory
echo ...

:loop
:: Get directory path
:input_directory
set /p directory="Enter the directory path (or press Enter to use the script file path): "
if "%directory%"=="" set "directory=%~dp0"

:: Check if directory exists
if not exist "%directory%" (
  echo Invalid directory path. Please try again.
  goto input_directory
)

:: Get save location
:input_save_location
set /p save_location="Enter the save location and file name (e.g. C:\filelist.txt, press Enter to use default): "
if "%save_location%"=="" set "save_location=%directory%\BATlister_output.txt"

:: Ensure save location directory exists and is writable
set save_dir=%~dp0
if not exist "%save_dir%" (
  echo Invalid save location path. Please try again.
  goto input_save_location
)

:: Test write permissions
echo Test > "%save_location%"
if %errorlevel% neq 0 (
  echo Cannot write to the specified location. Access Denied. Please try again.
  del "%save_location%"
  goto input_save_location
)
del "%save_location%"

echo Generating your file list...

:: Get file and folder count
setlocal enabledelayedexpansion
set total_files=0
set total_folders=0

:: Count files
for %%i in ("%directory%\*.*") do (
  set /a total_files+=1
)

:: Count folders
for /d %%i in ("%directory%\*") do (
  set /a total_folders+=1
)

:: Create file list
echo 📝 BATlister Script > "%save_location%"
echo ⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸ >> "%save_location%"
echo 🗄️ Directory: %directory% >> "%save_location%"
echo 🗃️ File Count: %total_files% >> "%save_location%"
echo 📁 Folder Count: %total_folders% >> "%save_location%"
echo ____________________ >> "%save_location%"
echo 📃 File and Folder List: >> "%save_location%"

:: List files and folders
dir /b "%directory%" >> "%save_location%"

:: End
echo %save_location% successfully created
echo Press Enter to create another list or any other key to exit

set /p continue=
if "%continue%"=="" (
  cls
  goto loop
)
pause