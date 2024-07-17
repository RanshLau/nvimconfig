local M = {}

function M.config()
  local colors = require("gruvbox").palette

  local theme = {
    fill = {
      bg = colors.dark1
    },
    head = {
      fg = colors.dark0,
      bg = colors.gray
    },
    current_tab = {
      fg = colors.dark0,
      bg = colors.light2
    },
    tab = {
      fg = colors.light0,
      bg = colors.dark2
    },
    win = {
      fg = colors.light0,
      bg = colors.dark2
    },
    tail = {
      fg = colors.dark0,
      bg = colors.gray
    }
  }

  local cwd = function()
    return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " "
  end

  local line = function(line)
    return {
      {
        {
          cwd(),
          hl = theme.head
        },
        line.sep('', theme.head, theme.fill)
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab

        return {
          line.sep('', hl, theme.fill),
          " 󰄮 ",
          tab.number(),
          tab.close_btn(""),
          line.sep('', hl, theme.fill),
          hl = hl,
          margin = " "
        }
      end),
      line.spacer(),

      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        return {
          line.sep('', theme.win, theme.fill),
          win.is_current() and '󰡖' or '󰄱',
          win.buf_name(),
          line.sep('', theme.win, theme.fill),
          hl = theme.win,
          margin = ' '
        }
      end),

      {
        line.sep('', theme.tail, theme.fill),
        {
          "  ",
          hl = theme.tail
        }
      },
      hl = theme.fill
    }
  end

  require("tabby").setup({
    line = line
    -- option = {}, -- setup modules' option,
  })

  vim.o.showtabline = 2
end

return M
