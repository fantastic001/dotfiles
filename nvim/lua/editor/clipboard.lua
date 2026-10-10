local feature_flags = require("features.flags")

local FEATURE_FLAG_VARIABLE = "NVIM_CLIPBOARD"
local PROVIDER_VARIABLE = "NVIM_CLIPBOARD_PROVIDER"
local REGISTERS_VARIABLE = "NVIM_CLIPBOARD_REGISTERS"
local DEFAULT_REGISTERS = { "unnamedplus" }
local AUTOMATIC_PROVIDER = "auto"
local NATIVE_PROVIDER = "native"
local TERMINAL_PROVIDER = "osc52"
local REMOTE_SESSION_VARIABLE = "SSH_TTY"
local EXECUTABLE_FOUND = 1
local SYSTEM_REGISTERS = { "+", "*" }
local LAST_YANK_REGISTER = '"'
local LINE_SEPARATOR = "\n"
local TERMINAL_PROVIDER_NAME = "OSC 52"

local M = {}

local native_tools = {
    { executable = "pbcopy" },
    { executable = "wl-copy", display_variable = "WAYLAND_DISPLAY" },
    { executable = "xclip", display_variable = "DISPLAY" },
    { executable = "xsel", display_variable = "DISPLAY" },
    { executable = "win32yank.exe" },
}

local function is_environment_variable_set(variable_name)
    local value = vim.env[variable_name]
    return value ~= nil and value ~= ""
end

local function is_native_tool_usable(tool)
    if vim.fn.executable(tool.executable) ~= EXECUTABLE_FOUND then
        return false
    elseif tool.display_variable then
        return is_environment_variable_set(tool.display_variable)
    else
        return true
    end
end

local function is_any_native_tool_usable()
    for _, tool in ipairs(native_tools) do
        if is_native_tool_usable(tool) then
            return true
        end
    end
    return false
end

local function detect_provider()
    if is_environment_variable_set(REMOTE_SESSION_VARIABLE) then
        return TERMINAL_PROVIDER
    elseif is_any_native_tool_usable() then
        return NATIVE_PROVIDER
    else
        return TERMINAL_PROVIDER
    end
end

local function paste_last_yank()
    return {
        vim.split(vim.fn.getreg(LAST_YANK_REGISTER), LINE_SEPARATOR),
        vim.fn.getregtype(LAST_YANK_REGISTER),
    }
end

local function copy_through_terminal_escape_sequence()
    local terminal_clipboard = require("vim.ui.clipboard.osc52")
    local copy = {}
    local paste = {}
    for _, register in ipairs(SYSTEM_REGISTERS) do
        copy[register] = terminal_clipboard.copy(register)
        paste[register] = paste_last_yank
    end
    vim.g.clipboard = {
        name = TERMINAL_PROVIDER_NAME,
        copy = copy,
        paste = paste,
    }
end

local function keep_builtin_provider_detection() end

local provider_setups = {
    [AUTOMATIC_PROVIDER] = function()
        M.use_provider(detect_provider())
    end,
    [NATIVE_PROVIDER] = keep_builtin_provider_detection,
    [TERMINAL_PROVIDER] = copy_through_terminal_escape_sequence,
}

function M.use_provider(provider_name)
    local setup = provider_setups[provider_name]
    if setup then
        setup()
    else
        vim.notify(
            "Unknown clipboard provider: " .. tostring(provider_name),
            vim.log.levels.ERROR
        )
    end
end

function M.configure()
    if not feature_flags.is_enabled(FEATURE_FLAG_VARIABLE) then
        return
    end
    M.use_provider(vim.env[PROVIDER_VARIABLE] or AUTOMATIC_PROVIDER)
    vim.opt.clipboard = feature_flags.list_from_environment(
        REGISTERS_VARIABLE,
        DEFAULT_REGISTERS
    )
end

return M
