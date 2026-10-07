local function call_dap(function_name)
    return function()
        require("dap")[function_name]()
    end
end

local function toggle_dap_ui()
    require("dapui").toggle()
end

return {
    { "<F5>", call_dap("continue"), "Debug: continue" },
    { "<F10>", call_dap("step_over"), "Debug: step over" },
    { "<F11>", call_dap("step_into"), "Debug: step into" },
    { "<F12>", call_dap("step_out"), "Debug: step out" },
    { "<leader>b", call_dap("toggle_breakpoint"), "Debug: breakpoint" },
    { "<leader>dr", call_dap("repl_open"), "Debug: open REPL" },
    { "<leader>dq", call_dap("terminate"), "Debug: terminate" },
    { "<leader>du", toggle_dap_ui, "Debug: toggle UI" },
}
