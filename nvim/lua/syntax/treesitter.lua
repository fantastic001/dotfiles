local parsers = require("syntax.parsers")

local TREE_SITTER_EXECUTABLE = "tree-sitter"
local INSTALL_TIMEOUT_VARIABLE = "NVIM_PARSERS_INSTALL_TIMEOUT_MS"
local DEFAULT_INSTALL_TIMEOUT_MILLISECONDS = 600000
local LEGACY_SYNTAX_FILETYPES = { "csv", "tsv" }

local M = {}

local function start_highlighting(buffer)
    if vim.list_contains(LEGACY_SYNTAX_FILETYPES, vim.bo[buffer].filetype) then
        return
    end
    local ok = pcall(vim.treesitter.start, buffer)
    if ok then
        return
    else
        return
    end
end

local function highlight_loaded_buffers()
    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buffer) then
            start_highlighting(buffer)
        end
    end
end

local function install_parsers()
    if vim.fn.executable(TREE_SITTER_EXECUTABLE) == 1 then
        return require("nvim-treesitter").install(parsers)
    else
        vim.notify(
            "tree-sitter CLI not found yet, run :ToolsInstall and restart",
            vim.log.levels.WARN
        )
        return nil
    end
end

function M.configure()
    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("syntax_treesitter", {}),
        callback = function(event)
            start_highlighting(event.buf)
        end,
    })
    local installation = install_parsers()
    if installation then
        installation:await(vim.schedule_wrap(highlight_loaded_buffers))
    else
        return
    end
end

function M.install_parsers_and_wait()
    local installation = install_parsers()
    if installation then
        installation:wait(
            tonumber(vim.env[INSTALL_TIMEOUT_VARIABLE])
                or DEFAULT_INSTALL_TIMEOUT_MILLISECONDS
        )
    else
        return
    end
end

return M
