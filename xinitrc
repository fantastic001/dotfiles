
if [[ -f /home/bin/start-x ]]; then
    /home/bin/start-x
else
    xbindkeys
    qtile start
fi
