local buffer_file_watchers = require("editor.buffer_file_watchers")
local feature_flags = require("features.flags")

local AUGROUP_NAME = "ReloadExternallyChangedFiles"
local FILE_WATCHERS_FLAG_VARIABLE = "NVIM_FILE_WATCHERS"
local COMMAND_LINE_MODE = "c"
local CHECK_ALL_BUFFERS_EVENTS = {
    "FocusGained",
    "BufEnter",
    "WinEnter",
    "CursorHold",
    "CursorHoldI",
    "TermLeave",
    "TermClose",
}
local START_WATCHING_EVENTS = {
    "BufReadPost",
    "BufWritePost",
    "BufFilePost",
    "FileChangedShellPost",
}
local STOP_WATCHING_EVENTS = { "BufUnload", "BufDelete", "BufWipeout" }

local M = {}

local function is_in_command_line_mode()
    return vim.api.nvim_get_mode().mode:sub(1, 1) == COMMAND_LINE_MODE
end

local function check_timestamps(checktime_arguments)
    if is_in_command_line_mode() then
        return
    else
        local ok, error_message = pcall(vim.cmd.checktime, checktime_arguments)
        if not ok then
            vim.notify(
                "checktime failed: " .. tostring(error_message),
                vim.log.levels.ERROR
            )
        else
            return
        end
    end
end

local function check_buffer_timestamp(buffer)
    check_timestamps({ args = { tostring(buffer) } })
end

local function check_all_buffer_timestamps()
    check_timestamps({})
end

local function notify_reloaded(event)
    vim.notify(
        "Reloaded externally changed file: " .. event.file,
        vim.log.levels.INFO
    )
end

local function register_timestamp_checks(group)
    vim.api.nvim_create_autocmd(CHECK_ALL_BUFFERS_EVENTS, {
        group = group,
        callback = check_all_buffer_timestamps,
    })
    vim.api.nvim_create_autocmd("FileChangedShellPost", {
        group = group,
        callback = notify_reloaded,
    })
end

local function register_file_watchers(group)
    vim.api.nvim_create_autocmd(START_WATCHING_EVENTS, {
        group = group,
        callback = function(event)
            buffer_file_watchers.watch(event.buf, check_buffer_timestamp)
        end,
    })
    vim.api.nvim_create_autocmd(STOP_WATCHING_EVENTS, {
        group = group,
        callback = function(event)
            buffer_file_watchers.unwatch(event.buf)
        end,
    })
    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = group,
        callback = buffer_file_watchers.unwatch_all,
    })
end

local function watch_already_loaded_buffers()
    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buffer) then
            buffer_file_watchers.watch(buffer, check_buffer_timestamp)
        else
            buffer_file_watchers.unwatch(buffer)
        end
    end
end

function M.configure()
    vim.opt.autoread = true
    local group = vim.api.nvim_create_augroup(AUGROUP_NAME, { clear = true })
    register_timestamp_checks(group)
    if feature_flags.is_enabled(FILE_WATCHERS_FLAG_VARIABLE) then
        register_file_watchers(group)
        watch_already_loaded_buffers()
    else
        buffer_file_watchers.unwatch_all()
    end
end

return M
