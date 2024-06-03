return function()
    local colors = require("gruvbox").palette

    require("modules.utils").load_plugin("gruvbox", {
        priority = 1000,
        config = true,
        overrides = {
            CursorLineNr = {
                fg = colors.yellow,
                bg = colors.dark0
            },
            WinSeparator = {
                fg = colors.gray
            },
            LineNr = {
                fg = colors.gray
            },
            SignColumn = {
                bg = colors.dark0
            },
            NvimTreeRootFolder = {
                fg = colors.bright_purple
            },
            NvimTreeFolderIcon = {
                fg = colors.bright_blue
            },
            NvimTreeExecFile = {
                fg = colors.bright_green
            },
            NvimTreeSpecialFile = {
                fg = colors.bright_yellow
            },
            NvimTreeImageFile = {
                fg = colors.bright_purple
            },
            NvimTreeGitDirty = {
                fg = colors.bright_yellow
            },
            NvimTreeGitStaged = {
                fg = colors.bright_yellow
            },
            NvimTreeGitMerge = {
                fg = colors.bright_purple
            },
            NvimTreeGitRenamed = {
                fg = colors.bright_purple
            },
            NvimTreeGitNew = {
                fg = colors.bright_yellow
            },
            NvimTreeGitDeleted = {
                fg = colors.bright_red
            },
            LspReferenceText = {
                bg = colors.dark4
            },
            PmenuSel = {
                fg = colors.dark3,
                bg = colors.light4
            },
            Delimiter = {
                fg = colors.light1
            }
        }
    })
end
