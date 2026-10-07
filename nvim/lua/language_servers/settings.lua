local DISABLED_FLAG_VALUE = "off"
local FEATURE_FLAG_VARIABLE = "NVIM_LSP"
local PREFERENCE_VARIABLE_PREFIX = "NVIM_LSP_"

local M = {}

function M.is_lsp_enabled()
    return vim.env[FEATURE_FLAG_VARIABLE] ~= DISABLED_FLAG_VALUE
end

function M.server_preference_for_language(language, default_servers)
    local variable_name = PREFERENCE_VARIABLE_PREFIX .. language:upper()
    local override = vim.env[variable_name]
    if override and override ~= "" then
        return vim.split(override, ",", { trimempty = true })
    else
        return default_servers
    end
end

return M
