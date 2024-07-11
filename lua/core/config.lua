local M = {}

M.json = {
  version = 6,
  path = vim.g.lazyvim_json or vim.fn.stdpath("config") .. "/lazyvim.json",
  data = {
    version = nil, ---@type string?
    news = {}, ---@type table<string, string>
    extras = {} ---@type string[]
  }
}

function M.json.load()
  local f = io.open(M.json.path, "r")
  if f then
    local data = f:read("*a")
    f:close()
    local ok, json = pcall(vim.json.decode, data, {
      luanil = {
        object = true,
        array = true
      }
    })
    if ok then
      M.json.data = vim.tbl_deep_extend("force", M.json.data, json or {})

      if M.json.data.version ~= M.json.version then
        LazyVim.json.migrate()
      end
    end
  end
end

function M.init()
  -- autocmds can be loaded lazily when not opening a file
  local group = vim.api.nvim_create_augroup("LazyVim", {
    clear = true
  })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "VeryLazy",
    callback = function()
      LazyVim.format.setup()
      LazyVim.root.setup()

      vim.api.nvim_create_user_command("LazyExtras", function()
        LazyVim.extras.show()
      end, {
        desc = "Manage LazyVim extras"
      })

      vim.api.nvim_create_user_command("LazyHealth", function()
        vim.cmd([[Lazy! load all]])
        vim.cmd([[checkhealth]])
      end, {
        desc = "Load all plugins and run :checkhealth"
      })

      local health = require("lazy.health")
      vim.list_extend(health.valid, {
        "recommended",
        "desc",
        "vscode"
      })
    end
  })

  -- delay notifications till vim.notify was replaced or after 500ms
  LazyVim.lazy_notify()

  if vim.g.deprecation_warnings == false then
    vim.deprecate = function()
    end
  end

  LazyVim.plugin.setup()
  M.json.load()
end

---@param buf? number
---@return string[]?
function M.get_kind_filter(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local ft = vim.bo[buf].filetype
  if M.kind_filter == false then
    return
  end
  if M.kind_filter[ft] == false then
    return
  end
  if type(M.kind_filter[ft]) == "table" then
    return M.kind_filter[ft]
  end
  ---@diagnostic disable-next-line: return-type-mismatch
  return type(M.kind_filter) == "table" and type(M.kind_filter.default) == "table" and M.kind_filter.default or nil
end

-- M.did_init = false
-- function M.init()
--   if M.did_init then
--     return
--   end
--   M.did_init = true
--   local plugin = require("lazy.core.config").spec.plugins.LazyVim
--   if plugin then
--     vim.opt.rtp:append(plugin.dir)
--   end

--   -- delay notifications till vim.notify was replaced or after 500ms
--   LazyVim.lazy_notify()

--   -- load options here, before lazy init while sourcing plugin modules
--   -- this is needed to make sure options will be correctly applied
--   -- after installing missing plugins
--   M.load("options")

--   if vim.g.deprecation_warnings == false then
--     vim.deprecate = function()
--     end
--   end

--   LazyVim.plugin.setup()
--   M.json.load()
-- end

LazyVim.config = M

M.init()
