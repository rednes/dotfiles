#! /bin/sh

# このスクリプトのあるディレクトリを DOTPATH として設定する
# どのディレクトリから実行しても正しく動作するよう cd ではなく pwd を使う
DOTPATH=$(cd "$(dirname "$0")" && pwd)

echo "\$DOTPATH : $DOTPATH"
cd $DOTPATH

# conf.* ファイルを ~/.* にシンボリックリンクする
# 例: conf.zshrc -> ~/.zshrc (先頭の "conf" 4文字を除去)
echo "Created dotfile symbolic links."
for f in conf.??*
do
  ln -sf "$DOTPATH/$f" "$HOME/$(echo $f|cut -c 5-)"
  if [ $? -eq 0 ]; then
    printf "    %-25s -> %s\n" "\$DOTPATH/$f" "\$HOME/$(echo $f|cut -c 5-)"
  fi
done

# dot.* ディレクトリを ~/. にシンボリックリンクする
# 例: dot.config -> ~/.config (先頭の "dot" 3文字を除去)
# -n オプションでリンク先がディレクトリでも正しく上書きできる
for d in dot.??*
do
  ln -sfn "$DOTPATH/$d" "$HOME/$(echo $d|cut -c 4-)"
  if [ $? -eq 0 ]; then
    printf "    %-25s -> %s\n" "\$DOTPATH/$d" "\$HOME/$(echo $d|cut -c 4-)"
  fi
done
