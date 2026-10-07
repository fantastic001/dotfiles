local feature_flags = require("features.flags")
local installer = require("tools.installer")
local language_server_registry = require("language_servers.registry")

local AUTOINSTALL_FLAG_VARIABLE = "NVIM_TOOLS_AUTOINSTALL"
local INSTALL_TIMEOUT_VARIABLE = "NVIM_TOOLS_INSTALL_TIMEOUT_MS"
local DEFAULT_INSTALL_TIMEOUT_MILLISECONDS = 600000
local POLL_INTERVAL_MILLISECONDS = 500

local M = {}

local function install_timeout_milliseconds()
    return tonumber(vim.env[INSTALL_TIMEOUT_VARIABLE])
        or DEFAULT_INSTALL_TIMEOUT_MILLISECONDS
end

local function install_missing_and_enable_servers()
    installer.install_missing(
        language_server_registry.enable_available_servers
    )
end

function M.configure()
    require("mason").setup()
    vim.api.nvim_create_user_command(
        "ToolsInstall",
        install_missing_and_enable_servers,
        { desc = "Install missing language servers and debuggers" }
    )
    if feature_flags.is_enabled(AUTOINSTALL_FLAG_VARIABLE) then
        install_missing_and_enable_servers()
    else
        return
    end
end

local function do_nothing() end

function M.install_missing_and_wait()
    local installation = installer.install_missing(do_nothing)
    vim.wait(install_timeout_milliseconds(), function()
        return installation:is_finished()
    end, POLL_INTERVAL_MILLISECONDS)
    return installation:is_finished()
end

return M
