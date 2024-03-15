# 対象のスクリプトを読み込み
. "./main/FileNameReplacer.ps1"

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
