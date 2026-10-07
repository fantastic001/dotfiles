local adapters = require("debugging.adapters")
local configurations = require("debugging.configurations")
local keymaps = require("debugging.keymaps")

local LISTENER_NAME = "debugging_ui"

local M = {}

local function register_adapters(dap)
    for name, adapter in pairs(adapters) do
        dap.adapters[name] = adapter
    end
end

local function register_configurations(dap)
    for filetype, filetype_configurations in pairs(configurations) do
        dap.configurations[filetype] = filetype_configurations
    end
end

local function map_keys()
    for _, keymap in ipairs(keymaps) do
        local lhs, rhs, description = unpack(keymap)
        vim.keymap.set("n", lhs, rhs, { desc = description })
    end
end

local function open_ui_with_sessions(dap, dapui)
    local function open_ui()
        dapui.open()
    end
    local function close_ui()
        dapui.close()
    end
    dap.listeners.after.event_initialized[LISTENER_NAME] = open_ui
    dap.listeners.before.event_terminated[LISTENER_NAME] = close_ui
    dap.listeners.before.event_exited[LISTENER_NAME] = close_ui
end

function M.configure()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()
    register_adapters(dap)
    register_configurations(dap)
    open_ui_with_sessions(dap, dapui)
    map_keys()
end

return M
