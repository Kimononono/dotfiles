require('test')

print("YO THIS FROM DEV IN THE NEOVIM ")

print(vim.api.nvim_buf_get_name(
    vim.api.nvim_get_current_buf()
))


--print(vim.inspect(require('harpoon').list("/home/hunte/programming/messAround/eyeballtrack/gaze-estimation")))


--function getScopedHarpoonStack(path, stack) 
    -- Check if their is a JumpList associated with the path
    -- if so, add it to the stack

    -- if the parent directory is not the root directory
    -- Recursively call this function on the parent directory
    -- and add the result to the stack
--end


function getHarpoonStack(path)
    local stack = {}
    local parent = vim.fn.fnamemodify(path, ":h")
    local parentIsRoot = parent == path
    local parentIsHome = parent == vim.fn.expand("$HOME")

    if parentIsRoot or parentIsHome then
        return stack
    end

    local parentStack = getHarpoonStack(parent)
    for _, v in ipairs(parentStack) do
        table.insert(stack, v)
    end

    local harpoonList = require('harpoon').list(parent)
    for _, v in ipairs(harpoonList) do
        table.insert(stack, v)
    end

    return stack
end





