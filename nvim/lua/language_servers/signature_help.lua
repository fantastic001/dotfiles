local DOCUMENTATION_LINES_VARIABLE = "NVIM_SIGNATURE_DOC_LINES"
local DEFAULT_DOCUMENTATION_LINES = 10

local M = {}

local function documentation_lines()
    return tonumber(vim.env[DOCUMENTATION_LINES_VARIABLE])
        or DEFAULT_DOCUMENTATION_LINES
end

local function build_options()
    return {
        bind = true,
        doc_lines = documentation_lines(),
        floating_window = true,
        floating_window_above_cur_line = true,
        hint_enable = false,
        handler_opts = { border = "rounded" },
        select_signature_key = "<M-n>",
    }
end

function M.configure()
    require("lsp_signature").setup(build_options())
end

return M
