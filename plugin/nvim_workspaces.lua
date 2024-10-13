vim.api.nvim_create_user_command("Open", require("nvim_workspaces").openFile, {nargs='?'})
vim.api.nvim_create_user_command("InitProject", require("nvim_workspaces").initProject, {})
