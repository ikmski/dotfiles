"
" Vi互換モードをオフ（Vimの拡張機能を有効）
set nocompatible

" ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype indent plugin on

" Enable syntax highlighting
" 色づけをオン
syntax on

set t_ut=
set t_Co=256

" バッファを保存しなくても他のバッファを表示できるようにする
set hidden

" コマンドライン補完を便利に
set wildmenu

" 他で書き換えられたら自動で読み直す
set autoread

" タイプ途中のコマンドを画面最下行に表示
set showcmd

" 検索語を強調表示（<C-L>を押すと現在の強調表示を解除する）
set hlsearch

" オートインデント、改行、インサートモード開始直後にバックスペースキーで
" 削除できるようにする。
set backspace=indent,eol,start

" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" 画面最下行にルーラーを表示する
set ruler

" ステータスラインを常に表示する
set laststatus=1

" バッファが変更されているとき、コマンドをエラーにするのでなく、保存する
" かどうか確認を求める
set confirm

" ビープの代わりにビジュアルベル（画面フラッシュ）を使う
set visualbell

" そしてビジュアルベルも無効化する
set t_vb=

" 全モードでマウスを有効化
"set mouse=a

" コマンドラインの高さを2行に
set cmdheight=2

" 行番号を表示
set number

" キーコードはすぐにタイムアウト。マッピングはタイムアウトしない
set notimeout ttimeout ttimeoutlen=200

" オートインデント
set autoindent
"タブ入力を複数の空白入力に置き換える
set expandtab
"画面上でタブ文字が占める幅
set tabstop=4
"自動インデントでずれる幅
set shiftwidth=4
"連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
"改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent


" コメント文字列
set comments+=sr:/**


" 右、下に分割して開く
set splitright
set splitbelow


" swapファイルとbackupファイル
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

" 特殊文字を表示
set lcs=tab:>.,trail:_,extends:\
set list
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/

" 入力時に対応する括弧やブレースを表示する
set showmatch
set matchtime=1

" カーソルがのったときに対応する括弧をハイライトしない
let loaded_matchparen=1

" 自動的に閉じ括弧を入力
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

inoremap ' ''<LEFT>
inoremap " ""<LEFT>

" バッファの移動
" 一つ前のバッファを開く
nnoremap <silent>bp :bprevious<CR>
" 次のバッファを開く
nnoremap <silent>bn :bnext<CR>
" 直前のバッファを開く
nnoremap <silent>bb :b#<CR>


" 保存時にtabを2スペースに変換する
autocmd BufWritePre * :%s/\s\+$//ge

" CTags
nmap <C-]> g<C-]>

" QuickFix
autocmd QuickFixCmdPost *grep*,make cwindow

" Git
autocmd FileType git :setlocal foldlevel=99

"------------------------------------------------------------
" neobundle
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" add plugins
" GitHubリポジトリにあるプラグインを利用する
" " --> NeoBundle 'USER/REPOSITORY-NAME'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimproc', {
    \   'build' : {
    \       'windows' : 'tools\\update-dll-mingw',
    \       'mac'     : 'make -f make_mac.mak',
    \       'unix'    : 'make -f make_unix.mak',
    \   },
    \ }
NeoBundle 'majutsushi/tagbar'

" Git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'cohama/agit.vim'

" HTML
NeoBundle 'xmledit'

" Go
NeoBundle 'dgryski/vim-godef'
NeoBundle 'vim-jp/vim-go-extra'
" vim-ft-goは最新版のvimを使えない場合のみ
NeoBundle 'google/vim-ft-go'

" Haskell
NeoBundle 'dag/vim2hs'

" Markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

"let g:previm_open_cmd = 'open -a Chrome'


" カラースキーム
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'modess/vim-phpcolors'
NeoBundle 'michalbachowski/vim-wombat256mod'


call neobundle#end()

filetype plugin on
filetype indent on
NeoBundleCheck

"------------------------------------------------------------
" set filetype
"------------------------------------------------------------
au BufRead,BufNewFile *.md   set filetype=markdown
au BufRead,BufNewFile *.volt set filetype=htmldjango
au BufRead,BufNewFile *.tpl  set filetype=htmldjango


"------------------------------------------------------------
" unite
" 入力モードで開始する
"let g:unite_enable_start_insert=1

"------------------------------------------------------------
" neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"------------------------------------------------------------
" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" TABで候補を遅れるようにする
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

"------------------------------------------------------------
" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_edit_action = 'open'

call unite#custom_default_action('source/bookmark/directory' , 'vimfiler')


"------------------------------------------------------------
" xmledit
let xml_tag_syntax_prefixes = 'html\|xml\|xsl\|docbk\|smarty'


"------------------------------------------------------------
" キーマップ
" Unite
" ブックマーク一覧
nmap <silent> ,uk :<C-u>Unite bookmark<CR>
" バッファ一覧
nmap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nmap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nmap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nmap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nmap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nmap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" アウトライン
nmap <silent> ,uo :<C-u>Unite outline<CR>

" VimFiler
nmap <silent>,fi :<C-u>VimFiler<CR>
nmap <silent>,fs :<C-u>VimFiler -split -simple -winwidth=30 -no-quit<CR>

" ウィンドウを新規タブで開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
au FileType unite inoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
au FileType vimfiler nnoremap <silent> <buffer> <expr> <C-t> vimfiler#do_action('tabopen')
au FileType vimfiler inoremap <silent> <buffer> <expr> <C-t> vimfiler#do_action('tabopen')
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType vimfiler nnoremap <silent> <buffer> <expr> <C-j> vimfiler#do_action('split')
au FileType vimfiler inoremap <silent> <buffer> <expr> <C-j> vimfiler#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType vimfiler nnoremap <silent> <buffer> <expr> <C-l> vimfiler#do_action('vsplit')
au FileType vimfiler inoremap <silent> <buffer> <expr> <C-l> vimfiler#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
au FileType vimfiler nnoremap <silent> <buffer> <ESC><ESC> q
au FileType vimfiler inoremap <silent> <buffer> <ESC><ESC> <ESC>q
"

" for GoLang
set rtp+=$GOROOT/misc/vim
set rtp+=$HOME/go/vendor/src/github.com/nsf/gocode/vim

autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4 completeopt=menu,preview

" for Haskell
autocmd BufNewFile,BufRead *.hs set expandtab tabstop=4 shiftwidth=4 completeopt=menu,preview


" デフォルトカラースキーム
:set background=dark
"colorscheme default
colorscheme hybrid
"colorscheme molokai
"colorscheme wombat256mod
"colorscheme jellybeans
