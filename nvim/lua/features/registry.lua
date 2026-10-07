local catalog = require("features.catalog")
local feature_flags = require("features.flags")

local DISABLED_FEATURES_VARIABLE = "NVIM_FEATURES_DISABLED"
local NO_DISABLED_FEATURES = {}

local M = {}

local function configure_feature(feature)
    local ok, error_message = pcall(function()
        require(feature.module).configure()
    end)
    if ok then
        return
    else
        vim.notify(
            "Feature " .. feature.name .. " failed: " .. tostring(error_message),
            vim.log.levels.ERROR
        )
    end
end

function M.configure_enabled(plugins_installed)
    if not plugins_installed then
        return
    end
    local disabled = feature_flags.list_from_environment(
        DISABLED_FEATURES_VARIABLE,
        NO_DISABLED_FEATURES
    )
    for _, feature in ipairs(catalog) do
        if not vim.list_contains(disabled, feature.name) then
            configure_feature(feature)
        end
    end
end

return M
