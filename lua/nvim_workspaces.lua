-- main module file
local module = require("nvim_workspaces.module")

---@class MyModule
local M = {}

M.file_map = {}

-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
   M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.openFile = function (opts)
   if(M.file_map[opts.args] == nil) then
      print("Could not find '" .. opts.args .. "'")
      return
   end
   vim.cmd('drop ' .. M.file_map[opts.args])
end

M.initProject = function()

   M.file_map = {}
   local found_config = 0

   for file in io.popen([[find ]] .. vim.fn.getcwd() .. [[ -type f]]):lines() do
      M.file_map[vim.fs.basename(file)] = file
      if(file == "workspace.config") then
         found_config = 1
      end
   end

   if(found_config == 0) then
      print("Did not find a config file")
      return
   end
end

return M
