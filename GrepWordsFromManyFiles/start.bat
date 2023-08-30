@echo off
setlocal enabledelayedexpansion

:: FOR DEBUG  set the start time
set "start_time=%time%"

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
    @echo === %%f ==============================
    :: Search for each Grep target
    for /f %%a in (grep_list.txt) do (
        @echo === %%f === %%a
        findstr /m /c:"%%a" "%%f" > nul
        if errorlevel 1 (
            set "result=!result!,FALSE"
        ) else (
            set "result=!result!,TRUE"
        )
    )
    
    echo !result! >> csvtest.csv
)

:: FOR DEBUG  delta time check
:: ping localhost

:: FOR DEBUG  set the end time
set "end_time=%time%"

:: FOR DEBUG  Calculate the elapsed time (in this example, calculated in seconds)
:: FOR DEBUG  Show the individual components of the time
for /f "tokens=1-3 delims=:" %%a in ("%start_time%") do (
    :: echo Debug: Hour=%%a, Minute=%%b, Second=%%c
    for /f "tokens=1 delims=." %%x in ("%%c") do set "clean_second=%%x"
    set /a "start=%%a*3600 + %%b*60 + clean_second"
)
:: FOR DEBUG  Calculate the elapsed time (in this example, calculated in seconds)
for /f "tokens=1-3 delims=:" %%a in ("%end_time%") do (
    for /f "tokens=1 delims=." %%x in ("%%c") do set "clean_second=%%x"
    set /a "end=%%a*3600 + %%b*60 + clean_second"
)

:: FOR DEBUG  Display the start time
@echo Start Time: %start_time%
:: FOR DEBUG  Display the end time
@echo End Time: %end_time%
:: FOR DEBUG  Display the elapsed time
set /a elapsed_time=end-start
@echo Elapsed Time: %elapsed_time% seconds

endlocal

pause