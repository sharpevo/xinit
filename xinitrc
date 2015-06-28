#!/bin/sh

systemd --user &

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on' # Java apps font.
export wiki_browser=firefox
export GOPATH=~/go
export PATH="$PATH:$GOPATH/bin"
xset m 5 1 &
xset -b &

# input method
fcitx &
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export LC_CTYPE=zh_CN.UTF-8 # for emacs

#xmodmap /etc/X11/xinit/xmodmaprc &
#setxkbmap dvorak && xmodmap /etc/X11/xinit/xmodmaprc &

# set tablet LCD keys
sudo setkeycodes 66 109 # lock to pagedown
sudo setkeycodes 68 104 # toolbox to pageup
sudo setkeycodes 67 112 # XF86LaunchA
sudo setkeycodes 6c 113 # XF86LaunchB

redshift -l 40:116 -O 5700 &
#xsetwacom set 'Serial Wacom Tablet eraser' TPCButton on &

dbuslaunch="`which dbus-launch 2>/dev/null`"
if [ -n "$dbuslaunch" ] && [ -x "$dbuslaunch" ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval `$dbuslaunch --sh-syntax --exit-with-session`
fi

# Start xmonad
xsetroot -cursor_name left_ptr
xcompmgr -cCf -t-19 -l-29 -r8 -o.65 -D1 &

# Start xmonad
sh /etc/X11/xinit/xmonad/exec_xmonad.sh
