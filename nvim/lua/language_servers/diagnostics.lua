local M = {}

function M.configure()
    vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = { border = "rounded" },
    })
end

return M
