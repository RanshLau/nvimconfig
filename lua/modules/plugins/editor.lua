return {
  {
    "olimorris/persisted.nvim",
    lazy = true,
    cmd = {
      "SessionToggle",
      "SessionStart",
      "SessionStop",
      "SessionSave",
      "SessionLoad",
      "SessionLoadLast",
      "SessionLoadFromFile",
      "SessionDelete"
    },
    config = require("editor.persisted")
  },
  {
    "m4xshen/autoclose.nvim",
    lazy = true,
    event = "InsertEnter",
    config = require("editor.autoclose")
  },
  {
    "LunarVim/bigfile.nvim",
    lazy = false,
    config = require("editor.bigfile"),
    cond = require("core.settings").load_big_files_faster
  },
  {
    "ojroques/nvim-bufdel",
    lazy = true,
    cmd = {
      "BufDel",
      "BufDelAll",
      "BufDelOthers"
    }
  },
  {
    "folke/flash.nvim",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("editor.flash").config
  },
  {
    "numToStr/Comment.nvim",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("editor.comment")
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = {
      "DiffviewOpen",
      "DiffviewClose"
    },
    config = require("editor.diffview")
  },
  {

    "echasnovski/mini.align",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("editor.align")
  },
  {
    "tzachar/local-highlight.nvim",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("editor.local-highlight")
  },
  {
    "romainl/vim-cool",
    lazy = true,
    event = {
      "CursorMoved",
      "InsertEnter"
    }
  },
  {

    "lambdalisue/suda.vim",
    lazy = true,
    cmd = {
      "SudaRead",
      "SudaWrite"
    },
    init = require("editor.suda")
  },
  {
    "tpope/vim-sleuth",
    lazy = true,
    event = {
      "BufNewFile",
      "BufReadPost",
      "BufFilePost"
    }
  },
  {
    "nvim-pack/nvim-spectre",
    lazy = true,
    cmd = "Spectre"
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = true,
    event = {
      "CursorHoldI",
      "CursorHold"
    },
    config = require("editor.splits")
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    build = function()
      if #vim.api.nvim_list_uis() ~= 0 then
        vim.api.nvim_command([[TSUpdate]])
      end
    end,
    event = "BufReadPre",
    config = require("editor.treesitter"),
    dependencies = {
      -- {
      --   "andymass/vim-matchup"
      -- },
      {
        "nvim-treesitter/nvim-treesitter-textobjects"
      },
      {
        "windwp/nvim-ts-autotag",
        config = require("editor.autotag")
      },
      {
        "NvChad/nvim-colorizer.lua",
        config = require("editor.colorizer")
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = require("editor.ts-context")
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = require("editor.ts-context-commentstring")
      }
    }
  },
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    opts = require("editor.dropbar").opts
  }
}