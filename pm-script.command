#!/bin/bash

### Set ComputerName &  ###

echo
echo "Please enter the users name, WITH NO SPACES!"
read username
echo
echo "Please enter the asset tag ID"
read assetID
echo
sudo scutil --set ComputerName $username-$assetID
compname=$(sudo scutil --get ComputerName)
echo "Computer is now named:" $compname



### Run Applications ###

open /Applications/TeamViewer.app
sudo pkill cloud-backup
/usr/bin/sqlite3 /Users/$(/usr/bin/stat -f "%Su" /dev/console)/.CloudStationBackup/data/db/sys.sqlite "update session_table set status=0; update connection_table set status=0"
sleep 5
open /Applications/Synology\ Cloud\ Station\ Backup.app/
sleep 5
echo 
echo "PPID for Teamview"
if ! pgrep -x "TeamViewer"
then
    echo "Not Installed or not Running!"
fi
echo
echo "PPIDs for Cloud Station Backup"
if ! pgrep "cloud-backup"
then
    echo "Not Installed or not Running!"
fi
echo



### Update & Disable Auto Update ###

softwareupdate -d -i -a -R
echo
echo "Disabling Auto Updates"
sudo softwareupdate --schedule off



### Check Username is Set ###

echo
echo "MAKE SURE USERNAME IS CORRECT!"
echo
