function fish_right_prompt --description 'Write out the right prompt'
    set_color blue
    printf '[%s]' (prompt_pwd)
    set_color normal
    printf '%s' (__fish_git_prompt)
end
