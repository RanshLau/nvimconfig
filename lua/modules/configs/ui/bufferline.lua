return function()
	local icons = { ui = require("modules.utils.icons").get("ui") }

	local opts = {
		options = {
			number = nil,
			close_command = "BufDel! %d",
			right_mouse_command = "BufDel! %d",
			modified_icon = icons.ui.Modified,
			buffer_close_icon = icons.ui.Close,
			left_trunc_marker = icons.ui.Left,
			right_trunc_marker = icons.ui.Right,
			max_name_length = 20,
			max_prefix_length = 13,
			tab_size = 20,
			color_icons = true,
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			enforce_regular_tabs = false,
			persist_buffer_sort = true,
			always_show_bufferline = true,
			separator_style = "thin",
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count)
				return "(" .. count .. ")"
			end,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					padding = 0,
				},
				{
					filetype = "aerial",
					text = "Symbol Outline",
					text_align = "center",
					padding = 0,
				},
			},
		},
		-- Change bufferline's highlights here! See `:h bufferline-highlights` for detailed explanation.
		highlights = {},
	}

	local colors = require("gruvbox").palette -- Get the palette.
	local styles = { "bold" }
	local catppuccin_hl_overwrite = {
		highlights = {
			-- background = { bg = colors.dark0 },
			-- buffer_selected = { fg = colors.light0, bg = colors.dark0, style = styles }, -- current
			-- Duplicate
			-- duplicate_selected = { fg = colors.light0, bg = colors.dark0, style = styles },
			-- duplicate_visible = { fg = colors.light0, bg = colors.dark0, style = styles },
			-- duplicate = { fg = colors.light0, bg = colors.dark0, style = styles },
			-- tabs
			-- tab = { fg = colors.light1, bg = colors.dark2 },
			-- tab_selected = { fg = colors.bright_blue, bg = colors.gray, bold = true },
			-- tab_separator = { fg = colors.gray, bg = colors.dark2 },
			-- tab_separator_selected = { fg = colors.gray, bg = colors.gray },

			-- tab_close = { fg = colors.bright_red, bg = colors.dark2 },
			-- indicator_selected = { fg = colors.bright_green, bg = colors.gray, style = styles },
			-- -- separators
			-- separator = { fg = colors.dark0, bg = colors.dark0 },
			separator_selected = { fg = colors.dark0, bg = colors.dark0 },
			-- offset_separator = { fg = colors.dark0, bg = colors.dark0 },
			-- -- close buttons
			-- close_button = { fg = colors.light0, bg = colors.dark0 },
			-- close_button_selected = { fg = colors.light0, bg = colors.dark0 },
			-- -- Empty fill
			fill = { bg = colors.dark1 },
			-- -- Numbers
			-- numbers = { fg = colors.light1, bg = colors.dark2 },
			-- numbers_visible = { fg = colors.light1, bg = colors.dark2 },
			-- numbers_selected = { fg = colors.dark0, bg = colors.gray, style = styles },
			-- -- Errors
			-- error = { fg = colors.bright_red, bg = colors.dark2 },
			-- error_visible = { fg = colors.bright_red, bg = colors.dark2 },
			-- error_selected = { fg = colors.bright_red, bg = colors.gray, style = styles },
			-- error_diagnostic = { fg = colors.bright_red, bg = colors.dark2 },
			-- error_diagnostic_visible = { fg = colors.bright_red, bg = colors.dark2 },
			-- error_diagnostic_selected = { fg = colors.bright_red, bg = colors.gray },
			-- -- Warnings
			-- warning = { fg = colors.bright_yellow, bg = colors.dark2 },
			-- warning_visible = { fg = colors.bright_yellow, bg = colors.dark2 },
			-- warning_selected = { fg = colors.bright_yellow, bg = colors.gray, style = styles },
			-- warning_diagnostic = { fg = colors.bright_yellow, bg = colors.dark2 },
			-- warning_diagnostic_visible = { fg = colors.bright_yellow, bg = colors.dark2 },
			-- warning_diagnostic_selected = { fg = colors.bright_yellow, bg = colors.gray },
			-- -- Infos
			-- info = { fg = colors.bright_blue, bg = colors.dark2 },
			-- info_visible = { fg = colors.bright_blue, bg = colors.dark2 },
			-- info_selected = { fg = colors.bright_blue, bg = colors.gray, style = styles },
			-- info_diagnostic = { fg = colors.bright_blue, bg = colors.dark2 },
			-- info_diagnostic_visible = { fg = colors.bright_blue, bg = colors.dark2 },
			-- info_diagnostic_selected = { fg = colors.bright_blue, bg = colors.gray },
			-- -- Hint
			-- hint = { fg = colors.bright_aqua, bg = colors.dark2 },
			-- hint_visible = { fg = colors.bright_aqua, bg = colors.dark2 },
			-- hint_selected = { fg = colors.bright_aqua, bg = colors.gray, style = styles },
			-- hint_diagnostic = { fg = colors.bright_aqua, bg = colors.dark2 },
			-- hint_diagnostic_visible = { fg = colors.bright_aqua, bg = colors.dark2 },
			-- hint_diagnostic_selected = { fg = colors.bright_aqua, bg = colors.gray },
			-- -- Diagnostics
			-- diagnostic = { fg = colors.light1, bg = colors.dark2 },
			-- diagnostic_visible = { fg = colors.light1, bg = colors.dark2 },
			-- diagnostic_selected = { fg = colors.dark0, bg = colors.gray, style = styles },
			-- -- Modified
			-- modified = { fg = colors.bright_green, bg = colors.dark2 },
			-- modified_selected = { fg = colors.bright_green, bg = colors.gray },
		}
	}
	opts = vim.tbl_deep_extend("force", opts, catppuccin_hl_overwrite)

	require("modules.utils").load_plugin("bufferline", opts)
end
