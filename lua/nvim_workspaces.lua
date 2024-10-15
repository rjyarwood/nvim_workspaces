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
   name = string.gsub(opts.args, "%s+", "")
   if(M.file_map[name] == nil) then
      print("Could not find '" .. name .. "'")
      return
   end
   vim.cmd('drop ' .. M.file_map[name])
end

M.completeFileName = function(ArgLead, CmdLine, CursorPos) 

   ret = {}
   for key, val in pairs(M.file_map) do
      if(string.sub(key,1,string.len(ArgLead))==ArgLead) then
         table.insert(ret, key)
      end
   end

   return ret

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
