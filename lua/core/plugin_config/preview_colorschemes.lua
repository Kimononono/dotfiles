local preview_colorschem = {}

local function apply_edits()
    vim.api.nvim_set_hl(0, 'LineNr', { fg='green' } )
end

local function save_colorscheme()
    local colorscheme = vim.g.colors_name
    local file = io.open(vim.fn.stdpath('config') .. '/colorscheme.vim', 'w')
    if file then
        file:write('colorscheme ' .. colorscheme)
        file:close()
    end
end

local function load_colorscheme()
    local file = io.open(vim.fn.stdpath('config') .. '/colorscheme.vim', 'r')
    if file then
        local colorscheme = file:read("*a")
        file:close()
        vim.cmd(colorscheme)
        apply_edits()
    end
end

local function _preview_colorscheme()
    local cmdline = vim.fn.getcmdline()
    local cmdpos = vim.fn.getcmdpos()
    local cmd_parts = vim.split(cmdline, ' ')
    local cmd = cmd_parts[1]
    local arg = cmd_parts[2]

    if cmd ~= 'colorscheme' or cmdpos <= #cmd + 2 or not arg then
        return
    end

    local success, _ = pcall(vim.cmd, 'silent colorscheme ' .. arg)
    if success then
        vim.cmd('redraw!')
    end
end

preview_colorschem.setup = function()
    vim.cmd('augroup PreviewColorscheme')
    vim.cmd('autocmd!')
    vim.cmd('autocmd CmdlineChanged : lua require("core.plugin_config.preview_colorschemes")._preview_colorscheme()') 
    vim.cmd('autocmd ColorScheme * lua require("core.plugin_config.preview_colorschemes").save_colorscheme()') 
    vim.cmd('augroup END')

    load_colorscheme() 
end

preview_colorschem._preview_colorscheme = _preview_colorscheme
preview_colorschem.save_colorscheme = save_colorscheme 
preview_colorschem.load_colorscheme = load_colorscheme

return preview_colorschem

