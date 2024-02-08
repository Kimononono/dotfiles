local builtin = require('telescope.builtin')
local utils = require('telescope.utils')


local function telescopeProjectIgnore(ignore_patterns)
    local ignore_cmd = 'require("telescope").setup{defaults = {file_ignore_patterns = ' .. vim.inspect(ignore_patterns) .. '}}'

    if vim.fn.filereadable('.telescopeignore') == 1 then
        ignore_cmd = ignore_cmd .. ' require("telescope").load_extension("fzy_native")'
    end

    vim.cmd(ignore_cmd)
end

vim.cmd([[command! -nargs=* TelescopeIgnore lua telescopeProjectIgnore(<f-args>) ]])


Current_Directory = ""
local default_actions = require('telescope.actions.state')
local actions = {}
actions.set_cwd_as_default_text = function(prompt_bufnr)
    local entry = default_actions.get_selected_entry()
    if entry == nil then
      Current_Directory = ""
      return
    end
    local fullPath = entry[1]
    local directoryPath = string.match(fullPath, "(.*/)")
    if directoryPath == nil then
        directoryPath = ""
    end
    print("directoryPath: " .. directoryPath .. " Current_Directory: " .. Current_Directory)
    if directoryPath == Current_Directory then
        Current_Directory = ""
    else
        Current_Directory = directoryPath
    end

    --print("Current_Directory Before: " .. Current_Directory)
    --print("Current_Directory After: " .. Current_Directory)
    --actions._close(prompt_bufnr, true)
    --builtin.find_files({ default_text = cwd })
end
actions.reset_cwd = function(prompt_bufnr)
    Current_Directory = ""
end


require('telescope').setup{
    defaults = {
        file_ignore_patterns = { '%.pyc', '__pycache__', 'venv', 'node%_modules/.*' },
    },
    pickers = {
      find_files = {
        mappings = {
          n = {
            ["<C-s>"] = actions.set_cwd_as_default_text,
            ["<C-~>"] = actions.reset_cwd,
          },
          i = {
            ["<C-s>"] = actions.set_cwd_as_default_text,
            ["<C-~>"] = actions.reset_cwd,
          },
        },
      },
    },
}

function printShit() 
    print("yoyoyoyoy")
end


-- uses builtin.find_files with a default_text 

--require('telescope.builtin').find_files({ default_text="bonjovie" })

-- add keymap for Ctrl-~ to reset the default_text
--vim.keymap.set('n', '<C-~>', ":lua printShit()", { })

vim.keymap.set('n', '<Space>ff', function() builtin.find_files({ default_text=Current_Directory}) end, {}) --function() builtin.find_files({ cwd = utils.buffer_dir() }) end, {})
vim.keymap.set('n', '<Space>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>fw', builtin.live_grep, {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
vim.api.nvim_set_keymap('n', '<Space>fr', ":lua require('telescope.builtin').lsp_references()<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<Space><Space>fb', builtin.buffers, {})
-- <Space>ft is taken by treesitter
vim.keymap.set('n', '<Space>ft', builtin.treesitter, {})
