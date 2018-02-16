"括弧の対応
set showmatch
"行番号をつける
set number
"自動インデント
set autoindent
"構文の色づけ
syntax on
"タブ入力を複数の空白入力に置き換える
set expandtab
"ファイルブラウザにどのディレクトリを使うかを指定する
set browsedir=current
"検索結果をハイライトする
set hlsearch
"検索で、大文字小文字を区別しない。
set ignorecase
"ステータスラインを表示するウィンドウを設定する
"set laststatus=2
"カーソルが何行目の何列目に置かれているかを表示する
set ruler
"現在のモードを表示する
set showmode
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"アンドゥ可能な変更の最大値
set undolevels=1000
"補完候補を表示する
set wildmenu
"タブ、空白、改行の可視化
set list
set listchars=tab:>.,trail:✗,eol:↲,extends:>,precedes:<,nbsp:%
"全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

