local JAVA_HOME_VARIABLES = { "NVIM_JAVA_HOME", "JAVA_HOME" }
local FALLBACK_JAVA_HOMES = {
    "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home",
    "/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home",
    "/usr/lib/jvm/default",
    "/usr/lib/jvm/default-java",
}

local M = {}

local function has_java_executable(java_home)
    return vim.fn.executable(java_home .. "/bin/java") == 1
end

local function candidate_java_homes()
    local candidates = {}
    for _, variable_name in ipairs(JAVA_HOME_VARIABLES) do
        local value = vim.env[variable_name]
        if value and value ~= "" then
            table.insert(candidates, value)
        end
    end
    return vim.list_extend(candidates, FALLBACK_JAVA_HOMES)
end

function M.java_home()
    for _, candidate in ipairs(candidate_java_homes()) do
        if has_java_executable(candidate) then
            return candidate
        end
    end
    return nil
end

return M
