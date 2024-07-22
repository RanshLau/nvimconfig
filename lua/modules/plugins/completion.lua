return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    opts = require("completion.lsp").opts,
    config = require("completion.lsp").config,
    dependencies = {
      {
        "williamboman/mason.nvim"
      },
      {
        "williamboman/mason-lspconfig.nvim"
      },
      {
        "folke/neoconf.nvim"
      },
      {
        "Jint-lzxy/lsp_signature.nvim",
        config = require("completion.lsp-signature")
      }
    },
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    build = ":MasonUpdate",
    opts_extend = {
      "ensure_installed"
    },
    opts = require("completion.mason").opts,
    config = require("completion.mason").config
  },
  {

    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    config = require("completion.lspsaga"),
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    }
  },
  {
    "stevearc/aerial.nvim",
    lazy = true,
    event = "LspAttach",
    config = require("completion.aerial")
  },
  {
    "dnlhc/glance.nvim",
    lazy = true,
    event = "LspAttach",
    config = require("completion.glance")
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
    lazy = true,
    event = "LspAttach"
  },
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    config = require("completion.nvim-lint")
  },
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = {
      "CursorHold",
      "CursorHoldI"
    },
    cmd = "ConformInfo",
    opts = require("completion.conform").opts,
    init = require("completion.conform").init,
    config = require("completion.conform").setup,
    dependencies = {
      "mason.nvim"
    }
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    config = require("completion.cmp"),
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets"
        },
        config = require("completion.luasnip")
      },
      {
        "lukas-reineke/cmp-under-comparator"
      },
      {
        "saadparwaiz1/cmp_luasnip"
      },
      {
        "hrsh7th/cmp-nvim-lsp"
      },
      {
        "hrsh7th/cmp-nvim-lua"
      },
      {
        "andersevenrud/cmp-tmux"
      },
      {
        "hrsh7th/cmp-path"
      },
      {
        "f3fora/cmp-spell"
      },
      {
        "hrsh7th/cmp-buffer"
      },
      {
        "kdheepak/cmp-latex-symbols"
      },
      {
        "ray-x/cmp-treesitter"
      }
      -- { "tzachar/cmp-tabnine", build = "./install.sh", config = require("completion.tabnine") },
      -- {
      -- 	"jcdickinson/codeium.nvim",
      -- 	dependencies = {
      -- 		"nvim-lua/plenary.nvim",
      -- 		"MunifTanjim/nui.nvim",
      -- 	},
      -- 	config = require("completion.codeium"),
      -- },
    }
  }
}

