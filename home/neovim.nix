{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    extraPackages = with pkgs; [
      ripgrep
      fd
      fzf
      bat
      luaformatter
    ];

    plugins = with pkgs.vimPlugins; [
      # Theme
      nvim-web-devicons
      gruvbox-nvim
      
      # UI enhancements
      lualine-nvim
      nvim-tree-lua
      
      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      
      # LSP
      nvim-lspconfig
      
      # Syntax highlighting
      nvim-treesitter
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.markdown
      
      # Fuzzy finder
      telescope-nvim
      plenary-nvim
      
      # Git integration
      vim-fugitive
      gitsigns-nvim
      
      # Editing enhancements
      nvim-surround
      comment-nvim
      smart-splits-nvim
      
      # Indentation
      indent-blankline-nvim
    ];

    extraConfig = ''
      " Basic settings
      set number
      set relativenumber
      set cursorline
      set expandtab
      set shiftwidth=2
      set tabstop=2
      set smartindent
      set undofile
      set undodir=$HOME/.vim/undo
      set backupdir=$HOME/.vim/backup
      set directory=$HOME/.vim/swap
      set termguicolors
      set mouse=a
      set clipboard=unnamedplus
      
      " Search settings
      set ignorecase
      set smartcase
      set hlsearch
      set incsearch
      
      " Appearance
      colorscheme gruvbox
      set background=dark
      
      " Key mappings
      let mapleader = " "
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>e <cmd>NvimTreeToggle<cr>
      nnoremap <leader>/ <cmd>Telescope current_buffer_fuzzy_find<cr>
    '';

    initLua = ''
      -- Lualine setup
      require('lualine').setup {
        options = {
          theme = 'gruvbox',
          icons_enabled = true,
        }
      }

      -- Completion setup
      local cmp = require('cmp')
      cmp.setup {
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        })
      }

      -- Treesitter setup (ensure parser is available)
      local has_treesitter, ts_configs = pcall(require, 'nvim-treesitter.configs')
      if has_treesitter then
        ts_configs.setup {
          highlight = { enable = true },
          indent = { enable = true },
          ensure_installed = { 'lua', 'nix', 'python', 'bash', 'json', 'markdown' }
        }
      end

      -- Gitsigns setup
      require('gitsigns').setup()

      -- Comment setup
      require('Comment').setup()

      -- Surround setup
      require('nvim-surround').setup()

      -- Indent blankline setup
      require('ibl').setup()
    '';
  };
}
