# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showcolorhints 'yes'

#ls alias
alias l="ls -al|lv"
alias ll="ls -l"
alias lg="ls -G"

# git alias
alias gl="git log --oneline --decorate --graph --branches --tags --remotes"

if test -r ~/.fishrc.local
   source ~/.fishrc.local
end

# autojump setting
if test -r /usr/local/share/autojump/autojump.fish
    source /usr/local/share/autojump/autojump.fish
end
