function set_variable
    set variable (string split '=' $argv[1])
    set $variable[1] $variable[2]
end