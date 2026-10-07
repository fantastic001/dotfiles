local INDENT_WIDTH = tonumber(vim.env.NVIM_INDENT_WIDTH) or 4

local M = {}

local options = {
    tabstop = INDENT_WIDTH,
    shiftwidth = INDENT_WIDTH,
    softtabstop = INDENT_WIDTH,
    expandtab = true,
}

function M.configure()
    for name, value in pairs(options) do
        vim.opt[name] = value
    end
end

return M
