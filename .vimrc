""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-----------------------------------------------------------
" defaults
"-----------------------------------------------------------
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set mouse=

set autoindent
set autoread
set complete=.,w,b,u,t
set formatoptions=tcq
set hlsearch
set langnoremap
set laststatus=2
set tags=./tags;,tags
set ttyfast

set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

set t_ut=
set t_Co=256

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

" コメント文字列
set comments+=sr:/**

" 右、下に分割して開く
set splitright
set splitbelow

" 特殊文字を表示
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%
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
" completion
"-----------------------------------------------------------
set completeopt=menuone,longest,preview
set dictionary=~/.config/vim/dict/words " https://github.com/first20hours/google-10000-english/blob/master/google-10000-english-usa.txt
let s:compl_key_dict = {
      \ char2nr("\<C-l>"): "\<C-x>\<C-l>",
      \ char2nr("\<C-n>"): "\<C-x>\<C-n>",
      \ char2nr("\<C-p>"): "\<C-x>\<C-p>",
      \ char2nr("\<C-k>"): "\<C-x>\<C-k>",
      \ char2nr("\<C-t>"): "\<C-x>\<C-t>",
      \ char2nr("\<C-i>"): "\<C-x>\<C-i>",
      \ char2nr("\<C-]>"): "\<C-x>\<C-]>",
      \ char2nr("\<C-f>"): "\<C-x>\<C-f>",
      \ char2nr("\<C-d>"): "\<C-x>\<C-d>",
      \ char2nr("\<C-v>"): "\<C-x>\<C-v>",
      \ char2nr("\<C-u>"): "\<C-x>\<C-u>",
      \ char2nr("\<C-o>"): "\<C-x>\<C-o>",
      \ char2nr('s'): "\<C-x>s",
      \ char2nr("\<C-s>"): "\<C-x>s"
      \}
" 表示メッセージ
let s:hint_i_ctrl_x_msg = join([
      \ '<C-l>: While lines',
      \ '<C-n>: keywords in the current file',
      \ "<C-k>: keywords in 'dictionary'",
      \ "<C-t>: keywords in 'thesaurus'",
      \ '<C-i>: keywords in the current and included files',
      \ '<C-]>: tags',
      \ '<C-f>: file names',
      \ '<C-d>: definitions or macros',
      \ '<C-v>: Vim command-line',
      \ "<C-u>: User defined completion ('completefunc')",
      \ "<C-o>: omni completion ('omnifunc')",
      \ "s: Spelling suggestions ('spell')"
      \], "\n")
function! s:hint_i_ctrl_x() abort
  echo s:hint_i_ctrl_x_msg
  let c = getchar()
  return get(s:compl_key_dict, c, nr2char(c))
endfunction
inoremap <expr> <C-x>  <SID>hint_i_ctrl_x()

"-----------------------------------------------------------
" auto command
"-----------------------------------------------------------
augroup MyAutoCmd
  autocmd!
augroup END

"------------------------------------------------------------
" vim-plug
"------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
nnoremap <silent> ,ub :<C-u>Unite buffer<CR> " バッファ一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir file -buffer-name=files<CR> " ファイル一覧
nnoremap <silent> ,uo :<C-u>Unite outline<CR> " アウトライン
nnoremap <silent> ,um :<C-u>Unite file_mru<CR> " 最近使用したファイル一覧
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR> " ヤンク一覧
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR> " 常用セット

" snippet
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Filer
Plug 'cocopon/vaffle.vim'
nnoremap <silent> ,fi :<C-u>Vaffle %:p:h<CR>

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

let g:fzf_layout = { 'up': '~100%' }
command!      -bang -nargs=? -complete=dir    FZFiles   call fzf#vim#gitfiles(<q-args>, {'options' : '--reverse'}, <bang>0)
command! -bar -bang -nargs=? -complete=buffer FZBuffers call fzf#vim#buffers(<q-args>, {'options' : '--reverse'}, <bang>0)

command! -bang -nargs=* Pt
    \ call fzf#vim#grep(
    \   'pt --column --ignore=.git --ignore=tags --global-gitignore '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview({ 'dir': s:find_git_root() }),
    \   <bang>0)

function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

nnoremap <silent> ,ff :<C-u>FZFiles<CR>
nnoremap <silent> ,fb :<C-u>FZBuffers<CR>

" Git
Plug 'tpope/vim-fugitive'
Plug 'cohama/agit.vim'

" Markdown
Plug 'tpope/vim-markdown'
Plug 'previm/previm'
Plug 'tyru/open-browser.vim'
Plug 'aklt/plantuml-syntax'

" Syntax Check
Plug 'editorconfig/editorconfig-vim'
Plug 'ikmski/astyle-vim'
Plug 'ikmski/clang-format-vim'
"Plug '~/develop/ikmski/clang-format-vim'
let g:clang_format_style_type = ""
let g:clang_format_style = {
\   'BasedOnStyle': 'Google',
\   'IndentWidth': 4,
\   'AccessModifierOffset': -3,
\   'AllowShortFunctionsOnASingleLine': 'InlineOnly',
\   'AllowShortLambdasOnASingleLine': 'Empty',
\   'ConstructorInitializerAllOnOneLineOrOnePerLine': v:false,
\   'ConstructorInitializerIndentWidth': 0,
\   'BreakConstructorInitializers': 'BeforeComma',
\   'BreakBeforeBraces': 'Mozilla',
\}

""Plug 'w0rp/ale'
""let g:ale_sign_column_always = 1
""let g:ale_linters = {
""\   'cpp': ['clangd'],
""\   'cs':  ['OmniSharp'],
""\   'go':  ['gopls'],
""\}

""function! LinterStatus() abort
""    let l:counts = ale#statusline#Count(bufnr(''))
""    let l:all_errors = l:counts.error + l:counts.style_error
""    let l:all_non_errors = l:counts.total - l:all_errors
""    let l:status_str = l:counts.total == 0 ? ' OK ' : printf(' W: %d  E: %d ', all_non_errors, all_errors)
""    return l:status_str
""endfunction
""
""nmap <silent> <C-k> <Plug>(ale_previous_wrap)
""nmap <silent> <C-j> <Plug>(ale_next_wrap)

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'

Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-lsp-icons'

let g:lsp_settings = {
\  'clangd': {'disabled': v:true}
\}


Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_enabled = 1
let g:lsp_text_edit_enabled = 0
let g:asyncomplete_auto_popup = 0
let g:asyncomplete_auto_completeopt = 0

command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/.vim/lsp.log')

" Go
Plug 'fatih/vim-go'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
" LSPに任せる機能をOFFにする
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

Plug 'sebdah/vim-delve'

" C
Plug 'justmao945/vim-clang'
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++1z -stdlib=libc++ -pedantic-errors'
let g:clang_diagsopt = ''
"let g:clang_format_auto = 1
"let g:clang_dotfile = '.clang-format'

" C#
Plug 'OmniSharp/omnisharp-vim'
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_selector_ui = 'fzf'

" Color Scheme
Plug 'w0ng/vim-hybrid'
set background=dark

call plug#end()

"------------------------------------------------------------
" コンシール
"------------------------------------------------------------
set conceallevel=0
let g:vim_json_syntax_conceal=0

"-----------------------------------------------------------
" StatusLine
"-----------------------------------------------------------
set statusline+=%t " ファイル名表示
set statusline+=%y " ファイルタイプ
set statusline+=%m " 変更チェック表示
set statusline+=%r " 読み込み専用かどうか表示
set statusline+=%h " ヘルプページなら[HELP]と表示
set statusline+=%w " プレビューウインドウなら[Prevew]と表示

""set statusline+=%{LinterStatus()}

set statusline+=%= " これ以降は右寄せ表示
set statusline+=[ENC=%{&fileencoding}] " file encoding
set statusline+=[LOW=%l/%L] " 現在行数/全行数

"-----------------------------------------------------------
" autocommand
"-----------------------------------------------------------
augroup MyAutoCmd
    " 保存時にtabをスペースに変換する
    autocmd BufWritePre * :%s/\s\+$//ge
    " QuickFix
    autocmd QuickFixCmdPost *grep*,make cwindow

augroup END

"-----------------------------------------------------------
" color scheme
"-----------------------------------------------------------
colorscheme hybrid

