local PORT_PLACEHOLDER = "${port}"

return {
    codelldb = {
        type = "server",
        port = PORT_PLACEHOLDER,
        executable = {
            command = "codelldb",
            args = { "--port", PORT_PLACEHOLDER },
        },
    },
}
