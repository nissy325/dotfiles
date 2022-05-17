set encoding=UTF-8
set fileformats=unix,dos,mac
set fileencoding=UTF-8
set termencoding=UTF-8

"検索がループしない
set nowrap
"検索を実行する前にマッチする文字列をハイライト
set incsearch
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
set background=dark
let g:hybrid_use_iTerm_colors = 1
colorscheme hybrid
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
"gfコマンドで探索する拡張子を設定
set suffixesadd+=.rb
"カレントディレクトリからHOMEディレクトリまで遡り.tagsファイルを検索
set tags=.tags;$HOME
"新規windowを下に開く
set splitbelow
"ターミナルサイズ
set termwinsize=20x0
set mouse=a
imap <C-j> <esc>
"mapping"
noremap <Space><CR> o<ESC> 
noremap <C-w>l sh
nnoremap <silent> <C-l> : <C-u>nohlsearch<CR><C-l>
"escをjjにマッピング
inoremap <silent> jj <ESC>
"vimでyankしたテキストをクリップボードに格納する
set clipboard=unnamed
set backspace=indent,eol,start
set path+=$PWD/**
"grepで指定したディレクトリを検索しない"
set grepprg=grep\ -nr\ $*\ --exclude-dir={.git,log,tmp}\ --exclude=.tags\ /dev/null
call plug#begin('~/.vim/plugged')

"ここからプラグインを書く"
"書き方 Plug 'githubのURL'
"URLはgithub.com/より後の部分
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-surround'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-abolish'
Plug 'w0ng/vim-hybrid'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
"Plug 'ryanoasis/vim-devicons'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
"動作しないので一旦コメントアウト
"Plug 'neoclide/coc.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/neocomplete'
Plug 'vim-jp/vital.vim'
call plug#end()

nnoremap <silent><C-e> :NERDTreeToggle<CR>
"---------- indentLine
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
set list listchars=tab:\¦\ 
"----------indentline

packadd! matchit
set vb t_vb=

set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis

set tags=.tags;$HOME

".tagsファイルを自動生成する
function! s:execute_ctags() abort
  " 探すタグファイル名
  let tag_name = '.tags'
  " ディレクトリを遡り、タグファイルを探し、パス取得
  let tags_path = findfile(tag_name, '.;')
  " タグファイルパスが見つからなかった場合
  if tags_path ==# ''
    return
  endif

  " タグファイルのディレクトリパスを取得
  " `:p:h`の部分は、:h filename-modifiersで確認
  let tags_dirpath = fnamemodify(tags_path, ':p:h')
  " 見つかったタグファイルのディレクトリに移動して、ctagsをバックグラウンド実行（エラー出力破棄）
  execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
endfunction
autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby
autocmd BufNewFile,BufRead *.ruby set filetype=ruby
augroup ctags
  autocmd!
  autocmd BufWritePost * call s:execute_ctags()
augroup END

augroup ctags
  autocmd!
  autocmd BufWritePost * call s:execute_ctags()
augroup END

"ステータスバーの設定
let g:airline#extensions#default#layout = [
	\ [ 'a', 'c'],
	\ [ 'x', 'z', 'error', 'warning']
	\ ]


"fzfの設定 https://qiita.com/uji_/items/b43295006e18fe57ce57
let g:fzf_action = {
  \ 'ctrl-s': 'split' }

nnoremap <C-p> :FZFFileList<CR>
command! FZFFileList call fzf#run(fzf#wrap({
            \ 'source': 'find . -type d -name .git -prune -o ! -name .DS_Store',
            \ 'down': '40%'}))

nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Ag<CR>
nnoremap <silent> <C-]> :call fzf#vim#tags(expand('<cword>'))<CR>

let g:fzf_buffers_jump = 1

command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

"coc.vimの設定
let g:coc_global_extensions = ['coc-solargraph']

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" https://qiita.com/ykyk1218/items/ab1c89c4eb6a2f90333a
" 補完ウィンドウの設定
set completeopt=menuone

" 補完ウィンドウの設定
set completeopt=menuone

" rsenseでの自動補完機能を有効化
let g:rsenseUseOmniFunc = 1
" let g:rsenseHome = '/usr/local/lib/rsense-0.3'

" auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:auto_ctags = 1

" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

let g:neocomplcache_enable_camel_case_completion  =  1

" 最初の補完候補を選択状態にする
let g:neocomplcache_enable_auto_select = 1

" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20

" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3

" 補完の設定
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

function! s:get_gem_paths() " {{{
  if !exists('s:gem_path')
    let s:gem_path = {}
  endif

  let project_dir = s:V.path2project_directory(getcwd())

  if !has_key(s:gem_path, project_dir)
    let result = system('bundle show --paths')

    if result =~ 'Could not locate Gemfile'
      let s:gem_path[project_dir] = []
    else
      let s:gem_path[project_dir] = map(split(result, '\n'), 'v:val . "/lib"')
    endif
  endif

  return s:gem_path[project_dir]
endfunction " }}}

function! s:build_path(path) "{{{
  let path = join(map(copy(a:path), 'v:val ==# "." ? "" : v:val'), ',')
  if &g:path !~# '\v^\.%(,/%(usr|emx)/include)=,,$'
    let path = substitute(&g:path,',,$',',','') . ',' . path
  endif

  return path
endfunction"}}}

function! s:set_gem_paths() "{{{
  let gem_paths = join(s:get_gem_paths(), ',')

  if stridx(&l:path, gem_paths) == -1
    execute 'setlocal path+=' . gem_paths
  endif
endfunction"}}}

function! s:get_vital() "{{{
  if !exists('s:V')
    if exists('*neocomplete#util#get_vital')
      let s:V = neocomplete#util#get_vital()
    elseif exists('*unite#util#get_vital')
      let s:V = unite#util#get_vital()
    elseif exists('*vital#of')
      let s:V = vital#of('vital')
    else
      echomsg 'vital.vim is not found!!'
    endif
  endif

  return s:V
endfunction"}}}

function! s:load_gem_paths() "{{{
  if !empty(s:get_vital())
    call s:set_gem_paths()
  endif

  if exists('s:loaded_gem_paths')
    return
  endif
  let s:loaded_gem_paths = 1

  augroup GemPath
    autocmd!
    autocmd FileType Rakefile,ruby call s:set_gem_paths()
  augroup END
endfunction"}}}

command! LoadGem call s:load_gem_paths()
