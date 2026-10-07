local MATCHING_VARIABLE = "NVIM_COMPLETION_MATCHING"
local DEFAULT_MATCHING = "fuzzy"
local POPUP_OPTIONS = { "menu", "menuone", "noinsert", "popup" }

local matching_options = {
    fuzzy = { "fuzzy" },
    prefix = {},
}

local M = {}

local function selected_matching_options()
    local matching = vim.env[MATCHING_VARIABLE] or DEFAULT_MATCHING
    local options = matching_options[matching]
    if options then
        return options
    else
        vim.notify(
            "Unknown " .. MATCHING_VARIABLE .. "=" .. matching
                .. ", using " .. DEFAULT_MATCHING,
            vim.log.levels.WARN
        )
        return matching_options[DEFAULT_MATCHING]
    end
end

function M.resolve()
    return vim.list_extend(
        vim.list_slice(POPUP_OPTIONS),
        selected_matching_options()
    )
end

return M
