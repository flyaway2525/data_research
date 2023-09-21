setlocal

rem ============================================================
rem   Grep条件入力
rem ============================================================

rem 検索対象（対象ファイルとなるファイルの名称と拡張子を指定）
set TARGET_FILE=*.vb

rem フォルダ（対象となるフォルダを指定）
set TARGET_PATH=C:\SampleFolder

rem 除外ファイル（除外対象とするファイルを指定）
set EXCLUDED_FILE=*.exe;*.old;*.bak

rem 除外フォルダ（除外対象とするフォルダを指定）
set EXCLUDED_DIR=.git;.vs

rem ログファイル名（処理結果を出力するファイル）
rem set LOG_PATH=%USERPROFILE%\Desktop\SakuraEditorGreps\grep-log.txt // 絶対パスを使用する場合
rem 相対パスを使用
set LOG_PATH=%~dp0\grep-log.txt

rem ------------------------------------------------------------

rem 文字コード (0=SJIS, 4=UTF-8, 99=自動判別)
set CODE=99

rem 検索オプション
rem    S      サブフォルダからも検索
rem    L      大文字と小文字を区別
rem    R      正規表現
rem    P      該当行を出力／未指定時は該当部分だけ出力
rem    W      単語単位で探す
rem    1|2|3  結果出力形式。1か2か3のどれかを指定します。(1=ノーマル、2=ファイル毎、3=結果のみ)
rem    F      ファイル毎最初のみ
rem    B      ベースフォルダ表示
rem    G      フォルダ毎に表示
rem    X      Grep実行後カレントディレクトリを移動しない
rem    C      (置換)クリップボードから貼り付け (sakura:2.2.0.0以降)
rem    O      (置換)バックアップ作成 (sakura:2.2.0.0以降)
rem    U      標準出力に出力し、Grep画面にデータを表示しない。コマンドラインからパイプやリダイレクトを指定することで結果を利用できます。(sakura:2.2.0.0以降)
rem    H      ヘッダ・フッタを出力しない(sakura:2.2.0.0以降)
set OPT=SPU1

rem ============================================================
rem   Grep検索 準備 (コマンドラインオプション生成)
rem ============================================================

rem ファイルパターンの先頭に!を付ける(例: !*.obj)と，そのパターンに当たるファイルをGrep対象から外します。
set EXCLUDED_FILE=!%EXCLUDED_FILE:;=;!%
rem ファイルパターンの先頭に#を付ける(例: #*.svn)と、そのパターンに当たるサブフォルダをGrep対象から外します。(sakura:2.1.0.0以降)
set EXCLUDED_DIR=#%EXCLUDED_DIR:;=;#%
set TARGET=%TARGET_FILE%;%EXCLUDED_FILE%;%EXCLUDED_DIR%

%HOMEDRIVE%
cd "%ProgramFiles(x86)%\sakura"

rem ============================================================
rem   Grep検索 開始
rem ============================================================

for /f %%f in (%~dp0.\grep-word-list.txt) do (
  sakura.exe -GREPMODE -GKEY=%%f -GFILE=%TARGET% -GFOLDER=%TARGET_PATH% -GCODE=%CODE% -GOPT:%OPT% >> %LOG_PATH%
  echo.>> %LOG_PATH%
  echo.>> %LOG_PATH%
)

rem ============================================================
rem   終了
rem ============================================================
endlocal
pause
