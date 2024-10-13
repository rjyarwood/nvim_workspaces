---@class CustomModule
local M = {}

---@return string
M.my_first_function = function(greeting)
  return vim.api.nvim_err_write(vim.fn.getcwd())
end

return M
