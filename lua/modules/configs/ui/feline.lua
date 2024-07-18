local M = {}

function M.config()
  local fmt = string.format
  local palette = require("gruvbox").palette

  local vi = {
    -- Map vi mode to text name
    text = {
      n = "NORMAL",
      no = "NORMAL",
      i = "INSERT",
      v = "VISUAL",
      V = "V-LINE",
      [""] = "V-BLOCK",
      c = "COMMAND",
      cv = "COMMAND",
      ce = "COMMAND",
      R = "REPLACE",
      Rv = "REPLACE",
      s = "SELECT",
      S = "SELECT",
      [""] = "SELECT",
      t = "TERMINAL"
    },

    -- Maps vi mode to highlight group color defined above
    colors = {
      n = {
        fg = palette.dark0,
        bg = palette.gray
      },
      no = {
        fg = palette.dark0,
        bg = palette.gray
      },
      i = {
        fg = palette.dark0,
        bg = palette.bright_blue
      },
      v = {
        fg = palette.dark0,
        bg = palette.bright_orange
      },
      V = {
        fg = palette.dark0,
        bg = palette.bright_orange
      },
      [""] = {
        fg = palette.dark0,
        bg = palette.bright_orange
      },
      R = {
        fg = palette.dark0,
        bg = palette.bright_red
      },
      Rv = {
        fg = palette.dark0,
        bg = palette.bright_red
      },
      r = {
        fg = palette.dark0,
        bg = palette.bright_red
      },
      rm = {
        fg = palette.dark0,
        bg = palette.bright_red
      },
      s = {
        fg = palette.dark0,
        bg = palette.bright_aqua
      },
      S = {
        fg = palette.dark0,
        bg = palette.bright_aqua
      },
      [""] = {
        fg = palette.dark0,
        bg = palette.bright_aqua
      },
      c = {
        fg = palette.dark0,
        bg = palette.bright_green
      },
      ["!"] = {
        fg = palette.dark0,
        bg = palette.bright_green
      },
      t = {
        fg = palette.dark0,
        bg = palette.bright_green
      }
    },

    -- Maps vi mode to seperator highlight goup defined above
    sep = {
      n = {
        fg = palette.gray,
        bg = palette.dark1
      },
      no = {
        fg = palette.gray,
        bg = palette.dark1
      },
      i = {
        fg = palette.bright_blue,
        bg = palette.dark1
      },
      v = {
        fg = palette.bright_orange,
        bg = palette.dark1
      },
      V = {
        fg = palette.bright_orange,
        bg = palette.dark1
      },
      [""] = {
        fg = palette.bright_orange,
        bg = palette.dark1
      },
      R = {
        fg = palette.bright_red,
        bg = palette.dark1
      },
      Rv = {
        fg = palette.bright_red,
        bg = palette.dark1
      },
      r = {
        fg = palette.bright_red,
        bg = palette.dark1
      },
      rm = {
        fg = palette.bright_red,
        bg = palette.dark1
      },
      s = {
        fg = palette.bright_aqua,
        bg = palette.dark1
      },
      S = {
        fg = palette.bright_aqua,
        bg = palette.dark1
      },
      [""] = {
        fg = palette.bright_aqua,
        bg = palette.dark1
      },
      c = {
        fg = palette.bright_green,
        bg = palette.dark1
      },
      ["!"] = {
        fg = palette.bright_green,
        bg = palette.dark1
      },
      t = {
        fg = palette.bright_green,
        bg = palette.dark1
      }
    }
  }

  local icons = {
    locker = "", -- #f023
    page = "☰", -- 2630
    line_number = "", -- e0a1
    connected = "", -- f817
    dos = "", -- e70f
    unix = "", -- f17c
    mac = "", -- f179
    mathematical_L = "𝑳",
    vertical_bar = "┃",
    vertical_bar_thin = "│",
    left = "",
    right = "",
    block = "█",
    left_filled = "",
    right_filled = "",
    slant_left = "",
    slant_left_thin = "",
    slant_right = "",
    slant_right_thin = "",
    slant_left_2 = "",
    slant_left_2_thin = "",
    slant_right_2 = "",
    slant_right_2_thin = "",
    left_rounded = "",
    left_rounded_thin = "",
    right_rounded = "",
    right_rounded_thin = "",
    circle = "●"
  }

  ---Get the number of diagnostic messages for the provided severity
  ---@param str string [ERROR | WARN | INFO | HINT]
  ---@return string
  local function get_diag(str)
    local diagnostics = vim.diagnostic.get(0, {
      severity = vim.diagnostic.severity[str]
    })
    local count = #diagnostics

    return (count > 0) and " " .. count .. " " or ""
  end

  ---Get highlight group from vi mode
  ---@return string
  local function vi_mode_hl()
    local hl = vi.colors[vim.fn.mode()]
    hl.style = "bold"
    return hl
  end

  ---Get sep highlight group from vi mode
  local function vi_sep_hl()
    return vi.sep[vim.fn.mode()]
  end

  ---Get the path of the file relative to the cwd
  ---@return string
  local function file_info()
    local list = {}
    if vim.bo.readonly then
      table.insert(list, "🔒")
    end

    if vim.bo.modified then
      table.insert(list, "●")
    end

    table.insert(list, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:."))

    return table.concat(list, " ") .. " "
  end

  local function cursor_percentage()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local percentage = math.floor((current_line / total_lines) * 100)
    local percentage_str = string.format("%d%%%%", percentage)
    local max_length = 5 -- 假设最大长度为 "100%" (4个字符)
    local padding = string.rep(" ", max_length - #percentage_str)

    return "  " .. padding .. percentage_str .. " "
  end

  local function indent_provider()
    local expandtab = vim.api.nvim_buf_get_option(0, 'expandtab')
    local tabstop = vim.api.nvim_buf_get_option(0, 'tabstop')
    local shiftwidth = vim.api.nvim_buf_get_option(0, 'shiftwidth')
    local indent_type = expandtab and 'SP' or 'TB'
    local indent_size = expandtab and shiftwidth or tabstop

    return string.format(" %s: %d ", indent_type, indent_size)
  end

  -- Create a table that contians every status line commonent
  local c = {
    vimode = {
      provider = function()
        return fmt(" %s ", vi.text[vim.fn.mode()])
      end,
      hl = vi_mode_hl,
      right_sep = {
        str = " ",
        hl = vi_sep_hl
      }
    },
    fileinfo = {
      provider = {
        name = "file_info",
        opts = {
          type = "relative",
          colored_icon = false
        }
      },
      hl = {
        fg = palette.bright_blue,
        bg = palette.dark1,
        style = "bold"
      }
    },
    gitbranch = {
      provider = function()
        local git = require('feline.providers.git')
        local branch = git.git_branch()
        local s
        if #branch > 0 then
          s = string.format("  %s ", branch)
        else
          s = string.format(" %s ", "Untracked")
        end

        return s
      end,
      hl = {
        fg = palette.light0,
        bg = palette.dark0,
        style = 'bold'
      },
      left_sep = {
        str = " " .. icons.slant_left,
        hl = {
          fg = palette.dark0,
          bg = palette.dark1
        }
      },
      enabled = function()
        return vim.b.gitsigns_status_dict ~= nil
      end
    },
    git_add = {
      provider = function()
        local gitsigns = vim.b.gitsigns_status_dict
        return gitsigns.added ~= 0 and fmt("+%d ", gitsigns.added) or ""
      end,
      hl = {
        fg = palette.bright_green,
        bg = palette.dark0,
        style = "bold"
      },
      enabled = function()
        return vim.b.gitsigns_status_dict ~= nil
      end
    },
    git_change = {
      provider = function()
        local gitsigns = vim.b.gitsigns_status_dict
        return gitsigns.changed ~= 0 and fmt("~%d ", gitsigns.changed) or ""
      end,
      hl = {
        fg = palette.bright_yellow,
        bg = palette.dark0,
        style = "bold"
      },
      enabled = function()
        return vim.b.gitsigns_status_dict ~= nil
      end
    },
    git_remove = {
      provider = function()
        local gitsigns = vim.b.gitsigns_status_dict
        return gitsigns.removed ~= 0 and fmt("-%d ", gitsigns.removed) or ""
      end,
      hl = {
        fg = palette.bright_red,
        bg = palette.dark0,
        style = "bold"
      },
      right_sep = {
        str = icons.slant_right,
        hl = {
          fg = palette.dark0,
          bg = palette.dark1
        },
        always_visible = true
      },
      enabled = function()
        return vim.b.gitsigns_status_dict ~= nil
      end
    },
    file_enc = {
      provider = function()
        local os = icons[vim.bo.fileformat] or ""
        return fmt(" %s %s ", os, vim.bo.fileencoding)
      end,
      hl = {
        fg = palette.light0,
        bg = palette.dark2
      },
      left_sep = {
        str = icons.left_filled,
        hl = {
          fg = palette.dark2,
          bg = palette.dark1
        }
      }
    },
    file_type = {
      provider = function()
        return fmt(" %s ", vim.bo.filetype:upper())
      end,
      hl = {
        fg = palette.bright_aqua,
        bg = palette.dark2,
        style = "bold"
      }
    },
    indent_info = {
      provider = indent_provider,
      hl = {
        fg = palette.light0,
        bg = palette.dark1,
        style = "bold"
      },
      left_sep = {
        str = icons.left_filled,
        hl = {
          fg = palette.dark1,
          bg = palette.dark2
        }
      }
    },
    cur_position = {
      provider = function()
        return fmt("  %3d:%-2d ", unpack(vim.api.nvim_win_get_cursor(0)))
      end,
      hl = {
        fg = palette.dark0,
        bg = palette.gray,
        style = "bold"
      },
      left_sep = {
        str = icons.left_filled,
        hl = {
          fg = palette.gray,
          bg = palette.dark1
        }
      }
    },
    cursor_percentage = {
      provider = cursor_percentage,
      hl = {
        fg = palette.dark0,
        bg = palette.gray,
        style = "bold"
      },
      left_sep = {
        str = icons.left,
        hl = {
          fg = palette.dark0,
          bg = palette.gray
        }
      }
    },
    scroll_bar = {
      provider = {
        name = "scroll_bar",
        opts = {
          reverse = true
        }
      },
      hl = {
        fg = palette.bright_yellow,
        bg = palette.gray
      }

    },
    lsp_error = {
      provider = function()
        return get_diag("ERROR")
      end,
      hl = {
        fg = palette.dark0,
        bg = palette.bright_red
      },
      left_sep = {
        str = "",
        hl = {
          fg = palette.bright_red,
          bg = palette.dark1
        },
        always_visible = true
      }
    },
    lsp_warn = {
      provider = function()
        return get_diag("WARN")
      end,
      hl = {
        fg = palette.dark0,
        bg = palette.bright_yellow
      },
      left_sep = {
        str = "",
        hl = {
          fg = palette.bright_yellow,
          bg = palette.bright_red
        },
        always_visible = true
      }
    },

    lsp_hint = {
      provider = function()
        return get_diag("HINT")
      end,
      hl = {
        fg = palette.dark0,
        bg = palette.bright_aqua
      },
      left_sep = {
        str = "",
        hl = {
          fg = palette.bright_aqua,
          bg = palette.bright_yellow
        },
        always_visible = true
      }
    },

    lsp_info = {
      provider = function()
        return get_diag("INFO")
      end,
      hl = {
        fg = palette.dark0,
        bg = palette.bright_blue
      },
      left_sep = {
        str = "",
        hl = {
          fg = palette.bright_blue,
          bg = palette.bright_aqua
        },
        always_visible = true
      },
      right_sep = {
        str = "",
        hl = {
          fg = palette.dark1,
          bg = palette.bright_blue
        },
        always_visible = true
      }
    },

    file_winbar = {
      provider = file_info,
      hl = "Comment"
    }
  }

  local active = {
    { -- left
      c.vimode,
      c.fileinfo,
      c.gitbranch,
      c.git_add,
      c.git_change,
      c.git_remove
    },
    { -- right
      c.lsp_error,
      c.lsp_warn,
      c.lsp_hint,
      c.lsp_info,
      c.file_enc,
      c.file_type,
      c.indent_info,
      c.cur_position,
      c.cursor_percentage,
      c.scroll_bar
    }
  }

  local inactive = {
    { -- left
      c.vimode,
      c.fileinfo,
      c.gitbranch
    },
    {
      c.cur_position
    } -- right
  }

  require("feline").setup({
    components = {
      active = active,
      inactive = inactive
    },
    highlight_reset_triggers = {},
    force_inactive = {
      filetypes = {
        "packer",
        "dap-repl",
        "dapui_scopes",
        "dapui_stacks",
        "dapui_watches",
        "dapui_repl",
        "qf",
        "help"
      },
      buftypes = {
        'terminal',
        'nofile'
      }
    },
    disable = {
      filetypes = {
        "dashboard",
        "startify"
      }
    }
  })
end

return M
