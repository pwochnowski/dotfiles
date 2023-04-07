
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use {
	  "neovim/nvim-lspconfig", -- lsp configuration
	  requires = {
		  -- install language servers easily
		  "williamboman/mason.nvim", 
		  -- interop between mason.nvim and nvim-lspconfig
		  -- adjusts the LSP configurations in nvim-lspconfig to use the langauge servers installed by mason.nvim
		  "williamboman/mason-lspconfig.nvim", 

		  -- Additional lua configuration, makes nvim stuff amazing
		  'folke/neodev.nvim',
	  },
  }

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.x',
	  requires = {'nvim-lua/plenary.nvim'}
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
	  "nvim-telescope/telescope-frecency.nvim",
	  requires = {"kkharji/sqlite.lua"}
  }

  use 'folke/tokyonight.nvim'

  use({
	  'rose-pine/neovim',
	  as = 'rose-pine'
  })

  use({'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}})
  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use({'nvim-treesitter/playground', {run = ':TsInstall query'}})

  -- better vim marks
  -- use('theprimeagen/harpoon')
  
  use('mbbill/undotree')
  
  use('tpope/vim-fugitive')
end)
