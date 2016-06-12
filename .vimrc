"
" Vi互換モードをオフ（Vimの拡張機能を有効）
set nocompatible

" ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype indent plugin on

" 文字コード
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

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


" vsplit 高速化
if has("vim_starting") && !has('gui_running') && has('vertsplit')
  function! EnableVsplitMode()
    " enable origin mode and left/right margins
    let &t_CS = "y"
    let &t_ti = &t_ti . "\e[?6;69h"
    let &t_te = "\e[?6;69l\e[999H" . &t_te
    let &t_CV = "\e[%i%p1%d;%p2%ds"
    call writefile([ "\e[?6;69h" ], "/dev/tty", "a")
  endfunction
endif


" CTags
nmap <C-]> g<C-]>

" QuickFix
autocmd QuickFixCmdPost *grep*,make cwindow

" Git
autocmd FileType git :setlocal foldlevel=99

"------------------------------------------------------------
" set filetype
"------------------------------------------------------------
au BufRead,BufNewFile *.md   set filetype=markdown
au BufRead,BufNewFile *.volt set filetype=htmldjango
au BufRead,BufNewFile *.tpl  set filetype=htmldjango


" for GoLang
set rtp+=$GOROOT/misc/vim
set rtp+=$HOME/go/vendor/src/github.com/nsf/gocode/vim

autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4 completeopt=menu,preview

" for Haskell
autocmd BufNewFile,BufRead *.hs set expandtab tabstop=4 shiftwidth=4 completeopt=menu,preview


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
  set nocompatible
endif

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" プラグインリストを収めた TOML ファイル
" 予め TOML ファイル（後述）を用意しておく
let g:rc_dir    = expand('~/.vim/rc')
let s:toml      = g:rc_dir . '/dein.toml'
let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

" 設定開始
if dein#load_state(s:dein_dir)

  " 第二引数に toml ファイルを追加しておく
  " toml に変更があった場合にキャッシュの自動削除が動くようになる。
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml, s:lazy_toml])

  " プラグイン読み込み＆キャッシュ作成
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" カラースキーム
:set background=dark
colorscheme hybrid
