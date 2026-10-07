local catalog = require("language_servers.catalog")
local settings = require("language_servers.settings")
local executables = require("language_servers.executables")

local M = {}

local function server_executable_name(server_name, config)
    if type(config.cmd) == "table" then
        return config.cmd[1]
    else
        return executables[server_name]
    end
end

local function is_server_executable_installed(server_name)
    local ok, config = pcall(function()
        return vim.lsp.config[server_name]
    end)
    if ok and config then
        local executable = server_executable_name(server_name, config)
        return executable ~= nil and vim.fn.executable(executable) == 1
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
