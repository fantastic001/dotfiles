local function call_jdtls(module_name, function_name)
    return function()
        require(module_name)[function_name]()
    end
end

return {
    { "<leader>tc", call_jdtls("jdtls.dap", "test_class"), "Java: test class" },
    {
        "<leader>tm",
        call_jdtls("jdtls.dap", "test_nearest_method"),
        "Java: test method",
    },
    { "<leader>tp", call_jdtls("jdtls.dap", "pick_test"), "Java: pick test" },
    {
        "<leader>jo",
        call_jdtls("jdtls", "organize_imports"),
        "Java: organize imports",
    },
    {
        "<leader>ju",
        call_jdtls("jdtls", "update_project_config"),
        "Java: reload Maven/Gradle project",
    },
}
