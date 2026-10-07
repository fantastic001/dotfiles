require("language_servers.diagnostics").configure()
require("language_servers.attach").register_buffer_setup()
require("language_servers.registry").enable_available_servers()
