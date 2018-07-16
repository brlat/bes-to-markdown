# サピエ図書館の.bes点字ファイルを、ユニコード点字のmarkdownテキストファイルに変換するperlスクリプト

## 何をするものか

iPhoneのアクセシビリティ機能のVoiceOverに対応する点字ディスプレイで、 [サピエ図書館](https://www.sapie.or.jp/) の**点字データ**を読みやすくするための変換スクリプトです。

「⠁⠃⠉⠯」のようなユニコード点字に変換し、それをhtml形式で表示できるようにmarkdownの記号を加えています。

iOSのブラウザでhtmlファイルを開くと、VoiceOverのローター機能で、指の上下フリックで見出し行を簡単に移動することができます。

これを利用して点字データのページ行や４マスのますあけがあるところにhtmlの見出しタグを入れて、ページをめくったり、見出し位置へ移動しやすくなります。

htmlに直接変換せずに、markdownのテキストファイルに変換する理由は、htmlより内容の修正が簡単で管理しやすいからです。

htmlに変換してしまうと、ユニコードの点字データ以外に<p>や<h1>などタグが入ってきますが、markdownでは空白行で段落、#で見出し、*で箇条書きの記号が行頭に来るだけなので、ほぼテキストファイルのままです。

## 変換の仕方

Windowsのコマンドプロンプトで:

> bes2md.exe sample.bes

のように変換したい.besファイルを指定すると、sample.bes.mdというファイルが出力されます。

bes2md.exeのショートカットを「送る」メニューに登録して変換することもできます。

半角スペースが4つあるところにmarkdownの見出し記号「#」を入れています。

## ユニコード点字のmarkdownファイルの読み方

Windowsの場合はpandocで変換してブラウザで読むことができます。

iOSの場合はmarkdownファイルをhtmlとしてプレビューできるアプリが必要です。

たとえば次のようなアプリがVoiceOverで使いやすいです。

- [無料・広告付き ‎Edhita: Text Editor on the App Store](https://itunes.apple.com/us/app/edhita-text-editor/id398896655?mt=8)
- [720円 ‎「Byword」をApp Storeで](https://itunes.apple.com/jp/app/byword/id482063361?mt=8)
- [いつの間にかByword神がかってた - /]()
- [Byword | AppleVis](https://www.applevis.com/apps/ios/productivity/byword)

ユニコード点字をVoiceOverで点字ディスプレイに表示するには、VoiceOverのローターで言語を英語、8点点字に切り替える必要があります。

## 動作環境・使用上の注意

.plのスクリプトは、Strawberry perlのポータブル版で実行できます。

または.exe版はperlが組み込まれているので単体で使用でき、「送る」メニューに登録したり、「プログラムから開く」で実行できます。

- [Strawberry Perl for Windows - Releases](http://strawberryperl.com/releases.html)

bes2md.plはperlが実行できる状態で、下記のようにすると変換ができます。

> perl bes2md.pl sample.bes

## PAR::Packerモジュールで.exeファイルに変換

perlが実行できる状態で、次のようにしてモジュールをインストール。-forceオプションをつけないとエラーが出る。

> cpanm PAR::Packer --force

これで.plスクリプトを.exeに変換するppコマンドが使えるようになる。

次のようにして変換を実行する。-uオプションをつけないとutf8_heavy.plが読み込めないというエラーが出ます。下記のようにしてperlスクリプトを.exeに変換しました。

> pp -u -o brl2utf8.exe brl2utf8.pl

このようにしてできた.exeファイルは、実行する度にテンポラリファイルが書き込まれるので、定期的に手動で削除しないと一時ファイルが増え続けてしまう。

一時ファイルが保存される場所は:

> C:/Users/アカウント名/appdata/local/temp/par-4e4543

## 参考サイト

- [Bug #119856 for PAR-Packer: pp-generated exe cannot locate utf8_heavy.pl](https://rt.cpan.org/Public/Bug/Display.html?id=119856)
- [Strawberry Perl(Portable)でPerlスクリプトのexeファイル化 | ビビビッ](https://vivibit.net/strawberryperl2exe/)

## 著作権

perlと同じです。

