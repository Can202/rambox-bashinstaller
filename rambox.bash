#!/usr/bin/bash


if [ ! $(whoami) = "root" ]
then
    echo "This script needs root"
    exit
else
    echo "You're Root"
fi

#Dependencies
if [ -f "/usr/bin/curl" ] || [ -f "/usr/sbin/curl" ] || [ -f "/usr/games/curl" ]
then
    echo "Curl Installed"
else
    echo "You need to install curl"
    exit
fi
if [ -f "/usr/bin/rm" ] || [ -f "/usr/sbin/rm" ] || [ -f "/usr/games/rm" ]
then
    echo "coreutils Installed"
else
    echo "You need to install coreutils"
    exit
fi

if [ ! -z $1 ]
then
    if [ $1 = "-d" ] || [ $1 = "--delete" ] || [ $1 = "--remove" ]
    then
    echo "removing Rambox"
    rm -rf /usr/bin/rambox /usr/share/applications/rambox.desktop /usr/share/icons/hicolor/256x256/apps/rambox.png /opt/rambox/
    exit
    fi
fi

if [ ! $(uname -m) = "x86_64" ]
then
    echo "This script just works on x86_64 (64 bits)"
    exit
fi

echo "installing Rambox"
cd /opt/
if [ -d "/opt/rambox" ]
then
    rm -rf rambox
fi
mkdir -p rambox
cd rambox
curl -LO https://github.com/ramboxapp/community-edition/releases/download/0.7.9/Rambox-0.7.9-linux-x86_64.AppImage
mv Rambox* rambox.AppImage
chmod a+x rambox.AppImage
curl -LO https://raw.githubusercontent.com/Can202/rambox-bashinstaller/cf36f3383baabbf00106f2d3d195f405a57b646f/media/rambox.png

cp rambox.png /usr/share/icons/hicolor/256x256/apps/rambox.png

echo "#!/usr/bin/bash

/opt/rambox/rambox.AppImage
" > /usr/bin/rambox
chmod a+x /usr/bin/rambox

echo "[Desktop Entry]
Name=Rambox
Exec=rambox
Icon=rambox
Type=Application
Categories=Network" > /usr/share/applications/rambox.desktop
chmod a+x /usr/share/applications/rambox.desktop

echo rambox installed!

