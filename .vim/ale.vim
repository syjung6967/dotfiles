"
" --- ALE ----------------------------------------------------------------------
"
" Install linters in advance.
"
" For go:
"   go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@latest
"   go install -v golang.org/x/tools/gopls@latest
"   go install -v github.com/mgechev/revive@latest
"   go install -v honnef.co/go/tools/cmd/staticcheck@latest
"
" For vim:
"   npm install -g vim-language-server
"
" References:
" ALE Development Philosophy (read before using ale)
"   https://github.com/dense-analysis/ale/wiki/ALE-Development-Philosophy
" ALE Supported Languages and Tools
"   https://github.com/dense-analysis/ale/blob/master/supported-tools.md
" Language Server Protocol implementations
"   https://langserver.org/
"

source $HOME/.vim/ale-fixer-only.vim

" Show summary for linting on status line.
set statusline+=\ %{LinterStatus()}
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr())
  let l:errors = l:counts.error + l:counts.style_error
  let l:warnings = l:counts.warning + l:counts.style_warning
  return printf('%2dＸ%2d！%dｉ',
    \ l:errors < 100 ? l:errors : 99,
    \ l:warnings < 100 ? l:warnings : 99,
    \ l:counts.info < 10 ? l:counts.info : 9,
    \)
endfunction

" Show indicator whether linter is running on status line.
let g:ale_running = 1
set statusline+=%{g:ale_running?'ⴵ':'\ '}
augroup ALEProgress
  autocmd!

  autocmd User ALELintPre  let g:ale_running = 1 | redrawstatus
  autocmd User ALELintPost let g:ale_running = 0 | redrawstatus
augroup END

" Run linters named in ale_linters settings and default settings.
let g:ale_linters_explicit = 0

" A mapping a filetype to a "List" of linter programs to be run when checking
" particular filetypes. This mapping will be merged with a default mapping.
let g:ale_linters = {
\  'solidity': ["solc"],
\  'vim': ["vimls"],
\}

" Disable linters during typing.
" TODO: the feature does not work.
let g:ale_lint_on_text_changed = 'never'

" Enable completion where available.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc

" Enable hints/suggestions in addition to warnings and errors.
"let g:ale_lsp_suggestions = 1

" Disable automatic imports from external modules.
"let g:ale_completion_autoimport = 0

" Jump to the definition of words under your cursor.
" <C-]> is for vi-compatible, <F12> is for VS-compatible.
nnoremap <C-]> :ALEGoToDefinition <CR>
nnoremap <F12> :ALEGoToDefinition <CR>

" Jump to the definition of a type of a symbol under the cursor.
nnoremap <Leader>gt :ALEGoToTypeDefinition <CR>

" Find references for words under your cursor.
" <S-F12> is for VS-compatible.
nnoremap <Leader>gr :ALEFindReferences -quickfix <CR>

" Jumps to the implementation of symbol under the cursor.
nnoremap <Leader>gm :ALEGoToImplementation -quickfix <CR>

" Rename a symbol under the cursor.
nnoremap <Leader>gn :ALERename <CR>

" Print brief information about the symbol under the cursor.
" NOTE: In Vim 8, long messages will be shown in a preview window.
nnoremap <silent><Space> :ALEHover <CR>

" Show the full linter message for the problem nearest to the cursor on the
" given line in the preview window.
nnoremap <silent><Leader>gl :ALEDetail <CR>

" Show truncated information in the echo line about the symbol at the cursor.
let g:ale_hover_cursor = 1
set updatetime=300

" 'preview-window' will be automatically closed upon entering Insert Mode.
let g:ale_close_preview_on_insert = 1

" Print information about the symbol at the cursor onto popupwin.
let g:ale_floating_preview = 1
function! PreviewPopupOpts() abort
  " Locate popup menu at left vertical-center to window.
  return {
\          'col': -999,
\          'minheight': 5,
\          'minwidth': 50,
\          'maxwidth': 80,
\          'borderchars': repeat([''], 8),
\          'moved': "word",
\        }
endfunction
let g:ale_floating_preview_popup_opts = 'PreviewPopupOpts'

" Keep the sign gutter open at all times.
let g:ale_sign_column_always = 1

" Change the format for echo messages.
let g:ale_echo_msg_error_str = 'Err'
let g:ale_echo_msg_warning_str = 'Warn'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'

" Navigate between errors.
nnoremap <silent> [g :ALEPrevious -wrap -error <CR>
nnoremap <silent> ]g :ALENext -wrap -error <CR>

"
" --- PLUGIN -------------------------------------------------------------------
"
" Install asynchronous lint engine (ALE):
"   git clone https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale
