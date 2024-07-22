local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local plug_map = {
  ["n|<A-F>"] = map_callback(function()
    LazyVim.format({
      force = true
    })
  end):with_silent():with_noremap():with_desc("formatter: Toggle format on save")
}

bind.nvim_load_mapping(plug_map)

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({
      severity = severity
    })
  end
end
local mapping = {}

function mapping.lsp(buf)
  local map = {
    -- LSP-related keymaps, ONLY effective in buffers with LSP(s) attached
    -- ["n|<leader>cm"] = map_cr("Mason"):with_desc("Mason"),
    ["n|<leader>li"] = map_cr("LspInfo"):with_silent():with_buffer(buf):with_desc("lsp: Info"),
    ["n|<leader>lr"] = map_cr("LspRestart"):with_silent():with_buffer(buf):with_nowait():with_desc("lsp: Restart"),
    ["n|go"] = map_cr("AerialToggle!"):with_silent():with_buffer(buf):with_desc("lsp: Toggle outline"),
    ["n|gto"] = map_callback(function()
      require("telescope").extensions.aerial.aerial()
    end):with_silent():with_buffer(buf):with_desc("lsp: Toggle outline in Telescope"),
    ["n|]d"] = map_cr("Lspsaga diagnostic_jump_next"):with_silent():with_buffer(buf):with_desc("lsp: Next diagnostic"),
    ["n|[d"] = map_cr("Lspsaga diagnostic_jump_prev"):with_silent():with_buffer(buf):with_desc("lsp: Prev diagnostic"),
    ["n|]e"] = map_callback(diagnostic_goto(true, "ERROR")):with_silent():with_buffer(buf):with_desc("lsp: Next error"),
    ["n|[e"] = map_callback(diagnostic_goto(false, "ERROR")):with_silent():with_buffer(buf):with_desc("lsp: Prev error"),
    ["n|]w"] = map_callback(diagnostic_goto(true, "WARN")):with_silent():with_buffer(buf):with_desc("lsp: Next warning"),
    ["n|[w"] = map_callback(diagnostic_goto(false, "WARN")):with_silent():with_buffer(buf)
      :with_desc("lsp: Prev warning"),
    ["n|]]"] = map_callback(function()
      LazyVim.lsp.words.jump(vim.v.count1)
    end):with_silent():with_buffer(buf):with_desc("lsp: Next Reference"),
    ["n|[["] = map_callback( function()
      LazyVim.lsp.words.jump(-vim.v.count1)
    end):with_silent():with_buffer(buf):with_desc("lsp: Prev Reference"),
    ["n|<leader>lx"] = map_cr("Lspsaga show_line_diagnostics ++unfocus"):with_silent():with_buffer(buf):with_desc(
      "lsp: Line diagnostic"),
    ["n|<leader>lh"] = map_callback(function()
      vim.lsp.buf.signature_help()
    end):with_desc("lsp: Signature help"),
    ["n|<leader>r"] = map_cr("Lspsaga rename"):with_silent():with_buffer(buf):with_desc("lsp: Rename in file range"),
    ["n|<leader>R"] = map_cr("Lspsaga rename ++project"):with_silent():with_buffer(buf):with_desc(
      "lsp: Rename in project range"),
    ["n|K"] = map_callback(function()
      vim.api.nvim_command('silent! Lspsaga hover_doc')
    end):with_silent():with_buffer(buf):with_desc("lsp: Show doc"),
    ["n|J"] = map_callback(function()
      vim.api.nvim_command('silent! Lspsaga show_line_diagnostics')
    end):with_silent():with_buffer(buf):with_desc("lsp: Show diagnostics"),
    ["nv|<leader>a"] = map_cr("Lspsaga code_action"):with_silent():with_buffer(buf):with_desc(
      "lsp: Code action for cursor"),
    ["n|gd"] = map_cr("Glance definitions"):with_silent():with_buffer(buf):with_desc("lsp: Preview definition"),
    ["n|gD"] = map_cr("Lspsaga goto_definition"):with_silent():with_buffer(buf):with_desc("lsp: Goto definition"),
    ["n|gr"] = map_cr("Glance references"):with_silent():with_buffer(buf):with_desc("lsp: Show reference"),
    ["n|gm"] = map_cr("Glance implementations"):with_silent():with_buffer(buf):with_desc("lsp: Show implementation"),
    ["n|<leader>lco"] = map_cr("Lspsaga incoming_calls"):with_silent():with_buffer(buf):with_desc(
      "lsp: Show incoming calls"),
    ["n|<leader>lci"] = map_cr("Lspsaga outgoing_calls"):with_silent():with_buffer(buf):with_desc(
      "lsp: Show outgoing calls")
  }
  bind.nvim_load_mapping(map)

  local ok, user_mappings = pcall(require, "user.keymap.completion")
  if ok and type(user_mappings.lsp) == "function" then
    require("modules.utils.keymap").replace(user_mappings.lsp(buf))
  end
end

return mapping
