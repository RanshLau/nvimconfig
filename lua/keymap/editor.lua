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
    return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)") or
             et("<Plug>(comment_toggle_linewise_count)")
  end):with_silent():with_noremap():with_expr():with_desc("edit: Toggle comment for line"),
  ["n|gcb"] = map_callback(function()
    return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)") or
             et("<Plug>(comment_toggle_blockwise_count)")
  end):with_silent():with_noremap():with_expr():with_desc("edit: Toggle comment for block"),
  ["n|gcC"] = map_cmd("<Plug>(comment_toggle_linewise)"):with_silent():with_noremap():with_desc(
    "edit: Toggle comment for line with operator"),
  ["n|gcB"] = map_cmd("<Plug>(comment_toggle_blockwise)"):with_silent():with_noremap():with_desc(
    "edit: Toggle comment for block with operator"),
  ["v|gc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)"):with_silent():with_noremap():with_desc(
    "edit: Toggle comment for line with selection"),
  ["v|gcb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)"):with_silent():with_noremap():with_desc(
    "edit: Toggle comment for block with selection"),

  -- Plugin: diffview.nvim
  ["n|<leader>gd"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
  ["n|<leader>gD"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),

  -- Plugin: flash.nvim
  ["no|f"] = map_callback(function()
    return require("flash").jump({
      search = {
        forward = true,
        wrap = false,
        multi_window = false
      }
    })
  end):with_silent():with_noremap():with_desc("flash: Goto chars"),
  ["no|F"] = map_callback(function()
    return require("flash").jump({
      search = {
        forward = false,
        wrap = false,
        multi_window = false
      }
    })
  end):with_silent():with_noremap():with_desc("flash: Goto chars"),
  ["n|s"] = map_callback(function()
    return require("flash").jump({
      pattern = vim.fn.expand("<cword>")
    })
  end):with_silent():with_noremap():with_desc("flash: jump to word"),
  ["n|S"] = map_callback(function()
    return require("flash").jump({
      search = {
        mode = function(str)
          return "\\<" .. str
        end
      }
    })
  end):with_silent():with_noremap():with_desc("flash: jump to word"),
  ["vo|s"] = map_callback(function()
    return require("flash").treesitter()
  end):with_silent():with_noremap():with_desc("flash: treesitter select"),
  ["vo|S"] = map_callback(function()
    return require("flash").treesitter_search()
  end):with_silent():with_noremap():with_desc("flash: treesitter search select"),
  ["nvo|<leader>j"] = map_callback(function()
    return require("flash").jump({
      search = {
        mode = "search",
        max_length = 0
      },
      label = {
        after = {
          0,
          0
        }
      },
      pattern = "^"
    })
  end):with_silent():with_noremap():with_desc("flash: Jump to a line"),

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
  end):with_silent():with_noremap():with_desc("editn: Toggle search & replace panel"),
  ["n|gsp"] = map_callback(function()
    require("spectre").open_visual({
      select_word = true
    })
  end):with_silent():with_noremap():with_desc("editn: search&replace current word (project)"),
  ["v|gsp"] = map_callback(function()
    require("spectre").open_visual()
  end):with_silent():with_noremap():with_desc("edit: search & replace current word (project)"),
  ["n|gsf"] = map_callback(function()
    require("spectre").open_file_search({
      select_word = true
    })
  end):with_silent():with_noremap():with_desc("editn: search & replace current word (file)"),

  -- Plugin dropbar.nvim
  ["n|<leader>dp"] = map_callback(function()
    require("dropbar.api").pick()
  end):with_silent():with_noremap():with_desc("dropbar: pick winbar item"),
  ["n|gu"] = map_callback(function()
    require("dropbar.api").goto_context_start()
  end):with_silent():with_noremap():with_desc("dropbar: up to context start"),
  ["n|gn"] = map_callback(function()
    require("dropbar.api").select_next_context()
  end):with_silent():with_noremap():with_desc("dropbar: goto next context start"),
}

bind.nvim_load_mapping(plug_map)
