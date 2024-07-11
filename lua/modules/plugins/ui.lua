-- ui["dstein64/nvim-scrollview"] = {
--     lazy = true,
--     event = {"BufReadPost", "BufAdd", "BufNewFile"},
--     config = require("ui.scrollview")
--
return {
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({
          plugins = {
            "dressing.nvim"
          }
        })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({
          plugins = {
            "dressing.nvim"
          }
        })
        return vim.ui.input(...)
      end
    end
  },
  {
    "goolord/alpha-nvim",
    lazy = true,
    event = "BufWinEnter",
    config = require("ui.alpha")
  },
  {
    "akinsho/bufferline.nvim",
    lazy = true,
    event = {
      "BufReadPost",
      "BufAdd",
      "BufNewFile"
    },
    config = require("ui.bufferline")
  },
  {
    "RanshLau/gruvbox.nvim",
    lazy = false,
    name = "gruvbox",
    config = require("ui.gruvbox")
  },
  {
    "j-hui/fidget.nvim",
    lazy = true,
    event = "LspAttach",
    config = require("ui.fidget")
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("ui.gitsigns")
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = {
      "BufReadPost",
      "BufAdd",
      "BufNewFile"
    },
    config = require("ui.lualine")
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    event = "VeryLazy",
    config = require("ui.notify")
  },
  {
    "folke/paint.nvim",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("ui.paint")
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("ui.todo"),
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },
  {
    "echasnovski/mini.indentscope",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("ui.indentscope"),
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "dashboard",
          "alpha",
          "neo-tree",
          "nvimtree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm"
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end
      })
    end
  },
  {
    "b0o/incline.nvim",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("ui.incline")
  }
}
