-- vimtools by snaps <3 (github.com/elsnaps)

-- nvim configuration
vim.o.number		= true
vim.o.mouse			= 'a'
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

-- plugins to checkout
-- ms-jpq/chadtree
-- ms-jpq-coq_nvim

-- install plugins
require("lazy").setup({

	-- startup statistics
	{ "dstein64/vim-startuptime" },

	-- common dependencies
	{ "nvim-lua/plenary.nvim" },

	-- theme
	{
		"sekke276/dark_flat.nvim"
	},

	-- tabs
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		},
		init = function() vim.g.barbar_auto_setup = false end,
    },

	-- status line
	{
		"nvim-lualine/lualine.nvim"
	},

	-- workspace persistence
	{
	  "folke/persistence.nvim",
	  event = "BufReadPre", -- this will only start session saving when an actual file was opened
	},

	-- version control - line markers
	{
		"mhinz/vim-signify"
	},

	-- parser
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = {
					"c",
					"cpp",
					"rust",
					"lua",
					"bash",
					"markdown",
					"markdown_inline"
				},
				highlight = {
					enable = true,

					-- enables treesitter + :h syntax at the same time. this allows us to
					-- manually override syntax highlighting for specific languages like
					-- c++ for modules where import and export aren't yet supported.
					additional_vim_regex_highlighting = { "c", "cpp" },
				},
				set_custom_captures = {
					-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
					['type'] = 'cppModule',
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

	-- autocomplete
	{
		"neoclide/coc.nvim",
		branch = "release",
		build = ":CocUpdate"
	},

	-- file system browser
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
		  "nvim-lua/plenary.nvim",
		  "MunifTanjim/nui.nvim",
		}
	},

	-- predefined window layouts
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		opts = {}
	},

	-- terminal
	{
		"akinsho/nvim-toggleterm.lua",
	},

	-- copilot
	{
		"github/copilot.vim",
		event = "VeryLazy",
		cmd = {
			'Copilot',
		},
	},

	-- whitespace marker
	{
		"ntpeters/vim-better-whitespace"
	},

	{
		"mg979/vim-visual-multi"
	},

})

-- BEGIN THEME CONFIGURATION



vim.cmd("colorscheme dark_flat")

require('dark_flat').setup({

	colors = {

		black				= "#000000",
		white				= "#ffffff",

		background			= "#171717",
		background_alt		= "#171717",

		light_grey			= "#8f8f8f",
		dark_grey			= "#454545",

		emerald				= "#82f4a2",
		emerald_dark		= "#66b580",
		emerald_light		= "#a6ffcc",

		red					= "#ff0000",
	},

	themes = function(colors)
		return {

			-- Find modifiable groups in dark_flat/themes/groups.lua

			-- @TODO: Hide errors from clangd, they are crap, just give suggestions
			-- please mr COC.

			-- @TODO: SETUP :h syntax for c++ modules (import + export keywords)
			-- probably dark_flat theme has a group for these already.

			-- @TODO: SET :h syntax to be light_grey unless a word we specifically
			-- want to highlight is found.

			-- @TODO: Fix statusline BG (unless???)

			-- THEME COLORS

			-- set background color of non-current buffers
			NormalNC						= { bg = colors.background_alt },

			-- set line numbers and divider colors
			LineNr							= { fg = colors.dark_grey },
			VertSplit						= { fg = colors.dark_grey },

			-- TELESCOPE COLORS
			TelescopeBorder					= { fg = colors.light_grey },
			TelescopeNormal					= { fg = colors.light_grey },
			TelescopePromptCounter			= { fg = colors.emerald_light },
			TelescopeTitle					= { fg = colors.emerald_light },

			-- TREESITTER COLORS
			["@annotation"]					= { fg = colors.light_grey },
			["@attribute"]					= { fg = colors.light_grey },
			["@boolean"]					= { fg = colors.light_grey },
			["@character"]					= { fg = colors.light_grey },
			["@character.special"]			= { fg = colors.light_grey },
			["@comment"]					= { fg = colors.dark_grey },
			["@conditional"]				= { fg = colors.light_grey },
			["@constant"]					= { fg = colors.light_grey },
			["@constant.builtin"]			= { fg = colors.light_grey },
			["@constant.macro"]				= { fg = colors.light_grey },
			["@constructor"]				= { fg = colors.light_grey },
			["@debug"]						= { fg = colors.light_grey },
			["@define"]						= { fg = colors.light_grey },
			["@error"]						= { fg = colors.light_grey },
			["@exception"]					= { fg = colors.light_grey },
			["@field"]						= { fg = colors.light_grey },
			["@float"]						= { fg = colors.light_grey },
			["@function"]					= { fg = colors.emerald_dark },
			["@function.builtin"]			= { fg = colors.light_grey },
			["@function.call"]				= { fg = colors.light_grey },
			["@function.macro"]				= { fg = colors.light_grey },
			["@include"]					= { fg = colors.light_grey },
			["@keyword"]					= { fg = colors.light_grey },
			["@keyword.function"]			= { fg = colors.light_grey },
			["@keyword.operator"]			= { fg = colors.light_grey },
			["@keyword.return"]				= { fg = colors.light_grey },
			["@label"]						= { fg = colors.light_grey },
			["@method"]						= { fg = colors.light_grey },
			["@method.call"]				= { fg = colors.light_grey },
			["@namespace"]					= { fg = colors.light_grey },
			["@none"]						= { fg = colors.light_grey },
			["@number"]						= { fg = colors.light_grey },
			["@operator"]					= { fg = colors.light_grey },
			["@parameter"]					= { fg = colors.light_grey },
			["@parameter.reference"]		= { fg = colors.light_grey },
			["@preproc"]					= { fg = colors.light_grey },
			["@property"]					= { fg = colors.light_grey },
			["@punctuation.bracket"]		= { fg = colors.light_grey },
			["@punctuation.delimiter"]		= { fg = colors.light_grey },
			["@punctuation.special"]		= { fg = colors.light_grey },
			["@repeat"]						= { fg = colors.light_grey },
			["@storageclass"]				= { fg = colors.light_grey },
			["@string"]						= { fg = colors.light_grey },
			["@string.escape"]				= { fg = colors.light_grey },
			["@string.regex"]				= { fg = colors.light_grey },
			["@string.special"]				= { fg = colors.light_grey },
			["@symbol"]						= { fg = colors.light_grey },
			["@tag"]						= { fg = colors.light_grey },
			["@tag.attribute"]				= { fg = colors.light_grey },
			["@tag.delimiter"]				= { fg = colors.light_grey },
			["@text"]						= { fg = colors.light_grey },
			["@text.danger"]				= { fg = colors.light_grey },
			["@text.emphasis"]				= { fg = colors.light_grey },
			["@text.environment"]			= { fg = colors.light_grey },
			["@text.environment.name"]		= { fg = colors.light_grey },
			["@text.literal"]				= { fg = colors.light_grey },
			["@text.math"]					= { fg = colors.light_grey },
			["@text.note"]					= { fg = colors.light_grey },
			["@text.reference"]				= { fg = colors.light_grey },
			["@text.strike"]				= { fg = colors.light_grey },
			["@text.strong"]				= { fg = colors.light_grey },
			["@text.title"]					= { fg = colors.light_grey },
			["@text.underline"]				= { fg = colors.light_grey },
			["@text.uri"]					= { fg = colors.light_grey },
			["@text.warning"]				= { fg = colors.light_grey },
			["@todo"]						= { fg = colors.red },
			["@type"]						= { fg = colors.emerald_light },
			["@type.builtin"]				= { fg = colors.light_grey },
			["@type.definition"]			= { fg = colors.light_grey },
			["@type.qualifier"]				= { fg = colors.light_grey },
			["@variable"]					= { fg = colors.light_grey },
			["@variable.builtin"]			= { fg = colors.light_grey },

			-- SEMANTIC TOKENS
			["@lsp.mod.deprecated"]			= { fg = colors.light_grey, strikethrough = true },
			["@lsp.mod.documentation"]		= { link = "@constant" },
			["@lsp.type.class"]				= { link = "@type" },
			["@lsp.type.comment"]			= { link = "@comment" },
			["@lsp.type.enum"]				= { link = "@type" },
			["@lsp.type.enumMember"]		= { link = "@constant" },
			["@lsp.type.function"]			= { link = "@function" },
			["@lsp.type.macro"]				= { link = "@function" },
			["@lsp.type.method"]			= { link = "@function" },
			["@lsp.type.namespace"]			= { link = "@namespace" },
			["@lsp.type.number"]			= { link = "@number" },
			["@lsp.type.operator"]			= { link = "@operator" },
			["@lsp.type.parameter"]			= { link = "@parameter" },
			["@lsp.type.property"]			= { link = "@property" },
			["@lsp.type.string"]			= { link = "@string" },
			["@lsp.type.struct"]			= { link = "@type" },
			["@lsp.type.typeParameter"]		= { link = "@type" },

		}
	end,

})

-- enable highlighting on module imports
vim.cmd("highlight cppModule guibg=blue")

-- enable highlighting on using statements
-- @TODO: Fix this one.
vim.cmd("syntax keyword cUsing using")
vim.cmd("highlight cUsing guibg=blue")

-- END SYNTAX HIGHLIGHTING CONFIGURATION



-- BEGIN LUALINE CONFIGURATION

require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'auto',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
	},
	sections = {
        lualine_a = {'mode',},
		lualine_b = {'filename'},
		lualine_c = {'branch'},
	},
}

-- END LUALINE CONFIGURATION



-- BEGIN BARBAR CONFIGURATION

require('barbar').setup {
	auto_hide = true,
	animation = false,
	clickable = false,

	insert_at_end = false,
	insert_at_start = true,

	icons = {
		filetype = {
			enabled = false,
		}
	},

	sidebar_filetypes = {
		["neo-tree"] = { event = 'BufWipeout' },
	}
}

-- END BARBAR CONFIGURATION



-- BEGIN CONQUER OF COMPLETION CONFIGURATION

-- Setting global extensions for coc
vim.g.coc_global_extensions = {'coc-clangd', 'coc-rust-analyzer', 'coc-highlight'}

-- Disabling the startup warning for coc
vim.g.coc_disable_startup_warning = 1

-- Mapping filetypes for coc
vim.g.coc_filetype_map = {
  cppm = 'clangd'
}

-- END CONQUER OF COMPLETION CONFIGURATION



-- BEGIN TERMINAL CONFIGURATION

-- Setting up the terminal
require('toggleterm').setup({
	open_mapping = '<A-t>',
    direction = 'horizontal',
	shell = "powershell.exe -nologo",
})

-- END TERMINAL CONFIGURATION



-- BEGIN NEO TREE CONFIGURATION

require('neo-tree').setup({
	quit_on_last_window = true,
	enable_git_status = true,

})

-- END NEO TREE CONFIGURATION



-- Tab mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)



-- BEGIN TELESCOPE REMAPS

vim.api.nvim_set_keymap('n', '<S-A-o>', ':Telescope find_files hidden=true<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-A-s>', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- END TELESCOPE REMAPS



-- BEGOM PAGE SCROLLING REMAPS

-- remap pg dn / up to move screen by X lines
vim.api.nvim_set_keymap('n', '<PageUp>', '10<C-y>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<PageDown>', '10<C-e>', { noremap = true, silent = true })

-- remap ctrl pg up to move screen to top of file
vim.api.nvim_set_keymap('n', '<C-PageUp>', 'gg', { noremap = true, silent = true })

-- remap ctrl pg down to move screen to bottom of file + half the screen
vim.api.nvim_set_keymap('n', '<C-PageDown>', 'Gzz', { noremap = true, silent = true })

-- END PAGE SCROLLING REMAPS



