local M = {}

function M.opts()
  local icons = {
    kind = LazyVim.icons.get("kind")
  }

  return {
    icons = {
      kinds = {
        symbols = {}
      }
    }
  }
end

return M
