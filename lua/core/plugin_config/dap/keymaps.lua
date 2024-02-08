local M = {}

function M.setup()
  local keymap_options = { silent = true, noremap = true }

  -- Debug mappings
  vim.keymap.set("n", "<leader>dR", "<cmd>lua require'dap'.run_to_cursor()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dE", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dC", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dg", "<cmd>lua require'dap'.session()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dS", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", keymap_options)
  vim.keymap.set("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", keymap_options)

  -- Visual mode mappings
  vim.keymap.set("x", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", keymap_options)
end

return M
