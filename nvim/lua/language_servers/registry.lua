local catalog = require("language_servers.catalog")
local settings = require("language_servers.settings")

local M = {}

local function is_server_executable_installed(server_name)
    local ok, config = pcall(function()
        return vim.lsp.config[server_name]
    end)
    if ok and config and type(config.cmd) == "table" then
        return vim.fn.executable(config.cmd[1]) == 1
    else
        return false
    end
end

local function find_first_installed_server(server_names)
    for _, server_name in ipairs(server_names) do
        if is_server_executable_installed(server_name) then
            return server_name
        end
    end
    return nil
end

function M.enable_available_servers()
    if not settings.is_lsp_enabled() then
        return
    end
    for language, default_servers in pairs(catalog) do
        local preferred = settings.server_preference_for_language(
            language,
            default_servers
        )
        local server_name = find_first_installed_server(preferred)
        if server_name then
            vim.lsp.enable(server_name)
        end
    end
end

return M
