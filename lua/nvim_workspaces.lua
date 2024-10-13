-- main module file
local module = require("nvim_workspaces.module")

---@class Config
---@field opt string Your config option
local config = {
  opt = "Hello!",
}

---@class MyModule
local M = {}

---@type Config
M.file_map = {}

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.hello = function()
  found_config = 0
  for dir in io.popen([[ls -pa ]] .. vim.fn.getcwd() .. [[| grep -v /]]):lines() do 
    print(dir) 
    M.file_map[dir] = vim.fn.getcwd() .. "/" .. dir
    if(dir == "workspace.config") then
      found_config = 1
    end
  end

  if(found_config == 1) then
    print("Found a config file")
  else
    print("Did not find a config file")
  end


end

return M
