#!/bin/bash

architectures=($(curl -s https://www.infomaniak.com/drive/latest | jq -r -n "inputs | keys[]"))

selected=""
PS3='For which architecture do you want to automatically download kDrive? '
select name in "${architectures[@]}" ; do
    if [[ "$REPLY" -gt "0" ]]; then
        opt=($REPLY-1)
        selected=(${architectures[$opt]})
    fi
    [[ $selected ]] && break
done

architecture=$(echo "${selected[@]}")

autostart_path="${HOME}/.config/autostart"
config_path="${HOME}/.config/kdrive-auto-update" 
exec_path="${HOME}/.local/bin"

mkdir -p "$autostart_path"
mkdir -p "$autostart_path"
mkdir -p "$config_path"
mkdir -p "$exec_path"

echo "$architecture" > $config_path/architecture

exec_file=$exec_path/kdrive-auto-update

cp ./kdrive-auto-update "$exec_file"
chmod +x $exec_file

desktopfile="$autostart_path/kdrive-auto-update.desktop"
echo "[Desktop Entry]
Name=kdrive-auto-update
GenericName=kDrive Auto Update
Exec='${exec_file}'
Terminal=false
Categories=Network
Type=Application
StartupNotify=false
X-GNOME-Autostart-enabled=true
X-GNOME-Autostart-Delay=10" > $desktopfile
chmod +x $desktopfile