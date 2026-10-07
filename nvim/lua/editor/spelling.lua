local feature_flags = require("features.flags")

local FEATURE_FLAG_VARIABLE = "NVIM_SPELL"
local LANGUAGES_VARIABLE = "NVIM_SPELL_LANGUAGES"
local DEFAULT_LANGUAGES = { "en", "sr" }
local SPLIT_CAMEL_CASE_WORDS = "camel"

local M = {}

function M.configure()
    if not feature_flags.is_enabled(FEATURE_FLAG_VARIABLE) then
        return
    end
    vim.opt.spelllang = feature_flags.list_from_environment(
        LANGUAGES_VARIABLE,
        DEFAULT_LANGUAGES
    )
    vim.opt.spelloptions = SPLIT_CAMEL_CASE_WORDS
    vim.opt.spell = true
end

return M
