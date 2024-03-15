# 対象のスクリプトを読み込み
. "./FileNameReplacer.ps1"

# テストケースの定義
Describe "Add-Numbers Tests" {
    It "adds two numbers correctly" {
        $result = Add-Numbers -Number1 5 -Number2 3
        $result | Should -Be 8
    }
}