@echo off
setlocal enabledelayedexpansion

:: Initialize CSV file header
set "header=title"

:: Load the keyword to grep
for /f %%a in (grep_list.txt) do (
    set "header=!header!,%%a"
)

:: Write header to CSV
echo !header! > csvtest.csv

:: Process file list
for /f "tokens=*" %%f in (file_list.txt) do (
    set "line=%%f"
    set "result=%%f"
    
    :: Search for each Grep target
    for /f %%a in (grep_list.txt) do (
        findstr /m /c:"%%a" "%%f" > nul
        if errorlevel 1 (
            set "result=!result!,FALSE"
        ) else (
            set "result=!result!,TRUE"
        )
    )
    
    echo !result! >> csvtest.csv
)

endlocal
