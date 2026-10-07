local completion_options = require("language_servers.completion_options")

local COMPLETION_METHOD = "textDocument/completion"

local M = {}

local keymaps = {
    { "n", "gd", vim.lsp.buf.definition, "Go to definition" },
    { "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
    { "n", "<leader>f", vim.lsp.buf.format, "Format buffer" },
    { "i", "<C-Space>", vim.lsp.completion.get, "Trigger completion" },
}

local function map_buffer_keys(buffer)
    for _, keymap in ipairs(keymaps) do
        local mode, lhs, rhs, description = unpack(keymap)
        vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = description })
    end
end

local function enable_completion(client, buffer)
    if client:supports_method(COMPLETION_METHOD) then
        vim.lsp.completion.enable(
            true,
            client.id,
            buffer,
            { autotrigger = true }
        )
    else
        return
    end
end

local function on_attach(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client then
        enable_completion(client, event.buf)
        map_buffer_keys(event.buf)
    else
        return
    end
end

function M.register_buffer_setup()
    vim.opt.completeopt = completion_options.resolve()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("language_servers_attach", {}),
        callback = on_attach,
    })
end

return M
