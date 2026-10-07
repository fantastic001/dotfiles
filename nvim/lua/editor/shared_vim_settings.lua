local SHARED_VIMRC_PATH = vim.fn.expand(
    vim.env.NVIM_SHARED_VIMRC or "~/.vimrc.common"
)

local M = {}

function M.source()
    if vim.fn.filereadable(SHARED_VIMRC_PATH) == 1 then
        vim.cmd.source(vim.fn.fnameescape(SHARED_VIMRC_PATH))
    else
        vim.notify(
            "Shared vim settings not found: " .. SHARED_VIMRC_PATH,
            vim.log.levels.WARN
        )
    end
end

return M
