""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
   set nocompatible
endif

"-----------------------------------------------------------
" load defaults.vim
"-----------------------------------------------------------
source $VIMRUNTIME/defaults.vim


"-----------------------------------------------------------
" encoding
"-----------------------------------------------------------
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis


"-----------------------------------------------------------
" display
"-----------------------------------------------------------
" 行番号を表示
set number

" ビープの代わりにビジュアルベル（画面フラッシュ）を使う
set visualbell

"タブ入力を複数の空白入力に置き換える
set expandtab
"タブ文字が占める幅
set tabstop=4
set shiftwidth=4
set softtabstop=4
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\s\+$//ge

" コメント文字列
set comments+=sr:/**

" 右、下に分割して開く
set splitright
set splitbelow

" 特殊文字を表示
set lcs=tab:>.,trail:_,extends:>,precedes:<,nbsp:%
set list

" 入力時に対応する括弧やブレースを表示する
set showmatch
set matchtime=1

" カーソルがのったときに対応する括弧をハイライトしない
let loaded_matchparen=1


"-----------------------------------------------------------
" buffer
"-----------------------------------------------------------
" バッファを保存しなくても他のバッファを表示できるようにする
set hidden

" バッファが変更されているとき、コマンドをエラーにするのでなく、保存するかどうか確認を求める
set confirm

" 他で書き換えられたら自動で読み直す
set autoread


"-----------------------------------------------------------
" key map
"-----------------------------------------------------------
" キーコードはすぐにタイムアウト。マッピングはタイムアウトしない
set notimeout ttimeout ttimeoutlen=200

" 自動的に閉じ括弧を入力
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


"-----------------------------------------------------------
" auto command
"-----------------------------------------------------------
augroup MyAutoCmd
  autocmd!
augroup END

" QuickFix
autocmd QuickFixCmdPost *grep*,make cwindow


"-----------------------------------------------------------
" misc
"-----------------------------------------------------------
" swapファイルとbackupファイル
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp


"------------------------------------------------------------
" Dein
"------------------------------------------------------------
" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME

let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if !isdirectory(s:dein_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

let &runtimepath = &runtimepath . "," . s:dein_repo_dir

" プラグインリストを収めた TOML ファイル
let s:rc_dir    = s:config_home . '/vim/'
let s:toml      = s:rc_dir . 'dein.toml'
let s:lazy_toml = s:rc_dir . 'dein_lazy.toml'

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

  " 不足プラグインの自動インストール
  if dein#check_install()
    call dein#install()
  endif

  filetype plugin indent on
  syntax enable
  set t_ut=
  set t_Co=256

endif

" Dein のヘルプを表示できるように
silent! execute 'helptags' s:dein_repo_dir . '/doc/'

" }}}

