local builtin = require('telescope.builtin')
local telescope = require ('telescope')
telescope.load_extension('dap')
--telescope.load_extension('dap')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fp', function()
	builtin.grep_string({ search = vim.fn.input('Find in Project:  ') })
end)
--vim.keymap.set('n', '<leader>df', telescope.extensions.dap.configurations, {})
--vim.keymap.set('n', '<leader>dc', telescope.extensions.dap.commands, {})


