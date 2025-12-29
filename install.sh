#!/bin/bash
tmpfolder=$(mktemp -d)
git clone https://github.com/oRiamn/kdrive-auto-update.git $tmpfolder
chmod +x $tmpfolder/launcher.sh
bash $tmpfolder/launcher.sh