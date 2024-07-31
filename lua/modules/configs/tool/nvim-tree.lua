return function()
  local icons = {
    diagnostics = require("modules.utils.icons").get("diagnostics"),
    documents = require("modules.utils.icons").get("documents"),
    git = require("modules.utils.icons").get("git"),
    ui = require("modules.utils.icons").get("ui")
  }

  require("nvim-tree").setup({
    auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = false,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = true,
    open_on_tab = false,
    respect_buf_cwd = false,
    sort_by = "name",
    sync_root_with_cwd = true,
    on_attach = function(bufnr)
      require("nvim-tree.api").config.mappings.default_on_attach(bufnr)
      vim.keymap.del("n", "<C-e>", {
        buffer = bufnr
      })
    end,
    view = {
      adaptive_size = false,
      centralize_selection = false,
      width = 30,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      float = {
        enable = false,
        open_win_config = {
          relative = "editor",
          border = "single",
          width = 30,
          height = 30,
          row = 1,
          col = 1
        }
      }
    },
    renderer = {
      add_trailing = false,
      group_empty = true,
      highlight_git = true,
      full_name = false,
      highlight_opened_files = "none",
      special_files = {
        "Cargo.toml",
        "Makefile",
        "README.md",
        "readme.md",
        "CMakeLists.txt"
      },
      symlink_destination = true,
      indent_markers = {
        enable = true,
        icons = {
          corner = "└ ",
          edge = "│ ",
          item = "│ ",
          none = "  "
        }
      },
      root_folder_label = ":.:s?.*?/..?",
      icons = {
        webdev_colors = true,
        git_placement = "after",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true
        },
        padding = " ",
        symlink_arrow = " 󰁔 ",
        glyphs = {
          default = icons.documents.Default, -- 
          symlink = icons.documents.Symlink, -- 
          bookmark = icons.ui.Bookmark,
          git = {
            unstaged = icons.git.Mod_alt,
            staged = icons.git.Add, -- 󰄬
            unmerged = icons.git.Unmerged,
            renamed = icons.git.Rename, -- 󰁔
            untracked = icons.git.Untracked, -- "󰞋"
            deleted = icons.git.Remove, -- 
            ignored = icons.git.Ignore -- ◌
          },
          folder = {
            arrow_open = icons.ui.ArrowOpen,
            arrow_closed = icons.ui.ArrowClosed,
            -- arrow_open = "",
            -- arrow_closed = "",
            default = icons.ui.Folder,
            open = icons.ui.FolderOpen,
            empty = icons.ui.EmptyFolder,
            empty_open = icons.ui.EmptyFolderOpen,
            symlink = icons.ui.SymlinkFolder,
            symlink_open = icons.ui.FolderOpen
          }
        }
      }
    },
    hijack_directories = {
      enable = true,
      auto_open = true
    },
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = {}
    },
    filters = {
      dotfiles = false,
      custom = {
        ".DS_Store"
      },
      exclude = {}
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false
      },
      open_file = {
        quit_on_open = false,
        resize_window = false,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = {
              "notify",
              "qf",
              "diff",
              "fugitive",
              "fugitiveblame"
            },
            buftype = {
              "terminal",
              "help"
            }
          }
        }
      },
      remove_file = {
        close_window = true
      }
    },
    diagnostics = {
      enable = false,
      show_on_dirs = false,
      debounce_delay = 50,
      icons = {
        hint = icons.diagnostics.Hint_alt,
        info = icons.diagnostics.Information_alt,
        warning = icons.diagnostics.Warning_alt,
        error = icons.diagnostics.Error_alt
      }
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50
    },
    git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      timeout = 400
    },
    trash = {
      cmd = "gio trash",
      require_confirm = true
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false
      }
    }
  })

  local function open_in_system_file_manager()
    local lib = require("nvim-tree.lib")
    local node = lib.get_node_at_cursor()

    if node then
      local file_path = node.absolute_path
      local dir_path = vim.fn.fnamemodify(file_path, ':h')
      -- 适用于不同系统的打开文件管理器命令
      local open_cmd
      if vim.fn.has("mac") == 1 then
        open_cmd = 'open ' .. dir_path
      elseif vim.fn.has("unix") == 1 then
        open_cmd = 'xdg-open ' .. dir_path
      elseif vim.fn.has("win32") == 1 then
        open_cmd = 'explorer ' .. dir_path
      end

      if open_cmd then
        vim.fn.system(open_cmd)
      else
        LazyVim.warn("Unsupported system")
      end
    else
      LazyVim.warn("No file selected")
    end
  end

  vim.keymap.set('n', '<C-e>', open_in_system_file_manager, {
    noremap = true,
    silent = true
  })
end
