local java_home = require("java.runtime").java_home()

return {
    cmd_env = java_home and { JAVA_HOME = java_home } or nil,
    init_options = {
        bundles = require("java.bundles").collect(),
    },
}
