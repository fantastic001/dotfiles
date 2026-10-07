local function ask_for_executable()
    return vim.fn.input(
        "Executable: ",
        vim.fn.getcwd() .. "/",
        "file"
    )
end

local native_launch = {
    {
        name = "Launch executable",
        type = "codelldb",
        request = "launch",
        program = ask_for_executable,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}

return {
    c = native_launch,
    cpp = native_launch,
    rust = native_launch,
}
