local DOCKER_COMPOSE_FILETYPE = "yaml.docker-compose"

local M = {}

local docker_compose_patterns = {
    ["docker%-compose[%w%.%-]*%.ya?ml"] = DOCKER_COMPOSE_FILETYPE,
    ["compose[%w%.%-]*%.ya?ml"] = DOCKER_COMPOSE_FILETYPE,
}

function M.configure()
    vim.filetype.add({ pattern = docker_compose_patterns })
end

return M
