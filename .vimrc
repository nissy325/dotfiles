set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8

"検索がループしない
set nowrap
"検索語句のハイライト
set hlsearch
"検索時に英大小文字の区別を無視する
set ignorecase
"検索時に全て英小文字で入力した場合のみ区別を無視する
set smartcase
"改行時に前の行のインデントを継続
set autoindent
"改行時に末尾に合わせて次のインデントを増減する
set smartindent
"カーソルが何行目の何列目に置かれているかを表示する。
set ruler
"行番号を表示
set number
"ファイル名のタブ補完する時のモードを選択
set wildmenu
"入力中のコマンドを表示する
set showcmd
"色を設定
colorscheme desert
"自動的にtextwidthを使ってtextを改行
set formatoptions=t
"一行の文字数
set textwidth=100
"インデントの幅
set shiftwidth=2
"Tabを押した時に何個分のスペースを挿入するか
set softtabstop=4
"スペースがタブに変換されず、スペースのまま保たれる
set expandtab
"何個分のスペースでタブになるか
"set tabstop=4
"行頭の前でTabを押した時shiftwidth分のスペースが挿入される
set smarttab
"swapファイルを作成しない
set noswapfile
imap <C-j> <esc>
"vimでyankしたテキストをクリップボードに格納する
set clipboard=unnamed
set backspace=indent,eol,start
call plug#begin('~/.vim/plugged')
"ここからプラグインを書く"
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
call plug#end()

nnoremap <silent><C-e> :NERDTreeToggle<CR>
"---------- indentLine
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
set list listchars=tab:\¦\ 
"----------indentline
