@echo off
setlocal enabledelayedexpansion

:: CSVファイルのヘッダーを初期化
set "header=タイトル"

:: Grep対象のキーワードを読み込む
for /f %%a in (grep_list.txt) do (
    set "header=!header!,%%a"
)

:: ヘッダーをCSVに書き込む
echo !header! > csvtest.csv

:: ファイルリストを処理
for /f "tokens=*" %%f in (file_list.txt) do (
    set "line=%%f"
    set "result=%%f"
    
    :: 各Grep対象で検索
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
