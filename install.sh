#! /bin/sh

DOTPATH=$(pwd)/dotfiles

echo "\$DOTPATH : $DOTPATH"
pushd $DOTPATH
echo "Created dotfile symbolic links."
for f in conf.??*
do
  ln -sf "$DOTPATH/$f" "$HOME/$(echo $f|cut -c 5-)"
  if [ $? -eq 0 ]; then
    printf "    %-25s -> %s\n" "\$DOTPATH/$f" "\$HOME/$(echo $f|cut -c 5-)"
  fi
done
for d in dot.??*
do
  ln -sf "$DOTPATH/$d" "$HOME/$(echo $d|cut -c 4-)"
  if [ $? -eq 0 ]; then
    printf "    %-25s -> %s\n" "\$DOTPATH/$d" "\$HOME/$(echo $d|cut -c 4-)"
  fi
done
popd
