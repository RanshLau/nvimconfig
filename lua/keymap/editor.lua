local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

local plug_map = {
	-- Plugin persisted.nvim
	["n|<leader>ss"] = map_cu("SessionSave"):with_noremap():with_silent():with_desc("session: Save"),
	["n|<leader>sl"] = map_cu("SessionLoad"):with_noremap():with_silent():with_desc("session: Load current"),
	["n|<leader>sd"] = map_cu("SessionDelete"):with_noremap():with_silent():with_desc("session: Delete"),

	-- Plugin: nvim-bufdel
	["n|<A-q>"] = map_cr("BufDel"):with_noremap():with_silent():with_desc("buffer: Close current"),

	-- Plugin: comment.nvim
	["n|gcc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)")
				or et("<Plug>(comment_toggle_linewise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for line"),
	["n|gcb"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
				or et("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for block"),
	["n|gcC"] = map_cmd("<Plug>(comment_toggle_linewise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with operator"),
	["n|gcB"] = map_cmd("<Plug>(comment_toggle_blockwise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with operator"),
	["v|gc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with selection"),
	["v|gcb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with selection"),

	-- Plugin: diffview.nvim
	["n|<leader>gd"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
	["n|<leader>gD"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),

	-- Plugin: hop.nvim
	["nv|<leader>jw"] = map_cmd("<Cmd>HopWordMW<CR>"):with_noremap():with_desc("jump: Goto word"),
	["nv|<leader>jj"] = map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("jump: Goto line"),
	["nv|<leader>jk"] = map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("jump: Goto line"),
	["nv|<leader>jc"] = map_cmd("<Cmd>HopChar1MW<CR>"):with_noremap():with_desc("jump: Goto one char"),
	["nv|<leader>jC"] = map_cmd("<Cmd>HopChar2MW<CR>"):with_noremap():with_desc("jump: Goto two chars"),
	["vo|s"] = map_cmd("<Cmd>HopWordMW<CR>"):with_noremap():with_desc("jump: Goto two chars"),

	-- Plugin: smart-splits.nvim
	["n|<C-Left>"] = map_cu("SmartResizeLeft"):with_silent():with_noremap():with_desc("window: Resize -3 horizontally"),
	["n|<C-Down>"] = map_cu("SmartResizeDown"):with_silent():with_noremap():with_desc("window: Resize -3 vertically"),
	["n|<C-Up>"] = map_cu("SmartResizeUp"):with_silent():with_noremap():with_desc("window: Resize +3 vertically"),
	["n|<C-Right>"] = map_cu("SmartResizeRight"):with_silent():with_noremap():with_desc("window: Resize +3 horizontally"),
	["n|<C-h>"] = map_cu("SmartCursorMoveLeft"):with_silent():with_noremap():with_desc("window: Focus left"),
	["n|<C-j>"] = map_cu("SmartCursorMoveDown"):with_silent():with_noremap():with_desc("window: Focus down"),
	["n|<C-k>"] = map_cu("SmartCursorMoveUp"):with_silent():with_noremap():with_desc("window: Focus up"),
	["n|<C-l>"] = map_cu("SmartCursorMoveRight"):with_silent():with_noremap():with_desc("window: Focus right"),
	["n|<leader>wh"] = map_cu("SmartSwapLeft"):with_silent():with_noremap():with_desc("window: Move window leftward"),
	["n|<leader>wj"] = map_cu("SmartSwapDown"):with_silent():with_noremap():with_desc("window: Move window downward"),
	["n|<leader>wk"] = map_cu("SmartSwapUp"):with_silent():with_noremap():with_desc("window: Move window upward"),
	["n|<leader>wl"] = map_cu("SmartSwapRight"):with_silent():with_noremap():with_desc("window: Move window rightward"),

	-- Plugin: nvim-spectre
	["n|gss"] = map_callback(function()
			require("spectre").toggle()
		end)
		:with_silent()
		:with_noremap()
		:with_desc("editn: Toggle search & replace panel"),
	["n|gsp"] = map_callback(function()
			require("spectre").open_visual({ select_word = true })
		end)
		:with_silent()
		:with_noremap()
		:with_desc("editn: search&replace current word (project)"),
	["v|gsp"] = map_callback(function()
			require("spectre").open_visual()
		end)
		:with_silent()
		:with_noremap()
		:with_desc("edit: search & replace current word (project)"),
	["n|gsf"] = map_callback(function()
			require("spectre").open_file_search({ select_word = true })
		end)
		:with_silent()
		:with_noremap()
		:with_desc("editn: search & replace current word (file)"),

	-- Plugin: nvim-treehopper
	["vo|S"] = map_cu("lua require('tsht').nodes()"):with_silent():with_desc("jump: Operate across syntax tree"),

	-- Plugin suda.vim
	["n|<A-s>"] = map_cu("SudaWrite"):with_silent():with_noremap():with_desc("editn: Save file using sudo"),
}

bind.nvim_load_mapping(plug_map)
