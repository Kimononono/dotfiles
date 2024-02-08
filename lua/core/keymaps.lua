local vim = vim

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.smartindent = true
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.smartindent = true
vim.opt.cursorline = true
--vim.opt.textwidth = 80
--vim.opt.colorcolumn = '80'
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8


vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 1
vim.opt.foldenable = false

-- maKE BACKGROUND transparent and blurry
vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.opt.guifont = 'FiraCode Nerd Font:h12'



-- change line numbers to white

--vim.api.nvim_set_hl(0, 'LineNr', {fg='yellow' } )
--vim.api.nvim_set_hl( 'CursorLineNr', 'fg=#ffffff' )


vim.opt.swapfile = false

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
--vim.keymap.set('n', '<C-k>', '<C-w><up>')
--vim.keymap.set('n', '<C-j>','<C-w><down>')
--vim.keymap.set('n', '<C-h>' ,'<C-w><left>')
--vim.keymap.set('n', '<C-l>', '<C-w><right>')

vim.api.nvim_set_keymap('n', '0=', '^', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '0-', '0', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'vx', '<cmd>lua require("treesitter-unit").select()<cr>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })

-- vim set keymap of scroll wheel middle click to do nothing 
vim.api.nvim_set_keymap('n', '<MiddleMouse>', '<nop>', {})

-- disable scrollwheel
vim.api.nvim_set_keymap('n', '<ScrollWheelUp>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<S-ScrollWheelUp>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<C-ScrollWheelUp>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<ScrollWheelDown>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<S-ScrollWheelDown>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<C-ScrollWheelDown>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<ScrollWheelLeft>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<S-ScrollWheelLeft>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<C-ScrollWheelLeft>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<ScrollWheelRight>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<S-ScrollWheelRight>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<C-ScrollWheelRight>', '<nop>', {})

--:map <MiddleMouse> <Nop>
--:imap <MiddleMouse> <Nop>
-- Now in function vim api format
vim.api.nvim_set_keymap('n', '<MiddleMouse>', '<nop>', {})
vim.api.nvim_set_keymap('i', '<MiddleMouse>', '<nop>', {})


local on_exit = function(obj)
  print(obj.code)
  print(obj.signal)
  print(obj.stdout)
  print(obj.stderr)
    local lines = {}
    for line in obj.stdout:gmatch("([^\r\n]+)") do
        table.insert(lines, line)
    end

    -- Extract the last 6 lines
    local lastLines = {}
    for i = math.max(1, #lines - 5), #lines do
        table.insert(lastLines, lines[i])
    end

    -- Join the last 6 lines into a single string
    local lastLinesStr = table.concat(lastLines, "\n")

  vim.notify(lastLinesStr
  , vim.lsp.log_levels.INFO, {
    title = 'Build Status',
    timeout = 2000,
  })
  
end


DoBuild = function()
    vim.system({'nohup', '/home/hunte/programming/CodeFixGPT/uiTest/build.sh', '&'}, { text = true}, on_exit)
end
--vim.api.nvim_set_keymap('n', '<F4>', ':!nohup ~/programming/CodeFixGPT/uiTest/build.sh &<CR>', { noremap = true, silent = true })
-- open up terminal and run it
--vim.api.nvim_set_keymap('n', '<F5>', ':te nohup ~/programming/CodeFixGPT/uiTest/build.sh &', { noremap = true, silent = true })

-- run doBuild when f6 is pressed
vim.api.nvim_set_keymap('n', '<F4>', ':lua DoBuild()<CR>', { noremap = true, silent = true })




