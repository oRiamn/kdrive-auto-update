#!/bin/bash

get_repo_dir()
{
    local SOURCE_PATH="${BASH_SOURCE[0]}"
    local SYMLINK_DIR
    local repo_dir
    # Resolve symlinks recursively
    while [ -L "$SOURCE_PATH" ]; do
        # Get symlink directory
        SYMLINK_DIR="$( cd -P "$( dirname "$SOURCE_PATH" )" >/dev/null 2>&1 && pwd )"
        # Resolve symlink target (relative or absolute)
        SOURCE_PATH="$(readlink "$SOURCE_PATH")"
        # Check if candidate path is relative or absolute
        if [[ $SOURCE_PATH != /* ]]; then
            # Candidate path is relative, resolve to full path
            SOURCE_PATH=$SYMLINK_DIR/$SOURCE_PATH
        fi
    done
    # Get final script directory path from fully resolved source path
    repo_dir="$(cd -P "$( dirname "$SOURCE_PATH" )" >/dev/null 2>&1 && pwd)"
    echo "$repo_dir"
}

repo_dir=$(get_repo_dir)

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

cp $repo_dir/kdrive-auto-update "$exec_file"
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