return function()
    require("modules.utils").load_plugin("mini.indentscope", {
        symbol = "▏",
        options = {
            try_as_border = true
        }
    })
end
