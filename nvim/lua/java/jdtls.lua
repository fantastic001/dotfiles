local keymaps = require("java.keymaps")

local CLIENT_NAME = "jdtls"
local DAP_OPTIONS = { hotcodereplace = "auto" }

local M = {}

local function map_buffer_keys(buffer)
    for _, keymap in ipairs(keymaps) do
        local lhs, rhs, description = unpack(keymap)
        vim.keymap.set("n", lhs, rhs, { buffer = buffer, desc = description })
    end
end

local function enable_debugging()
    require("jdtls").setup_dap(DAP_OPTIONS)
    require("jdtls.dap").setup_dap_main_class_configs()
end

local function on_attach(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.name == CLIENT_NAME then
        enable_debugging()
        map_buffer_keys(event.buf)
    else
        return
    end
end

function M.configure()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("java_jdtls", {}),
        callback = on_attach,
    })
end

return M
