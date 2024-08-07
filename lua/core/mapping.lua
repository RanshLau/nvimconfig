local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local core_map = {
  -- Suckless
  ["n|<S-Tab>"] = map_cr("normal za"):with_noremap():with_silent():with_desc("edit: Toggle code fold"),
  ["n|<C-s>"] = map_cu("write"):with_noremap():with_silent():with_desc("edit: Save file"),
  ["n|Y"] = map_cmd("y$"):with_desc("edit: Yank text to EOL"),
  ["n|D"] = map_cmd("d$"):with_desc("edit: Delete text to EOL"),
  ["n|n"] = map_cmd("nzzzv"):with_noremap():with_desc("edit: Next search result"),
  ["n|N"] = map_cmd("Nzzzv"):with_noremap():with_desc("edit: Prev search result"),
  ["n|J"] = map_cmd("mzJ`z"):with_noremap():with_desc("edit: Join next line"),
  ["n|<Esc>"] = map_callback(function()
    _flash_esc_or_noh()
  end):with_noremap():with_silent():with_desc("edit: Clear search highlight"),
  ["n|<C-h>"] = map_cmd("<C-w>h"):with_silent():with_noremap():with_desc("window: Focus left"),
  ["n|<C-l>"] = map_cmd("<C-w>l"):with_silent():with_noremap():with_desc("window: Focus right"),
  ["n|<C-j>"] = map_cmd("<C-w>j"):with_silent():with_noremap():with_desc("window: Focus down"),
  ["n|<C-k>"] = map_cmd("<C-w>k"):with_silent():with_noremap():with_desc("window: Focus up"),
  ["t|<C-h>"] = map_cmd("<Cmd>wincmd h<CR>"):with_silent():with_noremap():with_desc("window: Focus left"),
  ["t|<C-l>"] = map_cmd("<Cmd>wincmd l<CR>"):with_silent():with_noremap():with_desc("window: Focus right"),
  ["t|<C-j>"] = map_cmd("<Cmd>wincmd j<CR>"):with_silent():with_noremap():with_desc("window: Focus down"),
  ["t|<C-k>"] = map_cmd("<Cmd>wincmd k<CR>"):with_silent():with_noremap():with_desc("window: Focus up"),
  ["n|<C-Left>"] = map_cr("vertical resize -3"):with_silent():with_desc("window: Resize -3 vertically"),
  ["n|<C-Right>"] = map_cr("vertical resize +3"):with_silent():with_desc("window: Resize +3 vertically"),
  ["n|<C-Down>"] = map_cr("resize -3"):with_silent():with_desc("window: Resize -3 horizontally"),
  ["n|<C-Up>"] = map_cr("resize +3"):with_silent():with_desc("window: Resize +3 horizontally"),
  ["n|<C-q>"] = map_cr("wq"):with_desc("edit: Save file and quit"),
  ["n|<A-S-q>"] = map_cr("q!"):with_desc("edit: Force quit"),
  ["n|<leader>o"] = map_cr("setlocal spell! spelllang=en,cjk"):with_desc("edit: Toggle spell check"),
  ["n|tn"] = map_cr("tabnew"):with_noremap():with_silent():with_desc("tab: Create a new tab"),
  ["n|tk"] = map_cr("tabnext"):with_noremap():with_silent():with_desc("tab: Move to next tab"),
  ["n|tj"] = map_cr("tabprevious"):with_noremap():with_silent():with_desc("tab: Move to previous tab"),
  ["n|to"] = map_cr("tabonly"):with_noremap():with_silent():with_desc("tab: Only keep current tab"),
  ["n|<A-j>"] = map_cmd("<cmd>m .+1<cr>=="):with_desc("edit: Move this line down"),
  ["n|<A-k>"] = map_cmd("<cmd>m .-2<cr>=="):with_desc("edit: Move this line up"),
  ["n|<leader>`"] = map_cmd("<cmd>e #<cr>"):with_desc("Prev Buffer"),
  ["n|[b"] = map_cmd("<cmd>bprevious<cr>"):with_desc("Next Buffer"),
  ["n|]b"] = map_cmd("<cmd>bnext<cr>"):with_desc("Switch to Other Buffer"),
  ["n|q"] = map_cmd("<Esc>"):with_silent(),
  -- Insert mode
  ["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap():with_desc("edit: Delete previous block"),
  ["i|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Move cursor to left"),
  ["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap():with_desc("edit: Move cursor to line start"),
  ["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("edit: Save file"),
  ["i|<C-q>"] = map_cmd("<Esc>:wq<CR>"):with_desc("edit: Save file and quit"),
  ["i|<A-j>"] = map_cmd("<esc><cmd>m .+1<cr>==gi"):with_desc("edit: Move this line down"),
  ["i|<A-k>"] = map_cmd("<esc><cmd>m .-2<cr>==gi"):with_desc("edit: Move this line up"),
  ["i|jk"] = map_cmd("<Esc>"):with_silent(),
  -- Command mode
  ["c|<C-h>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Left"),
  ["c|<C-l>"] = map_cmd("<Right>"):with_noremap():with_desc("edit: Right"),
  ["c|<C-i>"] = map_cmd("<Home>"):with_noremap():with_desc("edit: Home"),
  ["c|<C-a>"] = map_cmd("<End>"):with_noremap():with_desc("edit: End"),
  ["c|<C-d>"] = map_cmd("<Del>"):with_noremap():with_desc("edit: Delete"),
  ["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap():with_desc(
    "edit: Complete path of current file"),
  -- Visual mode
  ["v|q"] = map_cmd("<Esc>"):with_noremap():with_silent(),
  ["v|<A-j>"] = map_cmd(":m '>+1<CR>gv=gv"):with_desc("edit: Move this line down"),
  ["v|<A-k>"] = map_cmd(":m '<-2<CR>gv=gv"):with_desc("edit: Move this line up"),
  ["v|<"] = map_cmd("<gv"):with_desc("edit: Decrease indent"),
  ["v|>"] = map_cmd(">gv"):with_desc("edit: Increase indent")
}

bind.nvim_load_mapping(core_map)
