# サピエ図書館の.bes点字ファイルを、ユニコード点字のmarkdownテキストファイルに変換するperlスクリプト

## 何をするものか

iPhoneのアクセシビリティ機能のVoiceOverに対応する点字ディスプレイで、 [サピエ図書館](https://www.sapie.or.jp/) の**点字データ**を読みやすくするための変換スクリプトです。

「⠁⠃⠉⠯」のようなユニコード点字に変換し、それをhtml形式で表示できるようにmarkdownの記号を加えています。


		VoiceOverには画面に表示される文字(英語や日本語、韓国語など)を自動点訳して点字ディスプレイに表示する機能があります。

英語で書かれたウェブページやKindleの電子書籍などをを読む場合には大きな問題はないのですが、VoiceOverの日本語の自動点訳は間違いが多く、あまり実用的なレベルではありません。

このスクリプトは、すでに点訳された点字のデータを点字のデータとして表示するもので、言語には関係なく、6点の点字のパターンとして点字データを読むことができます。

なので、.brf形式の点字で点訳されていれば、日本語でも英語でも韓国語でも、楽譜でも、数式でも、点字で読むことができます。

たとえば点字の点のパターン⠊(2 4の点)は、文脈によって「i」、「9」、「お」、音符の「ラ」を表しています。

## 変換の仕方

Windowsのコマンドプロンプトで:

> brf2md.exe sample.brf

のように変換したい.brfファイルを指定すると、sample.brf.mdというファイルが出力されます。

brf2md.exeのショートカットを「送る」メニューに登録して変換することもできます。

Bookshareの.brfでは原本のページ番号が「--------1」、「-------2」のように連続した「-」の後にページとなっているので、この行をにmarkdownの箇条書きの記号「*」を入れています。

半角スペースが4つあるところにmarkdownの見出し記号「#」を入れています。

## ユニコード点字のmarkdownファイルの読み方

Windowsの場合はpandocで変換してブラウザで読むことができます。

iOSの場合はmarkdownファイルをhtmlとしてプレビューできるアプリが必要です。

- [無料・広告付き ‎Edhita: Text Editor on the App Store](https://itunes.apple.com/us/app/edhita-text-editor/id398896655?mt=8)
- [720円 ‎「Byword」をApp Storeで](https://itunes.apple.com/jp/app/byword/id482063361?mt=8)
- [いつの間にかByword神がかってた - /]()
- [Byword | AppleVis](https://www.applevis.com/apps/ios/productivity/byword)

## 動作環境・使用上の注意

.plのスクリプトは、Strawberry perlのポータブル版で実行できます。

または.exe版はperlが組み込まれているので単体で使用できます。

- [Strawberry Perl for Windows - Releases](http://strawberryperl.com/releases.html)

.plのスクリプトの実行にはperlのポータブル版以外に、Convert::Brailleモジュールのインストールとその修正が必要です。(.exe版には修正されたbraille.pmが入っています。)

portableshell.batを実行後、次のようにしてモジュールをインストールします。

> cpan Convert::Braille

インストール後に下記の場所にあるBraille.pmを、 [私の別のリポジトリにあるbraille.pm](https://github.com/brlat/Convert-Braille-patch) と置き換えます。

> ./perl/site/lib/Convert/Braille.pm

## 使い方

brl2utf8.exeはコマンドプロンプトで

> brl2utf8 input.brf

とすると実行できます。

または「送る」メニューに登録したり、「プログラムから開く」で実行できます。

brl2utf8.plはperlが実行できる状態で、下記のようにすると変換ができます。

> perl brl2utf8.pl input.brf

小文字NABCCの.brlファイルや.bseファイルも変換できます。ただしヘッダ部分やページの扱いなどはうまく変換できません。

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

