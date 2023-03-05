::+-+-+-+-+
::BATlister
::+-+-+-+-+
::Batch Script that creates a list of all files in a given directory.

::Author:
::Mister Riley
::sorzkode@proton.me
::https://github.com/sorzkode

::MIT License
::Copyright (c) 2023 Mister Riley
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
set /p directory="Enter the directory path: "
set /p save_location="Enter the save location and file name (e.g. C:\filelist.txt): "

echo Generating your file list...

setlocal enabledelayedexpansion
set total_files=0

for %%i in ("%directory%\*.*") do (
  set /a total_files+=1
)

echo BATlister Script>>"%save_location%"
echo ================>>"%save_location%"
echo Directory: %directory%>>"%save_location%"
echo Count: %total_files% Files>>"%save_location%"
echo File List:>>"%save_location%"
echo ___________>>"%save_location%"

dir /b "%directory%">>"%save_location%"

echo %save_location% successfully created
echo Press any key to exit

pause>nul


