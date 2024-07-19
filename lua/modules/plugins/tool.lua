return {
  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = {
      "Git",
      "G"
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeRefresh"
    },
    config = require("tool.nvim-tree")
  },
  {
    "ibhagwan/smartyank.nvim",
    lazy = true,
    event = "BufReadPost",
    config = require("tool.smartyank")
  },
  {
    "michaelb/sniprun",
    lazy = true,
    cmd = {
      "SnipRun",
      "SnipReset",
      "SnipInfo"
    },
    config = require("tool.sniprun")
  },
  -- {
  --   "akinsho/toggleterm.nvim",
  --   lazy = true,
  --   cmd = {
  --     "ToggleTerm",
  --     "ToggleTermSetName",
  --     "ToggleTermToggleAll",
  --     "ToggleTermSendVisualLines",
  --     "ToggleTermSendCurrentLine",
  --     "ToggleTermSendVisualSelection"
  --   },
  --   config = require("tool.toggleterm")
  -- },
  {
    "niuiic/terminal.nvim",
    lazy = true
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = {
      "Trouble",
      "TroubleToggle",
      "TroubleRefresh"
    },
    config = require("tool.trouble")
  },
  {
    "folke/which-key.nvim",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("tool.which-key")
  },
  {
    "gelguy/wilder.nvim",
    lazy = true,
    event = "CmdlineEnter",
    config = require("tool.wilder"),
    dependencies = {
      "romgrk/fzy-lua-native"
    }
  },
  {

    "max397574/better-escape.nvim",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("tool.better-escape")
  },
  ----------------------------------------------------------------------
  --                        Telescope Plugins                         --
  ----------------------------------------------------------------------
  {

    "nvim-telescope/telescope.nvim",
    lazy = false,
    cmd = "Telescope",
    config = require("tool.telescope"),
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons"
      },
      {
        "nvim-lua/plenary.nvim"
      },
      {
        "debugloop/telescope-undo.nvim"
      },
      {
        "ahmedkhalf/project.nvim",
        event = {
          "CursorHold",
          "CursorHoldI"
        },
        config = require("tool.project")
      },
      {
        "jvgrootveld/telescope-zoxide"
      },
      {
        "nvim-telescope/telescope-frecency.nvim"
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim"
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      }
    }
  },
  ----------------------------------------------------------------------
  --                           DAP Plugins                            --
  ----------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate"
    },
    config = require("tool.dap"),
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = require("tool.dap.dapui"),
        dependencies = {
          "nvim-neotest/nvim-nio"
        }
      },
      {
        "jay-babu/mason-nvim-dap.nvim"
      }
    }
  }
}

-- only for fcitx5 user who uses non-English language during coding
-- tool["pysan3/fcitx5.nvim"] = {
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	cond = vim.fn.executable("fcitx5-remote") == 1,
-- 	config = require("tool.fcitx5"),
-- }

