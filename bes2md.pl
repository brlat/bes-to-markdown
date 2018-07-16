# .bes形式の点字データをユニコード点字のmarkdownテキストファイルに変換
# 使い方:
# perl bes2md.pl input.bes
# input.bes.md というファイル名で出力
# または、perl のppコマンドで.exe化したものの場合:
# bes2md.exe input.bes

$in = "$ARGV[0]";
die "usage1: perl bes2md.pl input.bes\nusage2: bes2md.exe input.bes\n" unless $in;

$out = "$in" . ".md";

open(IN, "<$in");

binmode(IN);

open(OUT, ">$out");

# 最初の1028バイトのヘッダー部分を削除
$header_byte = 1028;
read(IN,$b,$header_byte);

# ますあけを数えるための変数
$number_of_space = 0;

while (read(IN,$b,1)) {

$bytedata = unpack("h2", $b);


# マスあけ
if($bytedata =~ s/0a/⠀/){
# ますあけが連続している数を数える
$number_of_space++;
}else{
# ますあけの連続をキャンセルする
$number_of_space = 0;

# 行替え
$bytedata =~ s/ef/\n\n/;
# ページが変わるところにあるよくわからない部分を削除
$bytedata =~ s/.[^abcd]//;
# 強制改行だと思うが、efの改行と重複するので、削除
$bytedata =~ s/d0//;


# ルイ・ブライユの点字配列表の順に
$bytedata =~ s/1a/⠁/;
$bytedata =~ s/3a/⠃/;
$bytedata =~ s/9a/⠉/;
$bytedata =~ s/9b/⠙/;
$bytedata =~ s/1b/⠑/;
$bytedata =~ s/ba/⠋/;
$bytedata =~ s/bb/⠛/;
$bytedata =~ s/3b/⠓/;
$bytedata =~ s/aa/⠊/;
$bytedata =~ s/ab/⠚/;

$bytedata =~ s/5a/⠅/;
$bytedata =~ s/7a/⠇/;
$bytedata =~ s/da/⠍/;
$bytedata =~ s/db/⠝/;
$bytedata =~ s/5b/⠕/;
$bytedata =~ s/fa/⠏/;
$bytedata =~ s/fb/⠟/;
$bytedata =~ s/7b/⠗/;
$bytedata =~ s/ea/⠎/;
$bytedata =~ s/eb/⠞/;

$bytedata =~ s/5c/⠥/;
$bytedata =~ s/7c/⠧/;
$bytedata =~ s/dc/⠭/;
$bytedata =~ s/dd/⠽/;
$bytedata =~ s/5d/⠵/;
$bytedata =~ s/fc/⠯/;
$bytedata =~ s/fd/⠿/;
$bytedata =~ s/7d/⠷/;
$bytedata =~ s/ec/⠮/;
$bytedata =~ s/ed/⠾/;

$bytedata =~ s/1c/⠡/;
$bytedata =~ s/3c/⠣/;
$bytedata =~ s/9c/⠩/;
$bytedata =~ s/9d/⠹/;
$bytedata =~ s/1d/⠱/;
$bytedata =~ s/bc/⠫/;
$bytedata =~ s/bd/⠻/;
$bytedata =~ s/3d/⠳/;
$bytedata =~ s/ac/⠪/;
$bytedata =~ s/ad/⠺/;

$bytedata =~ s/2a/⠂/;
$bytedata =~ s/6a/⠆/;
$bytedata =~ s/2b/⠒/;
$bytedata =~ s/2d/⠲/;
$bytedata =~ s/2c/⠢/;
$bytedata =~ s/6b/⠖/;
$bytedata =~ s/6d/⠶/;
$bytedata =~ s/6c/⠦/;
$bytedata =~ s/4b/⠔/;
$bytedata =~ s/4d/⠴/;

$bytedata =~ s/ca/⠌/;
$bytedata =~ s/cc/⠬/;
$bytedata =~ s/cb/⠜/;
$bytedata =~ s/cd/⠼/;
$bytedata =~ s/4a/⠄/;
$bytedata =~ s/4c/⠤/;

$bytedata =~ s/8a/⠈/;
$bytedata =~ s/8b/⠘/;
$bytedata =~ s/8d/⠸/;
$bytedata =~ s/0b/⠐/;
$bytedata =~ s/8c/⠨/;
$bytedata =~ s/0d/⠰/;
$bytedata =~ s/0c/⠠/;
}

# ますあけ連続4つあったときに、markdownの見出し「#」をつける
if($number_of_space == 4){
print OUT ("\n\n# ⠀⠀⠀⠀");
}

print OUT ("$bytedata");

}

close(IN);
close(OUT);
exit;
