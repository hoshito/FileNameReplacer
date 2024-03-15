# 対象のスクリプトを読み込み
. Join-Path -Path $PSScriptRoot -ChildPath "../main/FileNameReplacer.ps1"

Describe "Set-ReplaceString Tests" {
    It "文字列が置換されること" {
        $result = Set-ReplaceString "あいうえお" -OldValue "うえ" -NewValue "した"
        $result | Should -Be "あいしたお"
    }

    It "OldValueに無意味な文字列を指定したとしても変化しないこと" {
        $result = Set-ReplaceString "あいうえお" -OldValue "かきくけこ" -NewValue "した"
        $result | Should -Be "あいうえお"
    }

    It "正規表現が使えること" {
        $result = Set-ReplaceString "あいうえお" -OldValue "い.*え" -NewValue "した"
        $result | Should -Be "あしたお"
    }
}

Describe "Copy-File Tests" {
    BeforeEach {
      # テスト用のファイルとコピー先の設定
      $sourceFile = "./test/origin/testfile.txt"
      $destinationFile = "./test/result/testfile.txt"
      $sourceDir = Split-Path -Path $sourceFile
      $destinationDir = Split-Path -Path $destinationFile

      # コピー元のディレクトリがなければ作成
      if (-not (Test-Path $sourceDir)) {
          New-Item -Path $sourceDir -ItemType Directory
      }

      # テスト実行前にテスト用のファイルを作成
      if (-not (Test-Path $sourceFile)) {
          New-Item -Path $sourceFile -ItemType File -Value "This is a test file."
      }

      # コピー先のディレクトリは存在しない状態
      Remove-Item $destinationDir -ErrorAction SilentlyContinue -Recurse
    }

    Context "通常時のコピー" {
        It "コピー先のファイルと元のファイルの内容が一致すること" {
            Copy-File -TargetFilePath $sourceFile -ResultFilePath $destinationFile
            $sourceContent = Get-Content $sourceFile
            $destinationContent = Get-Content $destinationFile
            $destinationContent | Should -BeExactly $sourceContent
        }
    }

   context "destinationFileがすでに存在していた場合" {
        BeforeEach {
            New-Item -Path $destinationDir -ItemType Directory
            New-Item -Path $destinationFile -ItemType File -Value "already file"
        }

        It "コピー先のファイルと元のファイルの内容は一致しないこと(上書きされていないこと)" {
            $resultOutput = Copy-File -TargetFilePath $sourceFile -ResultFilePath $destinationFile
            $destinationContent = Get-Content $destinationFile
            $destinationContent | Should -BeExactly "already file"
            $resultOutput | Should -BeExactly "testfile.txtはコピーできませんでした"
        }
    }

    AfterEach {
        # テスト後のクリーンアップ
        Remove-Item $sourceDir -ErrorAction SilentlyContinue -Recurse
        Remove-Item $destinationDir -ErrorAction SilentlyContinue -Recurse
    }
}

