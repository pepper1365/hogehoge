colorscheme default

if has('win32')
    :let $VIMDIR = '~/.vimfiles'
else
    :let $VIMDIR = '~/.vim'
endif

"""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""{{{
" Vi互換オフ
set nocompatible

" 初期ディレクトリをバッファファイル位置
set browsedir=buffer
" カレントディレクトリを追う
set autochdir
" swap directory
set directory=~/swap,/var/tmp,/tmp
" backupdir
set backupdir=~/tmp,/var/tmp,/tmp

" クリップボード
set clipboard+=autoselect
set clipboard+=unnamed

" 外部で編集されたら自動で読みなおす
set autoread

" 行をまたいで移動する
set whichwrap=b,s,h,l,<,>,[,]

" BackSpaceの挙動
set backspace=indent,start,eol

" インクリメンタルサーチ
set incsearch

" 検索で大文字含む場合のみ大小区別
set smartcase

" 補完モード
set wildmode=longest,list,full

" 単語の途中で表示を折らない
set linebreak

" シンタックスハイライトON
syntax on


""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""
" Preference
""""""""""""""""""""""""""""""""""""{{{
" appearance
""""""""""""""""""""""""""""""""""""{{{
set showmatch
if !has('win32')
    set guifont=Monospace\ 12
else
    set guifont=Consolas:h9,Lucida_Console:h9:w5
    set guifontwide=MS_Gothic:h9
    set ambiwidth=double
endif
set list                    "タブ文字可視化
set listchars=eol:$,tab:>.,trail:_,extends:\
                            "listの文字セット
set number                  "行番号表示
""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""
" encoding
""""""""""""""""""""""""""""""""""""{{{
set encoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp

""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""
" status line
""""""""""""""""""""""""""""""""""""{{{
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END
""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""
" indent
""""""""""""""""""""""""""""""""""""{{{
set nosmartindent
set autoindent
set softtabstop=4
set shiftwidth=4
set expandtab

""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""
" IME
""""""""""""""""""""""""""""""""""""{{{
if has('win32')
    set iminsert=0
    set imsearch=0
    inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
    nnoremap / :set imsearch=0<CR>/
    nnoremap ? :set imsearch=0<CR>?
endif

""""""""""""""""""""""""""""""""""""}}}

""""""""""""""""""""""""""""""""""""
" key mapping
""""""""""""""""""""""""""""""""""""{{{
"F2でバッファ次
map <silent> <F2> :bp<cr>
"F3でバッファ前
map <silent> <F3> :bn<cr>
"F5でバッファ一覧
nmap <F5> :ls<cr>:buf

"複数キーのコマンドのタイムアウト時間
set timeoutlen=600

"空行のインデントを勝手に消さない
nnoremap o oX<C-h>
nnoremap O OX<C-h>
inoremap <CR> <CR>X<C-h>

"ビジュアルモードで連続インデント
vnoremap < <gv
vnoremap > >gv

" 行の途中で段下げ
nnoremap <Space>o i<CR>\<Esc>
" 1行挿入

" vimrc
"""""""""""""""""""""{{{
" vimrc編集
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg :<C-u>edit $MYGVIMRC<CR>
" vimrc反映
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| 
            \source $MYGVIMRC \| endif <CR>

" Set augroup.
augroup AutoReload
    autocmd!
augroup END

"endif
if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd AutoReload BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " .vimrcの再読込時にも色が変化するようにする
    autocmd AutoReload BufWritePost $MYVIMRC source $MYVIMRC | 
                \if has('gui_running') | source $MYGVIMRC  
    autocmd AutoReload BufWritePost $MYGVIMRC if has('gui_running') | 
                \source $MYGVIMRC
endif
"""""""""""""""""""""}}}
""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""
" etc.
""""""""""""""""""""""""""""""""""""{{{
" 折り畳みの保存設定"{{{
set viewdir=~/tmp/view
augroup Folding
autocmd!
autocmd BufWritePost * 
            \if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
autocmd BufRead * 
            \if expand('%') != '' && &buftype !~ 'nofile' | loadview | endif
autocmd BufWritePost * mkview
autocmd BufRead * loadview
augroup END
set viewoptions-=options    " Don't save options.
""}}}


"ヘルプ設定
set helplang=ja


""""""""""""""""""""""""""""""""""""}}}"}}}

""""""""""""""""""""""""""""""""""
" NeoBundle
""""""""""""""""""""""""""""""""""
" preset"{{{
filetype off

if has('vim_starting')
    set rtp+=$VIMDIR/bundle/neobundle.vim/
endif
call neobundle#rc(expand($VIMDIR . '/bundle/'))
"" Plugin list
"
"" プロキシ環境用の設定ファイルを読み込む
"if filereadable(expand('~/.vimrc.local'))
""  execute 'source' expand('~/.vimrc.local')
"    let g:neobundle#types#git#default_protocol='https'
"endif
""}}}

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/echodoc'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'sakuraiyuta/commentout.vim'

"NeoBundle 'mattn/zencoding-vim'
"NeoBundle 'scrooloose/syntastic'
"NeoBundle 'basyura/jslint.vim'
"NeoBundle 'jelera/vim-javascript-syntax'
"NeoBundle 'pangloss/vim-javascript'

"NeoBundle 'localrc.vim'
"NeoBundle 'nathanaelkane/vim-indent-guides'

"NeoBundleDocs

" post-process"{{{
filetype plugin indent on
" Installation check.
 if neobundle#exists_not_installed_bundles()
   echomsg 'Not installed bundles : ' .
         \ string(neobundle#get_not_installed_bundle_names())
   echomsg 'Please execute ":NeoBundleInstall"'
   "finish
 endif
""}}}

""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""
" Indent Guides"{{{
                
let g:indent_guides_enable_on_vim_startup = 1 "起動時ON
let g:indent_guides_auto_colors = 0 "自動的に色付けするのはストップ
let g:indent_guides_color_change_percent = 10 "色の変化の幅
autocmd VimEnter,Colorscheme * 
            \:hi IndentGuidesOdd guibg=black ctermbg=4 "インデントの色
autocmd VimEnter,Colorscheme * 
            \:hi IndentGuidesEven guibg=darkgrey ctermbg=5 "二段階目のインデントの色
let g:indent_guides_guide_size = 2 "インデントの色付け幅
                
""}}}

" Pydiction"{{{
autocmd FileType python let g:pydiction_location = 
            \'$VIMDIR/pydiction/complete-dict'
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent 
            \cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl expandtab tabstop=8 shiftwidth=4 softtabstop=4
""}}}

" VimFiler"{{{
let g:vimfiler_as_default_explorer = 1
""}}}

" neocomplcache"{{{
let g:neocomplcache_enable_at_startup = 1
""}}}

" syntastic"{{{
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
""}}}

" jslint"{{{
augroup MyGroup
autocmd! MyGroup
autocmd FileType javascript call s:javascript_filetype_settings()
augroup END

function! s:javascript_filetype_settings()
autocmd BufLeave     <buffer> call jslint#clear()
autocmd BufWritePost <buffer> call jslint#check()
autocmd CursorMoved  <buffer> call jslint#message()
endfunction
""}}}

" javascript"{{{
au FileType javascript call JavascriptFole()
" "}}}
""""""""""""""""""""""""""""""""""

" vim: set foldmethod=marker :
