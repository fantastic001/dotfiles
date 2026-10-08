local uv = vim.uv or vim.loop

local NO_WATCH_FLAGS = {}
local FILE_BUFFER_TYPE = ""

local M = {}

local watchers_by_buffer = {}

local function is_watchable_file_buffer(buffer)
    if not vim.api.nvim_buf_is_valid(buffer) then
        return false
    else
        local path = vim.api.nvim_buf_get_name(buffer)
        return vim.bo[buffer].buftype == FILE_BUFFER_TYPE
            and path ~= ""
            and uv.fs_stat(path) ~= nil
    end
end

local function report_watch_failure(buffer, error_message)
    vim.notify(
        "File watcher for buffer " .. buffer .. " failed: "
            .. tostring(error_message),
        vim.log.levels.ERROR
    )
end

local function rearm_after_file_replacement(buffer, on_change, events)
    if events and events.rename then
        M.watch(buffer, on_change)
    else
        return
    end
end

local function handle_watch_event(buffer, on_change, watch_error, events)
    if not watch_error then
        on_change(buffer)
        rearm_after_file_replacement(buffer, on_change, events)
    else
        report_watch_failure(buffer, watch_error)
        M.unwatch(buffer)
    end
end

local function start_watcher(buffer, on_change)
    local watcher = uv.new_fs_event()
    local started, error_message = watcher:start(
        vim.api.nvim_buf_get_name(buffer),
        NO_WATCH_FLAGS,
        vim.schedule_wrap(function(watch_error, _, events)
            handle_watch_event(buffer, on_change, watch_error, events)
        end)
    )
    if started then
        watchers_by_buffer[buffer] = watcher
    else
        watcher:close()
        report_watch_failure(buffer, error_message)
    end
end

function M.unwatch(buffer)
    local watcher = watchers_by_buffer[buffer]
    if watcher then
        watchers_by_buffer[buffer] = nil
        watcher:stop()
        watcher:close()
    else
        return
    end
end

function M.watch(buffer, on_change)
    M.unwatch(buffer)
    if is_watchable_file_buffer(buffer) then
        start_watcher(buffer, on_change)
    else
        return
    end
end

function M.unwatch_all()
    for buffer, _ in pairs(watchers_by_buffer) do
        M.unwatch(buffer)
    end
end

return M
