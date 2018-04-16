# -*- sh -*-

# if文用論理演算子
# 演算子        意味
# -d ファイル名 ファイル名がディレクトリであれば真
# -f ファイル名 ファイルであれば真
# -e ファイル名 ファイルがあれば真
# -L ファイル名 シンボリックリンクであれば真
# -r ファイル名 読み取り可能であれば真
# -w ファイル名 書き込み可能であれば真
# -x ファイル名 実行可能であれば真
# -s ファイル名 ファイルが存在し、空でなければ真
# -S ファイル名 ファイルがソケットならば真


# 強力な補完機能(?)らしい。よくわかんない。
autoload -U compinit
compinit

if [ -f ${HOME}/.zshrc.local ]; then
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

#ls alias
alias l="ls -al|lv"
alias ll="ls -l"
alias lg="ls -G"

# git alias
alias gl="git log --oneline --decorate --graph --branches --tags --remotes"

# docker alias
if [ -e /Applications/Docker.app ]; then
    unalias docker
    alias docker-app="open -a /Applications/Docker.app"
fi

# python alias
if [ -e /Applications/LibreOffice.app ]; then
    unalias python
fi

# emacs alias
if [ -e /Applications/Emacs.app ]; then
    alias emacs-nox="/usr/bin/emacs"
fi

# vim alias
alias vi=vim

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

# added by travis gem
if [ -f ~/.travis/travis.sh ]; then
   source ~/.travis/travis.sh
fi

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# fzf settings
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
