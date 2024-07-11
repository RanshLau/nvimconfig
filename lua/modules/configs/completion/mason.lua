local M = {}
local icons = {
  ui = LazyVim.icons.get("ui", true),
  misc = LazyVim.icons.get("misc", true)
}

M.opts = {
  ui = {
    border = "single",
    icons = {
      package_pending = icons.ui.Modified_alt,
      package_installed = icons.ui.Check,
      package_uninstalled = icons.misc.Ghost
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>"
    }
  },
  ensure_installed = {
    "stylua",
    "shfmt"
  }
}

function M.config(_, opts)
  local mr = require("mason-registry")
  require("mason").setup(opts)
  mr:on("package:install:success", function()
    vim.defer_fn(function()
      -- trigger FileType event to possibly load this newly installed LSP server
      require("lazy.core.handler.event").trigger({
        event = "FileType",
        buf = vim.api.nvim_get_current_buf()
      })
    end, 100)
  end)

  mr.refresh(function()
    for _, tool in ipairs(opts.ensure_installed) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end

return M
