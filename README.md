# BATlister

BATlister is a batch script for Windows that generates a comprehensive list of all files and folders in a given directory and saves it to a text file with detailed information.

![BATlister](https://raw.githubusercontent.com/sorzkode/BATlister/master/BATlister.jpg)

## Example

![Example](https://raw.githubusercontent.com/sorzkode/BATlister/master/example.jpg)
![Example 2](https://raw.githubusercontent.com/sorzkode/BATlister/master/example2.jpg)

## Requirements

- Windows operating system

## Installation

1. Download the BATlister script.
2. Save the BATlister script to a directory of your choice.

## Usage

1. Open Command Prompt (or run as Administrator if needed for certain directories).
2. Navigate to the directory where the BATlister script is saved.
3. Type `BATlister.bat` and press Enter.
4. Follow the interactive prompts:
   - Enter the directory path (or press Enter to use the script's location)
   - Choose whether to include subdirectories (Y/N)
   - Select listing format: Flat list (1) or Tree view (2)
   - Enter the save location and file name (or press Enter for default)
5. Wait for the script to generate the file list and save it to the text file.
6. Press Enter to create another list, or type 'exit' to quit.

## Features

- **Recursive scanning**: Option to include subdirectories or scan only the target directory
- **Multiple output formats**: Choose between flat list or tree view visualization
- **Flexible output**: Specify custom save location or use default naming
- **Error handling**: Validates directory paths and write permissions
- **Loop functionality**: Create multiple lists without restarting the script
- **Cross-platform paths**: Handles paths with or without trailing backslashes