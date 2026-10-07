local catalog = require("tools.catalog")

local M = {}

local Installation = {}
Installation.__index = Installation

function Installation.new(on_finished)
    return setmetatable({
        pending = 0,
        finished = false,
        on_finished = on_finished,
    }, Installation)
end

function Installation:finish_when_nothing_pending()
    if self.pending == 0 then
        self.finished = true
        vim.schedule(self.on_finished)
    else
        return
    end
end

function Installation:finish_package(package_name, success)
    self.pending = self.pending - 1
    if success then
        vim.notify("Installed " .. package_name, vim.log.levels.INFO)
    else
        vim.notify("Could not install " .. package_name, vim.log.levels.ERROR)
    end
    self:finish_when_nothing_pending()
end

function Installation:install_package(registry, package_name)
    if not registry.has_package(package_name) then
        vim.notify("Unknown tool " .. package_name, vim.log.levels.ERROR)
        return
    elseif registry.is_installed(package_name) then
        return
    elseif registry.get_package(package_name):is_installing() then
        return
    else
        self.pending = self.pending + 1
        registry.get_package(package_name):install(
            {},
            vim.schedule_wrap(function(success)
                self:finish_package(package_name, success)
            end)
        )
    end
end

function Installation:install_missing(registry)
    for _, package_name in ipairs(catalog) do
        self:install_package(registry, package_name)
    end
    self:finish_when_nothing_pending()
end

function Installation:is_finished()
    return self.finished
end

function M.install_missing(on_finished)
    local registry = require("mason-registry")
    local installation = Installation.new(on_finished)
    registry.refresh(function()
        installation:install_missing(registry)
    end)
    return installation
end

return M
