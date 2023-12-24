::+-+-+-+-+
::BATlister
::+-+-+-+-+
::Batch Script that creates a list of all files in a given directory.

::Author:
::Mister Riley
::sorzkode@proton.me
::https://github.com/sorzkode

::MIT License
::Copyright (c) 2024 Mister Riley
::Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
::to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
::and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
::The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
::THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
::FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
::WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

@echo off 
 
echo BATlister Script
echo Create a .txt list of all files in a given directory
echo ...

:: Get directory path
set /p directory="Enter the directory path (or press Enter to use the script file path): "
if "%directory%"=="" set "directory=%~dp0"

:: Check if directory exists
if not exist "%directory%" (
  echo Invalid directory path. Exiting...
  exit /b
)

:: Get save location
set /p save_location="Enter the save location and file name (e.g. C:\filelist.txt, press Enter to use default): "
if "%save_location%"=="" set "save_location=%directory%\BATlister_output.txt"

:: Check if save location exists
if not exist "%~dpnxsave_location%" (
  echo Invalid save location path. Exiting...
  exit /b
)

:: Check if save location is a directory
echo Generating your file list...

:: Get file count
setlocal enabledelayedexpansion
set total_files=0

:: Count files
for %%i in ("%directory%\*.*") do (
  set /a total_files+=1
)

:: Create file list
echo BATlister Script>>"%save_location%"
echo ================>>"%save_location%"
echo Directory: %directory%>>"%save_location%"
echo Count: %total_files% Files>>"%save_location%"
echo File List:>>"%save_location%"
echo ___________>>"%save_location%"

:: List files
dir /b "%directory%">>"%save_location%"

:: End
echo %save_location% successfully created
echo Press any key to exit

pause>nul