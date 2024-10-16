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

   excludedDirs=""
   for file in io.popen([[find ]] .. vim.fn.getcwd() .. [[ -type f]]):lines() do
      if(vim.fs.basename(file) == "workspace.config") then
         local f = io.open(file, "r")
         for line in io.lines(file) do
            if(string.sub(line,1,string.len("excludedDirs"))=="excludedDirs") then
               local dirs = string.match(line, "=(.*)")
               for dir in string.gmatch(dirs, '([^,]+)') do
                  excludedDirs = (excludedDirs .. [[ -not \( -path ]] .. vim.fn.getcwd() .. [[/]] ..dir .. [[ -prune \)]])
               end
               print(excludedDirs)
            end
         end
      end
   end

   if(found_config == 0) then
      --print("Did not find a config file")
   end

   local cmd = [[find ]] .. vim.fn.getcwd() .. excludedDirs
   for file in io.popen(cmd):lines() do
      M.file_map[vim.fs.basename(file)] = file
   end
end

return M
