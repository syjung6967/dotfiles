-- Configuration script applicable to TUI Neovim
--
-- Plugins which this init script does NOT use:
-- - Community-driven Vim: Neovim GUIs (e.g. Neovide) / MacVim
--   TUI lover does not need extra features of them.
-- - Pre-configured setup: SpaceVim, LazyVim, AstroNvim
--   They are friendly to non-vimer due to modularity but they harm Vim's
--   nature behaviors too much. (yet another IDE)
-- - File system explorer: NERDTree
--   Use netrw for simple job or GUI explorer for complicated jobs.
-- - Glyphs for developer: vim-devicons / lspkind.nvim
--   The icons are confusing to understand.
-- - Rich status line and tab line: vim-airline / lightline.vim / vim-flagship
--   Maybe necessary if you use multiple status lines and tab lines.
-- - Fuzzy finder: fzf / ctrlp
--   Use :e **/<file> or :find for files and :grep <pattern> <file> for contents.
--   See cfilter plugin for more usage.
-- - Review tool: Diffview
--   Use vim's diff mode by running external merge tool (e.g., `git mergetool`).

-- Preserve eol setting for each file.
--
-- Editors have different setting for eol character ('\n')
-- By defaults Nvim adds eol but VS Code does not.
-- Do not check this annoying POSIX conformance.
--
-- See also: https://thoughtbot.com/blog/no-newline-at-end-of-file
vim.opt.fixendofline = false

-- Enable undo history.
vim.opt.undofile = true

-- Restore all cursor positions in previous editing session.
--   See restore-cursor from usr_05.txt.
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Copy to system clipboard in visual mode with Ctrl+C.
vim.keymap.set("v", "<C-C>", '"+y', { silent = true })

-- Set clipboard to use the system clipboard ('unnamed').
-- Or set to 'unnamedplus' to sync with the system clipboard for all operations.
--
-- Note:
-- macOS and Windows work out of the box. 
-- Linux requires external tools (e.g., xclip/xsel for X11, or wl-clipboard for Wayland).
-- See g:clipboard from provider.txt.
vim.opt.clipboard = "unnamed"

-- Do not influence to words typed before entering insert mode.
vim.opt.backspace = ""

-- Set indentation style.
-- Set to 0 to use the same value as &tabstop.
vim.opt.shiftwidth = 0

-- Automatically change the current working directory to the directory of the current file.
-- Note: When this option is on, some plugins may not work.
--vim.opt.autochdir = true




-- Load color scheme.
--   Screenshots: https://github.com/vim/colorschemes/wiki/Remake-sampler-%E2%80%94-256-colors
--vim.cmd.colorscheme('sorbet')
vim.cmd.colorscheme('murphy')

-- Set line numbers.
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 6

-- Set the sign column to automatically adjust its width based on the number of signs.
vim.opt.signcolumn = "auto:2-9"

-- Enable updating the terminal title with the current file name.
vim.opt.title = true

-- Always show tab.
--   <n>gt: go to <n>-th tab.
--   g<Tab>: go to last accessed tab.
--   :tabs: List the tab pages and the windows they contain.
vim.opt.showtabline = 2

-- Enable highlighting cursor line and screen column.
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.cursorlineopt = "both"

-- The cursor line will always be in the middle of the window.
vim.opt.scrolloff=999

-- Enable List mode to show whitespaces.
vim.opt.list = true

-- Set the time of inactivity before triggering the CursorHold event.
vim.opt.updatetime = 300




-- Plugin list:
--   https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/vim-plugin-names
vim.pack.add({
  -- Language Server Protocol (LSP) configuration
  -- nvim >= 0.5.0 has built-in LSP client support.
  'https://github.com/neovim/nvim-lspconfig',

  -- Git wrapper
  'https://github.com/tpope/vim-fugitive',

  -- Version control system (VCS) diffs
  'https://github.com/airblade/vim-gitgutter',

  -- Hint mode
  'https://github.com/easymotion/vim-easymotion',

  -- AI coding assistant
  'https://github.com/github/copilot.vim',

  -- AI coding agent
  'https://github.com/coder/claudecode.nvim',
})

require("claudecode").setup({
  -- Top-level aliases are supported and forwarded to terminal config
  git_repo_cwd = true,
})

-- Enable Tree-sitter for syntax highlighting and code navigation if the parser is available.
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

--vim.lsp.config('clangd', {
--...
--})

vim.lsp.enable({
  'lua_ls',
  'clangd',
  'rust_analyzer',
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = { buffer = args.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

--
-- --- Github Copilot -----------------------------------------------------------
--
-- Default key bindings:
-- <M-]> " <Plug>(copilot-next)
-- <M-[> " <Plug>(copilot-previous)
-- <M-Bslash> " <Plug>(copilot-suggest)
-- <M-Right> " <Plug>(copilot-accept-word)
-- <M-C-Right> " <Plug>(copilot-accept-line)

-- Remap the default key binding <Tab> to <C-J>.
-- <Tab> is more used for indentation than completion.
-- <C-J> is rarely used for line feed.
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

--
-- --- hint mode ----------------------------------------------------------------
--

-- Move to word.
vim.keymap.set({ 'n', 'x', 'o' }, '<Leader>w', '<Plug>(easymotion-bd-w)', { remap = true })
vim.keymap.set('n', '<Leader>W', '<Plug>(easymotion-overwin-w)', { remap = true })
