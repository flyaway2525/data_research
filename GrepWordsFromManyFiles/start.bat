@echo off
setlocal enabledelayedexpansion

:: Set the character count limit
set charLimit=8000

:: Check command-line argument
if "%~1"=="-y" (
    set check=Y
) else if "%~1"=="-n" (
    set check=N
) else (
    :: Ask the user if no command-line argument is provided
    goto startCheckCaracterCount
)
:endCheckCharacterCount

:: function A Do or Not Check Caracter Count
goto nextprocessA
:startCheckCaracterCount
set /p check=Do you want to check the character count? (Y/N): 
goto endCheckCharacterCount
:nextprocessA

:: FOR DEBUG  set the start time
set "start_time=%time%"

:: Initialize CSV file header
set "header=title"

:: Load the keyword to grep
for /f %%a in (grep_list.txt) do (
    set "header=!header!,%%a"
)

:: Proceed if 'Y' or 'y' is selected
if /i "%check%"=="Y" (
    :: Check if header character count exceeds the limit
    set count=0
    :loopHeader
    if defined headerCheck (
        set "char=!header:~0,1!"
        set "header=!header:~1!"
        set /a count+=1
        goto loopHeader
    )
    if !count! geq %charLimit% (
        goto startContinueNextProcess
    ) else (
        echo characters : !count! under the char Limit : %charLimit% 
    )
)
:endContinueNextProcess

:: Function B Continue or Not Next Process
goto nextprocessB
:startContinueNextProcess
echo characters : !count! over the char Limit : %charLimit% 
set /p proceed=Warning: Header character count is %charLimit% or more. Continue? (Y/N):
if /i "!proceed!"=="N" (
    echo Exiting the program.
    exit /b
)
goto endContinueNextProcess
:nextprocessB

:: START GREP PROCESS
echo:  
echo START GREPS

:: Write header to CSV
echo !header! > csvtest.csv

:: Process file list
for /f "tokens=*" %%f in (file_list.txt) do (
    set "line=%%f"
    set "result=%%f"
    @echo === %%f ==============================
    :: Search for each Grep target
    for /f %%a in (grep_list.txt) do (
        findstr /m /c:"%%a" "%%f" > nul
        if errorlevel 1 (
            set "result=!result!,"
        ) else (
            set "result=!result!,1"
        )
    )
    echo !result! >> csvtest.csv
)

:: FOR DEBUG  delta time check
:: ping localhost

:: FOR DEBUG  set the end time
set "end_time=%time%"

:: FOR DEBUG  Calculate the elapsed time
for /f "tokens=1-3 delims=:" %%a in ("%start_time%") do (
    for /f "tokens=1 delims=." %%x in ("%%c") do set "clean_second=%%x"
    set /a "start=%%a*3600 + %%b*60 + clean_second"
)
for /f "tokens=1-3 delims=:" %%a in ("%end_time%") do (
    for /f "tokens=1 delims=." %%x in ("%%c") do set "clean_second=%%x"
    set /a "end=%%a*3600 + %%b*60 + clean_second"
)

:: FINISHED GREP PROCESS
echo:  
echo FINISHED GREPS
:: FOR DEBUG  Display the start time
@echo Start Time: %start_time%
:: FOR DEBUG  Display the end time
@echo End Time: %end_time%
:: FOR DEBUG  Display the elapsed time
set /a elapsed_time=end-start
@echo Elapsed Time: %elapsed_time% seconds

endlocal

pause