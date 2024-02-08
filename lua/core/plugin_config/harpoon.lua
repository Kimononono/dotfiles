Harpoon = require('harpoon')
local Path = require("plenary.path")
Harpoon.setup({ settings = { save_on_ui_close = true, save_on_toggle = true, } })

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(Harpoon_files)
    local file_paths = {}
    for _, item in ipairs(Harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

local function toggle(item)
    local _self = Harpoon:list()
    item = item or _self.config.create_list_item(_self.config)

    if _self:get_by_display(item.value) then
        _self:remove(item)
    else
        _self:append(item)
    end
end

vim.keymap.set("n", "<leader>ha", function() Harpoon:list():append() end)
vim.keymap.set("n", "<leader>hh", function() Harpoon.ui:toggle_quick_menu(Harpoon:list()) end)
vim.keymap.set("n", "<leader>ht", function() toggle() end)

vim.keymap.set("n", "<leader><F1>", function() Harpoon:list():select(1) end)
vim.keymap.set("n", "<leader><F2>", function() Harpoon:list():select(2) end)
vim.keymap.set("n", "<leader><F3>", function() Harpoon:list():select(3) end)
vim.keymap.set("n", "<leader><F4>", function() Harpoon:list():select(4) end)
vim.keymap.set("n", "<leader><F5>", function() Harpoon:list():select(5) end)
vim.keymap.set("n", "<leader><F6>", function() Harpoon:list():select(6) end)
vim.keymap.set("n", "<leader><F7>", function() Harpoon:list():select(7) end)
vim.keymap.set("n", "<leader><F8>", function() Harpoon:list():select(8) end)
vim.keymap.set("n", "<leader><F9>", function() Harpoon:list():select(9) end)
vim.keymap.set("n", "<leader><F10>", function() Harpoon:list():select(10) end)
vim.keymap.set("n", "<leader><F11>", function() Harpoon:list():select(11) end)
vim.keymap.set("n", "<leader><F12>", function() Harpoon:list():select(12) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() Harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() Harpoon:list():next() end)

vim.keymap.set("n", "<C-e>", function() toggle_telescope(Harpoon:list()) end,
    { desc = "Open Harpoon window" })


Harpoon:extend({
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-v>", function()
      Harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-x>", function()
      Harpoon.ui:select_menu_item({ split = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-t>", function()
      Harpoon.ui:select_menu_item({ tabedit = true })
    end, { buffer = cx.bufnr })

  end,
})
