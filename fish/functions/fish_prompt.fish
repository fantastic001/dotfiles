function fish_prompt
        echo (pwd) '> '
        set -gx TEST (random)
        get_full_path
end