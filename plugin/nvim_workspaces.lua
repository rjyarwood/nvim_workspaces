vim.api.nvim_create_user_command("Open", require("nvim_workspaces").openFile, {nargs=1, complete=require("nvim_workspaces").completeFileName})
vim.api.nvim_create_user_command("InitProject", require("nvim_workspaces").initProject, {})
vim.api.nvim_create_autocmd("VimEnter", {callback=require('nvim_workspaces').initProject})
