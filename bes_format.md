﻿# 点字データの1バイトの表現。

## .BES形式

8ビットの、左半分の4ビット(16進数の左の位)と、ミギ半分の4ビット(16進数の右の位)でルールが異なる。

左4ビットは、右端から1の点、2の点、3の点、そして4の点を表している。

たとえば:

- ⠁(1の点「あ」)は0001
- ⠃(1・2の点「い」)は0011
- ⠉(1・4の点「う」)は1001

右の4ビットは5の点と6の点を表しており、

- 1010(16進数のA)は5の点も6の点も無し
- 1011(16進数のB)は5の点
- 1100(16進数のC)は6の点
- 1101(16進数のD)は5の点と6の点を表す

また改行は

- 16進数のEF(行に収まらないので改行されたとき)
- 16進数のD0とEF(強制改行)

その他ヘッダー部分とページの境目はよくわからない。




### ユニコード点字

MacやiOSの点字ディスプレイ表示に使われるunicode点字では、左の列の上から1 2 3 7ビット目、右の列の上から4 5 6 8ビット目を表す。

漢点字の「木」は1 2 3 | 4 8ビット目が1で x8F

### .eib形式

横浜漢点字羽化の会のeib形式では、右の列の上から8 7 6 5ビット目、右の列の上から4 3 2 1ビット目を表す。

漢点字の「木」は8 7 6 | 4 1ビット目が1でxE9

### .bmt形式

KGSのbmt形式では、左の列の上から8 5 6 7ビット目|右の列の上から4 1 2 3ビット目を表す。

漢点字の「木」は8 5 6 | 4 3ビット目が1でxBC

### .ktf形式

MS-DOSの漢点字変換ソフトktconv(Vectorのサイトからダウンロード可能)の.ktf形式では

ソフトのドキュメントから引用:

--------- ここから --------
５　点字データの形式について

　作成される漢点字ファイルのデータ形式は、次のとおりです。

　１行を１ブロックとして、先頭の１バイト目がデータのバイト数です。これに続けて該当のバイト数の点字データが続きます。このブロックが行数分続き、最後に FFH で終わります。
　点字の各点とデータビットとの対応は、８点の右上から下に向かって、ビット０～ビット３、左の上から下に向かって、ビット４～ビット７に対応しています。従って、漢点字の点位置との対応は、１の点＝ｂ５、２の点＝ｂ６、３の点＝ｂ７、４の点＝ｂ１、５の点＝ｂ２、６の点＝ｂ３、始点＝ｂ４、終点＝ｂ０となっています。
------- ここまで --------
