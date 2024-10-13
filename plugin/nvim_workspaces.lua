vim.api.nvim_create_user_command("MyFirstFunction", require("nvim_workspaces").hello, {})
vim.api.nvim_create_user_command("Test", 'echo "Testing"', {})
