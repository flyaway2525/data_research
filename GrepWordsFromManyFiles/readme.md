# Grep Words from many files の使用方法
検索を行いたいルートディレクトリにbatファイルを配置し,起動する.
また,同一ディレクトリにfile_list.txtとgrep_list.txtを配置し,それぞれ検索したいファイルのパスのリスト(絶対パスでも相対パスでもよい),Grepをかけたいキーワードのリストを配置する.
同一フォルダにcsvtest.csvが生成される.
サンプルとして,既にいくつかフォルダを作成してあるため,start.batを起動すればcsvtest.csvが上書きされる.

# 注意点
出力時,自分の環境ではcsvファイルがUTF8となった.
エクセルでcsvファイルを展開すると文字化けすることが確認されている.
したがって,VSCode等で開きShiftJISで保存してからエクセルで開くことをオススメする.
また,文字化け確認用に,サンプルは左上を「タイトル」としている.


# Grepシステムの要件定義

大規模なプロジェクトで使用されているファイルとファイル内で使用されている関数の表を出したい.

縦軸をファイル名,横軸をGrep対象(関数)とする.

ファイル名は絶対パスを用いて用意されるものとする.  
 - 例 : C:\test\folderA\sampleA.txt
別途,対象ファイルリストの取得方法も検討する.  

Grep対象は"Grepを行いたいキーワード"とする.  
こちらの選定は自分ではやらないため,テキスト形式でリスト化されているものとする.

Grep検索結果をCSV形式で出したい.  

例 : jobsフォルダのstart.batを起動するとcsvtest.csvが生成され,出力される.  

jobs
 file_list.txt
  C:\test\folderA\sampleA.txt
   内容 : grep_caseA,grep_caseB,grep_caseC
  C:\test\folderA\sampleB.txt
   内容 : grep_caseA,grep_caseB
  C:\test\folderB\sampleC.txt
   内容 : grep_caseA,grep_caseC


end