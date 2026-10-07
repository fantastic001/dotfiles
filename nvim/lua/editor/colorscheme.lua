local COLORSCHEME_VARIABLE = "NVIM_COLORSCHEME"
local BACKGROUND_VARIABLE = "NVIM_BACKGROUND"
local DEFAULT_COLORSCHEME = "vscode"
local DEFAULT_BACKGROUND = "dark"

local M = {}

local colorscheme_setups = {
    vscode = function(background)
        require("vscode").setup({
            style = background,
            italic_comments = true,
            italic_inlayhints = true,
        })
    end,
}

local function setup_colorscheme(name, background)
    local setup = colorscheme_setups[name]
    if setup then
        setup(background)
    else
        return
    end
end

function M.configure()
    local name = vim.env[COLORSCHEME_VARIABLE] or DEFAULT_COLORSCHEME
    local background = vim.env[BACKGROUND_VARIABLE] or DEFAULT_BACKGROUND
    vim.o.background = background
    setup_colorscheme(name, background)
    local ok, error_message = pcall(vim.cmd.colorscheme, name)
    if ok then
        return
    else
        vim.notify(
            "Could not load colorscheme " .. name .. ": "
                .. tostring(error_message),
            vim.log.levels.ERROR
        )
    end
end

return M
