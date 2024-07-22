local M = {}

function M.config()
  vim.api.nvim_set_hl(0, "FlashLabel", {
    underline = true,
    bold = true,
    fg = "Orange",
    bg = "NONE",
    ctermfg = "Red",
    ctermbg = "NONE"
  })

  require("modules.utils").load_plugin("flash", {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    label = {
      -- allow uppercase labels
      uppercase = true,
      -- add a label for the first match in the current window.
      -- you can always jump to the first match with `<CR>`
      current = true,
      -- for the current window, label targets closer to the cursor first
      distance = true
    },
    modes = {
      -- options used when flash is activated through
      -- `f`, `F`, `t`, `T`, `;` and `,` motions
			search = {
				enabled = true,
			},
      char = {
        enabled = false,
        -- hide after jump when not using jump labels
        autohide = true,
        -- show jump labels
        jump_labels = true,
        -- set to `false` to use the current line only
        multi_line = false,
        -- When using jump labels, don't use these keys
        -- This allows using those keys directly after the motion
        label = {
          exclude = "hjkliardc"
        }
      }
    }
  })
end

return M
