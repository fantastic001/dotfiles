function check
    ## find $argv[1] -maxdepth 1 -name set_env.fish
    set env_file_path (string join / $argv[1] ".set_env.fish")
    if test -f "$env_file_path"
        while read -la var
            set_variable $var
        end < $env_file_path
    end
end 