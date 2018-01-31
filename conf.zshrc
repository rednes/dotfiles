# -*- sh -*-

if [ -r ${HOME}/.zshrc.local ]; then
    source ${HOME}/.zshrc.local
fi

# Gitブランチ名をプロンプトに表示させるための設定
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

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

# 右端にカレントディレクトリ+ブランチ名表示
RPROMPT='%F{blue}[%~]%f${vcs_info_msg_0_}'

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

# 強力な補完機能(?)らしい。よくわかんない。
autoload -U compinit
compinit

#ls alias
alias l="ls -al|lv"
alias ll="ls -l"
alias lg="ls -G"

# git alias
alias gl="git log --oneline --decorate --graph --branches"

# screenのタイトルをカレントディレクトリにする
if [ "$TERM" = "screen" ]; then
    chpwd () {screen -X title $(basename $(pwd)|cut -c 1-15)}
fi

# zshのプロンプトが表示される毎に実行される関数
precmd(){
    # VersionControlSystemの情報を取ってくる
    vcs_info
}

# AWS CLI completerの読み込み
source /usr/local/bin/aws_zsh_completer.sh
