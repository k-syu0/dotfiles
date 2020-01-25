" deinがインストールされるディレクトリの指定
let s:dein_dir = expand('~/.vimplug/dein') "<- dein によってプラグインがインストールされるディレクトリ
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" deinがインストールされているかをチェック インストールされていなかったらdeinをダウンロードしてくる
if &runtimepath !~# '/dein.vim'
 if !isdirectory(s:dein_repo_dir)
 execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
 endif
 execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" deinの起動
if dein#load_state(s:dein_dir)
 call dein#begin(s:dein_dir)

 " tomlファイル（使用するプラグインのリストが記述されているファイル）の場所を指定
 let g:rc_dir = expand('~/.vim/dein') "<- dein.toml dein_lazy.toml を読み込むディレクトリ
 let s:toml = g:rc_dir . '/dein.toml'
 " let s:lazy_toml = g:rc_dir . '/dein_lazy.toml' "<- dein_lazy.toml を使う場合はコメント解除

 " tomlファイルを読み込む
 call dein#load_toml(s:toml, {'lazy': 0})
 " call dein#load_toml(s:lazy_toml, {'lazy': 1}) "<- dein_lazy.toml を使う場合はコメント解除

 " 設定の終了
 call dein#end()
 call dein#save_state()
endif

" プラグインのインストールをチェック 未インストールのプラグインがあればインストールする
if dein#check_install()
 call dein#install()
endif

" 文字コードの指定
set encoding=utf-8
set fileencodings=utf-8
" ファイルを開く文字コードの指定
" set encodingで指定した文字コードは一番最後に記述する(後ろの指定は無視されるため)
" set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

" 挿入モードでのカーソル移動
" inoremap <c-j> <Down>
" inoremap <c-k> <Up>
" inoremap <c-b> <Left>
" inoremap <c-l> <Right>
" lexima.vimを使っていても、ドットで繰り返せるように
inoremap <silent> <C-l> <C-r>=lexima#insmode#leave(1, '<LT>C-G>U<LT>RIGHT>')<CR>

" " 背景色の変更を無効にする
" autocmd ColorScheme * highlight Normal ctermbg=none
" autocmd ColorScheme * highlight LineNr ctermbg=none

" コメント文字の設定
" autocmd BufNewFile,BufRead *.vimrc setlocal commentstring=\"\ %s
" autocmd FileType html setlocal commentstring=<!--\ %s\ -->
" autocmd BufNewFile,BufRead *.php setlocal commentstring=//\ %s
" autocmd BufNewFile,BufRead *.ctp setlocal commentstring=<!--\ %s\ -->
" autocmd FileType sql setlocal commentstring=--\ %s

" NerdTreeの呼び出し
nnoremap <silent> <space>n :NERDTreeToggle<CR>
" file指定なしでvimを開く場合、NerdTreeを起動
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:WebDevIconsNerdTreeBeforeGlyphPadding = " "
let g:WebDevIconsNerdTreeAfterGlyphPadding = " "
" 色設定
syntax enable
set background=dark
" vimの背景色をなしにする
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none ctermfg=darkgray
autocmd ColorScheme * highlight cursorLine ctermbg=black
autocmd ColorScheme * highlight Visual ctermbg=239
colorscheme hybrid
" set visualbell
set visualbell t_vb=


" 検索設定
set hlsearch
set incsearch

" インデントを４にする
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

" filetypeの設定　大事
filetype plugin on " 重要だったみたい（コメント文字も出来るようになった！）
filetype indent on

" fileTypeによってインデントを変える
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 shiftwidth=2
augroup END


" 行番号の表示
set number
" 括弧
set showmatch

" バックスペースキーで削除できるものを指定
set backspace=indent,eol,start

" 挿入モード時に非点滅の縦棒タイプのカーソル
let &t_SI .= "\e[6 q"
" ノーマルモード時に非点滅のブロックタイプのカーソル
let &t_EI .= "\e[2 q"
" 置換モード時に非点滅の下線タイプのカーソル
let &t_SR .= "\e[4 q"
set cursorline

" 更新間隔を2秒に設定
set updatetime=200
" ESCからnormalモードに戻るタイムラグをなくす
set ttimeoutlen=50

" air-lineのtab機能を有効にする
let g:airline#extensions#tabline#enabled = 1
nnoremap <silent> <C-p> :bp<CR>
nnoremap <silent> <C-n> :bn<CR>
nnoremap <silent> <space>q :bd<CR>
" air-lineのテーマ
let g:airline_theme = 'papercolor'
" fileのpathを表示しない
let g:airline#extensions#tabline#fnamemod = ":t"
let g:airline_section_c = "%t"
" buffers -> 空白
let g:airline#extensions#tabline#buffers_label = ""


" white-spaceの設定
let g:better_whitespace_enabled=1
nnoremap <silent> <space>f :<C-u>ToggleWhitespace<CR>
nnoremap <silent> <space>F :<C-u>StripWhitespace<CR>


" buffer切り替え時の未保存警告を無効
set hidden

" 保存コマンド
nnoremap <silent> <space>w :w<CR>
nnoremap <silent> <space>W :wa<CR>

" x,sでのレジスタ指定
" nnoremap x "_x
" nnoremap s "_s

" jjでinsert modeを抜ける時、カーソルを右（元の位置）に戻す
inoremap jj <Esc>
inoremap っｊ <Esc>

" 空行の挿入
" nnoremap <space>o mzo<ESC>`z
" nnoremap <space>O mzO<ESC>`z
" append関数を使うやり方(line('.')で現在行を取得出来る)
" 自動コメント文字挿入onでも挿入を防げる
nnoremap <silent> <space>o :call append(line('.'), '')<CR>
nnoremap <silent> <space>O :call append(line('.')-1, '')<CR>

" ハイライトを消す
" nnoremap <silent> <ESC><ESC> :noh<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" 単語ハイライト
nnoremap <silent> <space><space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
" 単語一括置換（ハイライト）
nmap <space>s <space><space>:%s/<C-r>///g<Left><Left>

" visualmodeからのハイライト、検索、置換
xnoremap <silent> <space><space> mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z
" xnoremap * :<C-u>call <SID>set_vsearch()<CR>/<C-r>/<CR>
xmap <space>s <space><space>:%s/<C-r>///g<Left><Left>

function! s:set_vsearch()
  silent normal gv"zy
  let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
endfunction

" 行を移動
" vnoremap <C-p> "zx<Up>"zP`[V`]
vnoremap <C-n> "zx"zp`[V`]
vnoremap <silent> <C-p> :m.-2<CR>`[V`]
" vnoremap <silent> <C-n> :m.+1<CR>`[V`]

" 行を複製
vnoremap <space>p "zy"zP
vnoremap <space>n "zy`]"zp

" swapファイルを作らない
set noswapfile

" scrollの行数指定
au BufEnter * set scroll=5
" scrollの開始位置
set scrolloff=5

" バックスペースで補完のポップアップを閉じる
" inoremap <expr><C-f> deoplete#close_popup()

" インデントを表示
nnoremap <silent> <space>i :IndentLinesEnable<CR>
nnoremap <silent> <space>I :IndentLinesDisable<CR>

" lexima(autoclose)でctrl-hをBSを同じ動きにする
" let g:lexima_ctrlh_as_backspace = 1
" 文末のみautocloseを適用する
" call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '{', 'input': '{'})

" indentlineの無効ファイルを指定
let g:indentLine_fileTypeExclude = ['help']

" 常に画面の真ん中で入力
inoremap j<CR> <C-g>u<Esc>zzo
" call lexima#insmode#map_hook('after', "<CR>", "x<BS><C-o>zz")
" inoremap <CR> <CR>x<BS><C-o>zz

" コマンドラインでの補完設定
set wildmenu wildmode=list:longest,full
" コマンドの履歴を1000件保存する
set history=1000

" コマンドラインで過去のコマンドを探す時、フィルタリング出来るようにする。
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 検索する時に大文字、小文字を区別しない
set ignorecase
" 大文字を入力した時は、区別する
set smartcase

" %%でアクテイブバッファのフルパスを出す(from 実践vim)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
" %:p でフルパスを出せる
" set path+=
" find EXコマンドでファイルを見つける

" タグなどの対応ジャンプ
packadd! matchit

" コメント行にいる時に、自動でコメント文字挿入をなしにする
augroup auto_comment_off
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=r
	autocmd BufEnter * setlocal formatoptions-=o
augroup END

" ノーマルモードでenterで改行
nnoremap <CR> mza<CR><ESC>`z
nnoremap <TAB> i<space><ESC>

" 定義ジャンプ(php)
nmap <silent> <space>g :<c-u>call phpactor#GotoDefinition()<CR>

" Denite mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
endfunction


nnoremap [denite] <Nop>
nmap <space>d [denite]
" buffer一覧
" nnoremap <silent> [denite]d :<C-u>enew<CR>:<C-u>Denite -direction=left buffer<CR>
nnoremap <silent> [denite]d :<C-u>Denite -direction=top buffer<CR>
" register一覧
nnoremap <silent> [denite]r :<C-u>Denite -direction=top register<CR>
