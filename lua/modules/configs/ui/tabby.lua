local M = {}

function M.config()
  local colors = require('gruvbox').palette

  print(vim.inspect(colors))

  local theme = {
    fill = {
      fg = colors.light1,
      bg = colors.dark0
    },
    -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
    head = {
      fg = colors.light1,
      bg = colors.dark0
    },
    current_tab = {
      fg = colors.light1,
      bg = colors.dark0
    },
    tab = {
      fg = colors.light1,
      bg = colors.dark0
    },
    win = {
      fg = colors.light1,
      bg = colors.dark0
    },
    tail = {
      fg = colors.light1,
      bg = colors.dark0
    }
  }

  require("tabby").setup({
    line = function(line)
      return {
        {
          {
            '  ',
            hl = theme.head
          },
          line.sep('', theme.head, theme.fill)
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            line.sep('', hl, theme.fill),
            tab.is_current() and '' or '󰆣',
            tab.number(),
            tab.name(),
            tab.close_btn(''),
            line.sep('', hl, theme.fill),
            hl = hl,
            margin = ' '
          }
        end),
        line.spacer(),
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
          return {
            line.sep('', theme.win, theme.fill),
            win.is_current() and '' or '',
            win.buf_name(),
            line.sep('', theme.win, theme.fill),
            hl = theme.win,
            margin = ' '
          }
        end),
        {
          line.sep('', theme.tail, theme.fill),
          {
            '  ',
            hl = theme.tail
          }
        },
        hl = theme.fill
      }
    end
    -- option = {}, -- setup modules' option,
  })
end

return M
