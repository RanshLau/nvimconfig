return function()
	local icons = { diagnostics = require("modules.utils.icons").get("diagnostics", true) }

	require("modules.utils").load_plugin("scrollview", {
		mode = "virtual",
		excluded_filetypes = { "NvimTree", "terminal", "nofile", "aerial" },
		winblend = 0,
		signs_on_startup = { "diagnostics", "folds", "marks", "search", "spell", "cursor" },
	})
end
