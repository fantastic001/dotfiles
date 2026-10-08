require("editor.shared_vim_settings").source()
require("editor.indentation").configure()
require("editor.cursor").configure()
require("editor.terminal_keys").configure()
require("features.registry").configure_enabled(
    require("plugins.installer").install_all()
)
require("language_servers.diagnostics").configure()
require("language_servers.attach").register_buffer_setup()
require("language_servers.registry").enable_available_servers()


vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CheckTime" }, {
  callback = function()
    if vim.bo.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

