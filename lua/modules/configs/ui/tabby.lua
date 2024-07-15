local M = {}

function M.config()
  local colors = require("gruvbox").palette

  local theme = {
    fill = { bg = colors.dark1 },
    -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
    head = { fg = colors.light0, bg = colors.dark2 },
    current_tab = { fg = colors.dark0, bg = colors.light1 },
    tab = { fg = colors.light0, bg = colors.dark2 },
    win = { fg = colors.light0, bg = colors.dark2 },
    tail = { fg = colors.light0, bg = colors.dark2 }
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

  vim.o.showtabline = 2
end

return M
