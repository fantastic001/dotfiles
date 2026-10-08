require("editor.shared_vim_settings").source()
require("editor.indentation").configure()
require("editor.cursor").configure()
require("editor.terminal_keys").configure()
require("editor.external_changes").configure()
require("features.registry").configure_enabled(
    require("plugins.installer").install_all()
)
require("language_servers.diagnostics").configure()
require("language_servers.attach").register_buffer_setup()
require("language_servers.registry").enable_available_servers()

-- Open a terminal in a horizontal split below
vim.keymap.set('n', '<leader>th', ':botright split | terminal<CR>', { desc = 'Terminal horizontal split' })
-- Open a terminal in a vertical split to the right
vim.keymap.set('n', '<leader>tv', ':botright vsplit | terminal<CR>', { desc = 'Terminal vertical split' })
-- Open terminal with claude cli - ask user for input and pass it to the claude command
vim.keymap.set('n', '<leader>ch', ':botright split | terminal claude<CR>', { desc = 'Terminal with claude cli' })
vim.keymap.set('n', '<leader>cv', ':botright vsplit | terminal claude<CR>', { desc = 'Terminal with claude cli' })

