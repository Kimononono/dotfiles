local DataModule = require('dev.testData')
local ListHarpoon = require('harpoon.list')
local listLRU = ListHarpoon:new()


print(vim.inspect(ListHarpoon))

local data = DataModule.Data:new()

print(vim.inspect(DataModule.data))

print(vim.fn.getcwd())
-- get absolute path of current file
local path = vim.fn.expand("%:p")
print(path)


-- use LRUCache to store filehistory to make sure hotkeys stay somewhat consistent
--

-- reassign key to use file absolute path 


-- Whenever buffer changes, update the LRUCache filehistory for the old buffer with the new buffer
--

--- @class HarpoonItem
--- @field value string
--- @field context any
--- @field lastUsed number

function getLastUsedFile(historyList)
    -- iterate through the historyList of HarpoonItems, if the lastUsed is the greatest, return that item

    local lastUsedIndex = 0
    for i, v in ipairs(historyList) do
        if v.lastUsed == nil then
            return v
        else if v.lastUsed > historyList[lastUsedIndex].lastUsed then
            lastUsedIndex = i
        end
        end
    end

    return lastUsedIndex
end

function updateHistoryList(historyList, item)
    -- iterate through the historyList of HarpoonItems, if the lastUsed is the greatest, return that item
    if historyList.length < data.maxCacheLength then
        item.lastUsed = os.time()
        historyList:append(item)
        return
    end

    local replaceIndex = nil
    replaceIndex = getLastUsedFile(historyList)

    if replaceIndex ~= nil then
        table.insert(historyList.items, replaceIndex, item)
        return
    end

    for _, v in ipairs(historyList) do
        -- may have issues if either are nil for some reason
        if item.value == v.value then
            v.lastUsed = os.time()
            return
        end
    end
end




function getLastUsedFile(historyList)
    local lastUsedIndex = 1 -- Default to the first item if none have lastUsed
    for i, v in ipairs(historyList) do
        if v.lastUsed ~= nil and (historyList[lastUsedIndex].lastUsed == nil or v.lastUsed > historyList[lastUsedIndex].lastUsed) then
            lastUsedIndex = i
        end
    end
    return lastUsedIndex
end

function updateHistoryList(historyList, item)
    if #historyList < data.maxCacheLength then
        table.insert(historyList, item)
    else
        local replaceIndex = getLastUsedFile(historyList)
        historyList[replaceIndex] = item
    end
    item.lastUsed = os.time()
end

function onBufferEnter()
    print("onBufferEnter called")
    local currentPath = vim.fn.expand('%:p') -- Gets the full path of the current buffer
    if currentPath == '' or currentPath == data.lastPath then
        return -- Do nothing if the current path is empty or the same as the last path
    end

    local newItem = {
        value = currentPath,
        lastUsed = os.time()
    }

    updateHistoryList(data.historyList, newItem)
    data.lastPath = currentPath
    print("Data last path: " .. data.lastPath)
end

PastBufferPath = vim.fn.expand('%:p')
TestValue = 0
-- Setting up the autocmd to listen for BufEnter event in NeoVim
function onBufferEnterTest()
    -- Get the current buffer path
    local currentBufferPath = vim.fn.expand('%:p')

    -- Check for nil values
    if currentBufferPath == nil or PastBufferPath == nil then
        print("One of the buffer paths is nil")
    else
        -- Print the past and current buffer paths
        print("Switched from: " .. PastBufferPath .. " to: " .. currentBufferPath)
    end

    -- Increment TestValue (if needed for debugging or other purposes)
    TestValue = TestValue + 1

    -- Update PastBufferPath with the current buffer path for the next event
    PastBufferPath = currentBufferPath
end

function onVimStart()
    print("onVimStart called")
    local currentPath = vim.fn.expand('%:p') -- Gets the full path of the current buffer
    if currentPath == '' then
        return -- Do nothing if the current path is empty or the same as the last path
    end

    PastBufferPath = currentPath
    print("Data last path: " .. PastBufferPath)
end




--vim.cmd('autocmd VimEnter * lua onVimStart()')
vim.cmd('autocmd BufEnter * lua onBufferEnterTest()')
vim.cmd('autocmd User TelescopeResumePost * lua onBufferEnterTest()')
vim.cmd('autocmd WinEnter * lua onBufferEnterTest()')




