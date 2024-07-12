return function()
    local function get_toggleterm_id(props)
        local id = ' ' .. vim.fn.bufname(props.buf) .. ' '
        return {{
            id,
            group = props.focused and 'FloatTitle' or 'Title'
        }}
    end

    local function is_toggleterm(bufnr)
        return vim.bo[bufnr].filetype == 'toggleterm'
    end

    local edgy_filetypes = {'neotest-output-panel', 'neotest-summary', 'noice', 'Trouble', 'OverseerList', 'Outline'}

    local edgy_titles = {
        ['neotest-output-panel'] = 'neotest',
        ['neotest-summary'] = 'neotest',
        noice = 'noice',
        Trouble = 'trouble',
        OverseerList = 'overseer',
        Outline = 'outline'
    }
    local function is_edgy_group(props)
        return vim.tbl_contains(edgy_filetypes, vim.bo[props.buf].filetype)
    end

    local function get_title(props)
        local title = ' ' .. edgy_titles[vim.bo[props.buf].filetype] .. ' '
        return {{
            title,
            group = props.focused and 'FloatTitle' or 'Title'
        }}
    end

    require("modules.utils").load_plugin("incline", {
        window = {
            zindex = 30,
            margin = {
                vertical = {
                    top = vim.o.laststatus == 3 and 0 or 1,
                    bottom = 0
                }, -- shift to overlap window borders
                horizontal = {
                    left = 0,
                    right = 2
                }
            }
        },
        ignore = {
            buftypes = {},
            filetypes = {'neo-tree'},
            unlisted_buffers = false
        },
        render = function(props)
            if is_toggleterm(props.buf) then
                return get_toggleterm_id(props)
            end

            if is_edgy_group(props) then
                return get_title(props)
            end
        end
    })
end
