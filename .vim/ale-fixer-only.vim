"
" --- ALE ----------------------------------------------------------------------
"
" Install fixers in advance.
"
" For go:
"   go install -v golang.org/x/tools/cmd/goimports@latest
"   go install -v github.com/segmentio/golines@latest

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

" Disable any linters.
let g:ale_linters = {}

" A mapping from filetypes to "List" values for functions for fixing errors.
" Run :ALEFixSuggest to check which fixers can be used.
let g:ale_fixers = {
\  '*': ["biome", "remove_trailing_lines", "trim_whitespace"],
\  'go': ["gofmt", "goimports"],
\  'solidity': ["forge"],
\}

" Run :ALEFix to fix files when you save them.
let g:ale_fix_on_save = 1
