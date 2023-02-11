
if [[ -f /home/bin/start-x ]]; then
    /home/bin/start-x
else
    xbindkeys
    qtile start
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi