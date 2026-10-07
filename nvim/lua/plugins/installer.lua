local catalog = require("plugins.catalog")
local feature_flags = require("features.flags")

local FEATURE_FLAG_VARIABLE = "NVIM_PLUGINS"
local INSTALL_OPTIONS = { confirm = false }

local M = {}

function M.install_all()
    if not feature_flags.is_enabled(FEATURE_FLAG_VARIABLE) then
        return false
    end
    local ok, error_message = pcall(vim.pack.add, catalog, INSTALL_OPTIONS)
    if ok then
        return true
    else
        vim.notify(
            "Could not install plugins: " .. tostring(error_message),
            vim.log.levels.ERROR
        )
        return false
    end
end

return M
