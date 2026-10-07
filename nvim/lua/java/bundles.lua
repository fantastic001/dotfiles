local BUNDLE_PATTERNS = {
    "/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar",
    "/share/java-test/*.jar",
}
local EXCLUDED_BUNDLES = {
    "com.microsoft.java.test.runner-jar-with-dependencies.jar",
    "jacocoagent.jar",
}

local M = {}

local function is_loadable_bundle(path)
    return not vim.list_contains(EXCLUDED_BUNDLES, vim.fs.basename(path))
end

local function glob_bundles(mason_root, pattern)
    return vim.tbl_filter(
        is_loadable_bundle,
        vim.fn.glob(mason_root .. pattern, false, true)
    )
end

function M.collect()
    local mason_root = vim.env.MASON
    local bundles = {}
    if not mason_root then
        return bundles
    end
    for _, pattern in ipairs(BUNDLE_PATTERNS) do
        vim.list_extend(bundles, glob_bundles(mason_root, pattern))
    end
    return bundles
end

return M
