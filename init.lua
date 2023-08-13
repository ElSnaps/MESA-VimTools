-- vimtools by snaps <3 (github.com/elsnaps)

-- nvim configuration
vim.o.number		= true
vim.o.mouse			= a
vim.o.tabstop		= 4
vim.o.shiftwidth	= 4
vim.o.softtabstop	= 4

-- additional filetype mappings
vim.filetype.add {
	extension = {
		cppm = "cpp" -- c++ modules
	}
}

-- keyset
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><Down>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><Right>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-A-o>', ':Telescope find_files hidden=true<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-A-s>', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- bootstrap lazyvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- install plugins
require("lazy").setup({

	-- startup statistics
	{ "dstein64/vim-startuptime" },

	-- common dependencies
	{ "nvim-lua/plenary.nvim" },

	-- theme
	{
		"morhetz/gruvbox"
	},

	-- status line
	{ "nvim-lualine/lualine.nvim" },

	-- workspace persistence
	{
	  "folke/persistence.nvim",
	  event = "BufReadPre", -- this will only start session saving when an actual file was opened
	},

	-- version control - line markers
	{ "mhinz/vim-signify" },

	-- parser
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = {
					'bash',
					'c',
					'cpp',
					'rust'
				},
				highlight = {
					enable = true
				}
			}
		end
	},

	-- fuzzy search
	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "Telescope"
	},

	-- file system browser
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
		  "nvim-lua/plenary.nvim",
		  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		  "MunifTanjim/nui.nvim",
		}
	},

	-- predefined window layouts
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		opts = {}
	},

	-- error log
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},

	-- terminal
	{ "akinsho/toggleterm.nvim" },

	-- copilot
	{ "github/copilot.vim" },

	-- whitespace marker
	{ "ntpeters/vim-better-whitespace" },

})

vim.cmd("colorscheme gruvbox")

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require("toggleterm").setup{
	open_mapping = [[A-t]]
}
