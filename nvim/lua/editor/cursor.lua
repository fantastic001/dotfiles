local BLOCK_CURSOR_IN_ALL_MODES = "a:block"

local M = {}

function M.configure()
    vim.opt.guicursor = BLOCK_CURSOR_IN_ALL_MODES
end

return M
