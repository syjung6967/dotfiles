" Configuration script applicable to TUI Neovim

"
" --- vim-plug -----------------------------------------------------------------
"
" This vimrc script uses as few plugins as possible to avoid relying on them.
"
" Plugins which this vimrc script does NOT use:
" - Community-driven Vim: Neovim GUIs (e.g. Neovide) / MacVim
"   TUI lover does not need extra features of them.
" - Pre-configured setup: SpaceVim, LazyVim, AstroNvim
"   They are friendly to non-vimer due to modularity but they harm Vim's
"   nature behaviors too much. (yet another IDE)
" - File system explorer: NERDTree
"   Use netrw for simple job or GUI explorer for complicated jobs.
" - Glyphs for developer: vim-devicons / lspkind.nvim
"   The icons are confusing to understand.
" - Rich status line and tab line: vim-airline / lightline.vim / vim-flagship
"   Maybe necessary if you use multiple status lines and tab lines.
" - Fuzzy finder: fzf / ctrlp
"   Use :e **/<file> for files and :grep <pattern> <file> for contents.
"   See cfilter plugin for more usage.
" - Review tool: Diffview
"   Use vim's diff mode by running external merge tool (e.g., `git mergetool`).

" Install vim-plug if not exists.
if empty(glob('${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  exit
endif

" Run :PlugUpdate to install and update plugins.
" Run :PlugUpgrade to upgrade vim-plug.
"
" Plugin list:
"   https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/vim-plugin-names
call plug#begin()

" Git warpper
Plug 'tpope/vim-fugitive'

" Version control system (VCS) diffs
Plug 'airblade/vim-gitgutter'

" Hint mode
Plug 'easymotion/vim-easymotion'

" Language client
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" AI coding assistant
Plug 'Exafunction/windsurf.vim'

call plug#end()

"
" --- autocommands -------------------------------------------------------------
"

" Restore all cursor positions in previous editing session.
"
" See restore-cursor from usr_05.txt.
augroup RestoreCursor
  autocmd!
  autocmd BufReadPre * autocmd FileType <buffer> ++once
    \ let s:line = line("'\"")
    \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase'], &filetype) == -1
    \ |   execute "normal! g`\""
    \ | endif
augroup END

" Remove trailing whitespaces when the buffer is wrote.
autocmd BufWritePre * :%s/\s\+$//e

"
" --- color scheme -------------------------------------------------------------
"

" Enable highlighting cursor line and screen column.
set cursorline cursorlineopt=both
set cursorcolumn

" Load color scheme.
"
" Screenshots: https://github.com/vim/colorschemes/wiki/Remake-sampler-%E2%80%94-256-colors
colorscheme sorbet

"
" --- format -------------------------------------------------------------------
"

" Preserve eol setting for each file.
"
" Editors have different setting for eol character ('\n')
" By defaults Nvim adds eol but VS Code does not.
" Do not check this annoying POSIX conformance.
"
" See also: https://thoughtbot.com/blog/no-newline-at-end-of-file
set nofixendofline

"
" --- files --------------------------------------------------------------------
"

" Enable undo history.
set undofile

"
" --- layout -------------------------------------------------------------------
"

" Set locale.
"
" POSIX behaves unexpectedly.
" For example, copying unicode characters using "+y does not work.
language en_US.UTF-8

" Set line numbers.
set number relativenumber numberwidth=6

" keep N lines off the edges.
set scrolloff=5

" Always draw the signcolumn.
set signcolumn=yes

" Draw the fold column.
set foldcolumn=1

" Set the title of the window to the value of 'titlestring'.
set title

" Configure status line.
set statusline+=%F " Full path to file name (%F), file name only (%t)
set statusline+=%m " modified flag
set statusline+=\ [%{&fileencoding},%{&fileformat}]
set statusline+=\ [%{len(&filetype)?&filetype:'none'}]
set statusline+=\ %r " read only flag

set statusline+=%= " left/right separator

set statusline+=\ %{&expandtab?'SPC':'TAB'} " indentation style
set statusline+=\ %{&tabstop}SPC " tab spacing

set statusline+=\ %10(%l:%v%) " cursor line:column position
set statusline+=\ [%P] " percent through file (always 3 in length)
set statusline+=\ ≡
set statusline+=\ %LL\ %{wordcount().words}W " total lines and words in the current buffer

" Change the style for hit-enter prompts caused by file messages.
" - a: shorten buffer related info.
" - T: truncate message in the mid if it is too long to fit on the command line.
" - I: don't give the intro message when starting Vim |:intro|.
" - c: don't give |ins-completion-menu| messages.
"set shortmess=aTIc

" Always show tab.
" - <n>gt: go to <n>-th tab.
" - g<Tab>: go to last accessed tab.
" - :tabs: List the tab pages and the windows they contain.
set showtabline=2

" Set number of screen lines to use for the command-line.
" This keeps message from being truncated.
set cmdheight=2

" Set netrw directory browser.
let g:netrw_liststyle=3 " tree style listing
"vertical resize 30
let g:netrw_winsize=-35 " initial size of new windows
let g:netrw_banner=0 " disable banner

"
" --- mapping ------------------------------------------------------------------
"

" Save the current session to ~/sessions directory.
nmap <F2> :execute "mksession! " .. v:this_session<CR>:source ~/sessions/

" Copy text to clipboard in visual mode.
"
" See clipboard-wsl from provider.txt.
vnoremap <silent> <C-C> "+y
let g:clipboard = {
  \   'name': 'WslClipboard',
  \   'copy': {
  \      '+': 'clip.exe',
  \      '*': 'clip.exe',
  \    },
  \   'paste': {
  \      '+': 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  \      '*': 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  \   },
  \   'cache_enabled': 0,
  \ }

" Use :tselect instead of :tag
"nnoremap <C-]> g]

"
" --- mechanics ----------------------------------------------------------------
"

" Enable List mode to show whitespaces.
set list

" Set threshold for reporting number of lines changed.
set report=0

" Set indentation style.
set shiftwidth=0 " Use the same value as &tabstop

" Enable command completion.
"set wildmenu wildmode=list:longest wildoptions=pum,tagfile

" Set completion option.
"set completeopt=menuone,popup,noinsert

" Do not influence to words typed before entering insert mode.
set backspace=""

" Change current working directory to where accessed file is located.
" Note: When this option is on some plugins may not work.
set autochdir

"
" --- hint mode ----------------------------------------------------------------
"

" Move to character.
"
" WARN: DO NOT override 'f', 'F' motion commands because original behavior
" conflicts when repeating the commands.
"map <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)
map <Leader>F <Plug>(easymotion-bd-f)
nmap <Leader>F <Plug>(easymotion-overwin-f)

" Move to word.
map <Leader>W <Plug>(easymotion-bd-w)
nmap <Leader>W <Plug>(easymotion-overwin-w)

"
" --- language server protocol (LSP) support -----------------------------------
"

let g:coc_global_extensions = [
\ 'coc-tsserver',
\ 'coc-json',
\ 'coc-sh',
\ 'coc-go',
\ 'coc-rust-analyzer',
\ 'coc-vimlsp',
\ 'coc-toml',
\ '@nomicfoundation/coc-solidity',
\ ]
execute 'source ' . stdpath('config') . '/coc.vim'

"
" --- Github Copilot -----------------------------------------------------------
"

" Default key bindings:
" <M-]> " <Plug>(copilot-next)
" <M-[> " <Plug>(copilot-previous)
" <M-Bslash> " <Plug>(copilot-suggest)
" <M-Right> " <Plug>(copilot-accept-word)
" <M-C-Right> " <Plug>(copilot-accept-line)

" Remap the default key binding <Tab> to <C-J>.
" <Tab> is more used for indentation than completion.
" <C-J> is rarely used for line feed.
let g:copilot_no_tab_map = v:true
"imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")

"
" --- Windsurf -----------------------------------------------------------------
"
" Default key bindings:
" <C-]> " clear current suggestion.
" <M-]> " next suggestion.
" <M-[> " previous suggestion.
" <Tab> " insert current suggestion.
" <C-K> " accept word from suggestion.
" <C-L> " accept line from suggestion.

"
" --- built-in plugin ----------------------------------------------------------
"
" Enable built-in cfilter plugin.
" :Cfilter <pattern> / :Lfilter <pattern> " Filter quickfix list / location list.
"
" Also, these commands may help you to navigate.
" :cold [n] / :lold [n]
" :cnew [n] / :lnew [n]
" :[n]chi / [n]lhi
"packadd! cfilter

" Enable built-in justify plugin.
" function Justify( [ textwidth [, maxspaces [, indent] ] ] )
"   textwidth: the maximum width of line that is being inserted.
"   maxspaces: the longest spaces allowed. (if exceeds, the line intact)
"   indent: how a line should be indented.
" _j " Align using at most 4 spaces in a space run and keeping current indentation.
" ,gq " Remove space runs and format lines
packadd! justify

" Enable built-in matchit plugin.
"
" This plugin extends % motion which breaks original behavior.
packadd! matchit
"let g:loaded_matchit = 1

" Enable built-in nohlsearch plugin.
"
" Turn off hlsearch after:
" - Doing nothing for 'updatetime'
" - Getting into insert mode
"packadd! nohlsearch

" Enable built-in shellmenu plugin.
"
" Menus for editing shell scripts in the GUI version.
"packadd! shellmenu

" Enable built-in swapmouse plugin.
"
" Swap left and right mouse buttons.
"packadd! swapmouse
