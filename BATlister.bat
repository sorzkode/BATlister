::+-+-+-+-+
::BATlister
::+-+-+-+-+
::Batch Script that creates a list of all files in a given directory.

::Author:
::sorzkode
::https://github.com/sorzkode

::MIT License

@echo off
setlocal enabledelayedexpansion

echo BATlister Script
echo Create a .txt list of all files and folders in a given directory
echo ...

:loop
:: Get directory path
:input_directory
set /p directory="Enter the directory path (or press Enter to use the script file path): "
if "%directory%"=="" set "directory=%~dp0"

:: Remove trailing backslash if present
if "%directory:~-1%"=="\" set "directory=%directory:~0,-1%"

:: Check if directory exists
if not exist "%directory%" (
  echo Invalid directory path. Please try again.
  goto input_directory
)

:: Get recursive option
:input_recursive
set /p recursive="Include subdirectories? (Y/N, default is N): "
if "%recursive%"=="" set "recursive=N"
if /i "%recursive%"=="Y" (
  set "recursive_flag=/s"
) else if /i "%recursive%"=="N" (
  set "recursive_flag="
) else (
  echo Invalid input. Please enter Y or N.
  goto input_recursive
)

:: Get listing format
:input_format
set /p format="Listing format - (1) Flat list or (2) Tree view (default is 1): "
if "%format%"=="" set "format=1"
if "%format%"=="1" (
  set "format_type=flat"
) else if "%format%"=="2" (
  set "format_type=tree"
) else (
  echo Invalid input. Please enter 1 or 2.
  goto input_format
)

:: Get save location
:input_save_location
set /p save_location="Enter the save location and file name (e.g. C:\filelist.txt, press Enter to use default): "
if "%save_location%"=="" set "save_location=%directory%\BATlister_output.txt"

:: Ensure save location directory exists and is writable
for %%F in ("%save_location%") do set "save_dir=%%~dpF"
if not exist "%save_dir%" (
  echo Invalid save location path. Please try again.
  goto input_save_location
)

:: Test write permissions
echo Test > "%save_location%" 2>nul
if not exist "%save_location%" (
  echo Cannot write to the specified location. Access Denied. Please try again.
  goto input_save_location
)
del "%save_location%" 2>nul

echo.
echo Generating your file list...
echo Please wait, this may take a while for large directories...
echo.

:: Initialize counters
set total_files=0
set total_folders=0
set total_size=0

:: Count files and folders
if /i "%recursive%"=="Y" (
  for /f %%i in ('dir "%directory%" /a-d /s 2^>nul ^| find "File(s)"') do set total_files=%%i
  for /f %%i in ('dir "%directory%" /a-d /s 2^>nul ^| find "Dir(s)"') do set total_folders=%%i
) else (
  for /f %%i in ('dir "%directory%" /a-d 2^>nul ^| find "File(s)"') do set total_files=%%i
  for /f %%i in ('dir "%directory%" /a-d 2^>nul ^| find "Dir(s)"') do set total_folders=%%i
)

:: Handle empty directory
if "%total_files%"=="" set total_files=0
if "%total_folders%"=="" set total_folders=0

:: Create file list header
echo 📝 BATlister Script > "%save_location%"
echo ⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸⩸ >> "%save_location%"
echo 🗄️ Directory: %directory% >> "%save_location%"
echo 🔄 Recursive: %recursive% >> "%save_location%"
echo 🗃️ File Count: %total_files% >> "%save_location%"
echo 📁 Folder Count: %total_folders% >> "%save_location%"
echo ____________________ >> "%save_location%"

:: Calculate total size
echo Calculating statistics...
set total_bytes=0

if /i "%recursive%"=="Y" (
  for /f "delims=" %%i in ('dir "%directory%\*.*" /a-d /s /b 2^>nul') do (
    for %%A in ("%%i") do (
      set /a total_bytes+=%%~zA
    )
  )
) else (
  for /f "delims=" %%i in ('dir "%directory%\*.*" /a-d /b 2^>nul') do (
    for %%A in ("%directory%\%%i") do (
      set /a total_bytes+=%%~zA
    )
  )
)

:: Convert bytes to human-readable format
set /a total_kb=total_bytes/1024
set /a total_mb=total_kb/1024
set /a total_gb=total_mb/1024

echo 💾 Total Size: %total_bytes% bytes >> "%save_location%"
if %total_kb% gtr 0 echo            : %total_kb% KB >> "%save_location%"
if %total_mb% gtr 0 echo            : %total_mb% MB >> "%save_location%"
if %total_gb% gtr 0 echo            : %total_gb% GB >> "%save_location%"
echo ____________________ >> "%save_location%"
echo 📃 File and Folder List: >> "%save_location%"
echo. >> "%save_location%"

:: List files and folders based on format
if "%format_type%"=="tree" (
  tree "%directory%" %recursive_flag% /F >> "%save_location%"
) else (
  if /i "%recursive%"=="Y" (
    dir "%directory%" /s /b >> "%save_location%"
  ) else (
    dir "%directory%" /b >> "%save_location%"
  )
)

:: End
echo.
echo ✅ %save_location% successfully created!
echo.
echo Press Enter to create another list, or type 'exit' and press Enter to quit
echo.

set "continue="
set /p continue="> "
if "%continue%"=="" (
  cls
  goto loop
)
if /i "%continue%"=="exit" (
  echo Goodbye!
  exit /b 0
)
cls
goto loop
