local DOCUMENTATION_LINES_VARIABLE = "NVIM_SIGNATURE_DOC_LINES"
local DEFAULT_DOCUMENTATION_LINES = 10
local SIGNATURE_TOGGLE_KEY = "<C-k>"

local M = {}

local function documentation_lines()
    return tonumber(vim.env[DOCUMENTATION_LINES_VARIABLE])
        or DEFAULT_DOCUMENTATION_LINES
end

local function build_options()
    return {
        bind = true,
        doc_lines = documentation_lines(),
        floating_window = false,
        floating_window_above_cur_line = true,
        hint_enable = false,
        handler_opts = { border = "rounded" },
        select_signature_key = "<M-n>",
        toggle_key = SIGNATURE_TOGGLE_KEY,
    }
end

local function map_normal_mode_signature_key()
    vim.keymap.set(
        "n",
        SIGNATURE_TOGGLE_KEY,
        vim.lsp.buf.signature_help,
        { desc = "Show signature help" }
    )
end

function M.configure()
    require("lsp_signature").setup(build_options())
    map_normal_mode_signature_key()
end

return M
