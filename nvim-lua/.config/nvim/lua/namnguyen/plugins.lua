local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path })
end

return require("packer").startup(function(use)
  -- Adding color with colorizer & rainbow
  use("norcalli/nvim-colorizer.lua")
  use("p00f/nvim-ts-rainbow")

  -- A Git wrapper, Git commands
  use("tpope/vim-fugitive")
  use("tveskag/nvim-blame-line")
  use("ThePrimeagen/git-worktree.nvim")

  -- The undo history visualizer for VIM
  use("mbbill/undotree")

  -- Dev icons
  use("kyazdani42/nvim-web-devicons")

  -- A tree explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week
  }

  -- Insert or delete brackets, parens, quotes in pair
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup({}) end
  }

  -- Add/change/delete surrounding delimiter pairs with ease
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end
  })

  -- Comment Toggler
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  }

  -- Support Emmet for HTML & CSS
  use("mattn/emmet-vim")

  -- Buffer/Tab line
  use { "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" }

  -- Use nvim/vim"s builtin terminal in the floating/popup window
  use("voldikss/vim-floaterm")

  --- Vim Align
  use("junegunn/vim-easy-align")

  -- A solid language pack for syntax highlighting
  -- vim.opt.nocompatible = true
  -- use("sheerun/vim-polyglot")

  -- Markdown
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } }
  }
  use("nvim-telescope/telescope-fzy-native.nvim")

  -- Use treesitter to auto close and auto rename html tag
  use {
    "nvim-ts-autotag",
    config = function() require("nvim-ts-autotag").setup() end
  }

  -- LSP Plugins
  use("neovim/nvim-lspconfig")
  use("simrat39/symbols-outline.nvim")
  use("williamboman/nvim-lsp-installer")
  use("folke/lsp-colors.nvim")

  -- Autocomplete
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")

  -- Snippet
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")

  -- Trouble
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end
  }

  -- Neovim Tree shitter
  use("nvim-treesitter/nvim-treesitter", {
    run = ":TSUpdate"
  })
  use("nvim-treesitter/playground")

  -- Prettier
  use("sbdchd/neoformat")

  -- Todos
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end
  }

  -- Search
  use('windwp/nvim-spectre')


  -- Theme
  use("morhetz/gruvbox")
  use("folke/tokyonight.nvim")
  -- use("markvincze/panda-vim")
  -- use("drewtempelmeyer/palenight.vim")
  -- use("Pocco81/Catppuccino.nvim")
  -- use("Yagua/nebulous.nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
