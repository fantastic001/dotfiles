local ALL_EDITING_MODES = { "n", "i", "v", "o", "c" }

local M = {}

local key_translations = {
    { "<Find>", "<Home>", "Home sent as ESC[1~" },
    { "<Select>", "<End>", "End sent as ESC[4~" },
}

function M.configure()
    for _, translation in ipairs(key_translations) do
        local received_key, intended_key, description = unpack(translation)
        vim.keymap.set(
            ALL_EDITING_MODES,
            received_key,
            intended_key,
            { desc = description }
        )
    end
end

return M
