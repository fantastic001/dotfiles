local DISABLED_FLAG_VALUE = "off"

local M = {}

function M.is_enabled(variable_name)
    return vim.env[variable_name] ~= DISABLED_FLAG_VALUE
end

function M.list_from_environment(variable_name, default_value)
    local value = vim.env[variable_name]
    if value and value ~= "" then
        return vim.split(value, ",", { trimempty = true })
    else
        return default_value
    end
end

return M
