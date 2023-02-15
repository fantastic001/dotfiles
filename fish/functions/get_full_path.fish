function get_full_path
    if test $LAST_CHECKED_PATH != (dirs)
        set list_of_dirs (string split / (dirs))
        set visited ''
        for directory in $list_of_dirs
            if test $directory = '~'
                check /
                check /home
                check /home/$USER
                set visited /home/$USER
            else
                set temp (string join / $visited $directory)
                check $temp
                set visited $temp 
            end
        end
        set -gx LAST_CHECKED_PATH (dirs)
    end

    ## string split / (dirs)
    ## echo $history[1]
end
