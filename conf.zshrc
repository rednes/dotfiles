# -*- sh -*-

source ${HOME}/.zshrc.local

# 日本語UTF-8
export LANG=ja_JP.UTF-8

# 通常のプロンプト %d(カレントディレクトリ) %#(#)
case ${UID} in
0)
	PROMPT="%M:%n> "
;;
*)
	PROMPT="('3')y-~~~:%# "
;;
esac
	RPROMPT="[%~]"

# コマンド履歴機能
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_all_dups # 履歴重複不可
setopt share_history # 履歴ファイル共有

# 過去ディレクトリ補完
setopt auto_pushd

# 間違ったコマンドを訂正
setopt dvorak correct

#強力な補完機能(?)らしい。よくわかんない。
autoload -U compinit
compinit

#ls alias
alias l="ls -al|lv"
alias ll="ls -l"
alias lg="ls -G"

alias rm="my_rm"

alias emacs-nox="/usr/bin/emacs"

alias convertFromAppToAlias="echo \# alias for app > ~/.zshrc.local;find /Applications -name \"*.app\" -print0 | xargs -0 -I{} makeAppAlias \"{}\" >> ~/.zshrc.local"

# Setting PATH for rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/libxslt/bin:$PATH"

# screenのタイトルをカレントディレクトリにする
if [ "$TERM" = "screen" ]; then
    chpwd () {screen -X title $(basename $(pwd))}
fi
