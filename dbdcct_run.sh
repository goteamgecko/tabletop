#!/bin/env bash

# Define plist
currentUser=$(stat -f %Su /dev/console)
prefList="com.goteamgecko.tabletop.game.plist"
setChk="/Users/$currentUser/Library/Preferences/$prefList"


# Check if plist exists and if not, create it
if [ ! -f "$setChk" ] && touch "$setChk"

# Check for newGame flag
newGame=$(defaults read "$setChk" newGame)
if [ "$newGame" == 1 ]; then
    # Start game
    userName=$(defaults read "$setChk" encodedUsername | base64 -D)
    echo "Welcome back, $userName"
else
    echo "No existing settings detected."

    # Open a dialog box and ask the user for their name
    userName=$(osascript -e 'Tell application "System Events" to display dialog "Please enter your real name:" with title "Dragon Breath Dungeon™ avatar creation tool" default answer ""' -e 'text returned of result' 2>/dev/null)

    # Check if the user entered a name
    if [[ -z "$userName" ]]; then
        echo "No name entered. Exiting."
        exit 1
    else
        # Encrypt userName in base64 before writing to plist
        echo "$userName"
        encodedUsername=$(echo "$userName" | base64)
        echo "Thanks for saving your game, $userName"
        defaults write "$setChk" userName -string "$userName"
        defaults write "$setChk" encodedUsername -string "$encodedUsername"
        defaults write "$setChk" newGame -int 1
        defaults write "$setChk" setDone -int 0
        defaults write "$setChk" basePoints -int 12

    fi

    # Print the user's name
    echo "Hello, $userName!"
fi

# Start the Dragon Breath Dungeon™ character creation tool
setDone=$(defaults read "$setChk" setDone)
if [[ "$setDone" == 0 ]]; then
    # Continue
    echo "Dragon Breath Dungeon™ character creation tool continuing"
else
    startOver=$(osascript -e 'set answer to button returned of (display dialog "There is already a Dragon Breath Dungeon™ avatar that has been created. Do you want to restart the Dragon Breath Dungeon™ avatar creation process or would you like to continue with the existing avatar?" with title "Dragon Breath Dungeon™ avatar creation tool" buttons {"Restart tool", "Continue"} default button "Continue")')
    if [[ "$startOver" == "Restart tool" ]]; then
        rm "$setChk"
        echo "Previous settings removed. Please run the Dragon Breath Dungeon™ avatar creation tool again"
        exit 69 ### Start again
    fi
fi

echo "Starting the Dragon Breath Dungeon™ avatar creation tool"

# Define avatar name
avatarName=$(defaults read "$setChk" avatarName)

# Check Avatar Name
    if [[ -z "$avatarName" ]]; then
# Open a dialog box and ask the user for their avatar's name
    avatarName=$(osascript -e 'Tell application "System Events" to display dialog "What is the name of your avatar?" with title "Dragon Breath Dungeon™ avatar creation tool" default answer ""' -e 'text returned of result' 2>/dev/null)
# Check if the user entered a name
    if [[ -z "$avatarName" ]]; then
        echo "No avatar name entered. Exiting."
        exit 1
    else
        # Encrypt userName in base64 before writing to plist
        echo "Avatar name: $avatarName"
        echo "Thanks for choosing your avatar name, $avatarName, $userName"
        defaults write "$setChk" avatarName -string "$avatarName"
        encodedAvatar=$(echo "$avatarName" | base64)
        defaults write "$setChk" encodedAvatar "$encodedAvatar"
        defaults write "$setChk" usedPoints -int 0
    fi
else
echo "Thanks for returning, $userName, your avatar, $avatarName, is ready to set up"
fi
then
echo "username: $userName"
echo "avatarname: $avatarName"
else
echo "Failure"
exit 222 ### No clue what happened
fi

### Define race name
myRace=$(defaults read "$setChk" myRace)

### Check Avatar Race
if [[ -z "$myRace" ]]; then
### Open a dialog box and ask the user for their avatar's race
myRace=$(osascript -e 'tell application "System Events" to choose from list {"Human", "Elf", "Draco", "Titon"} with prompt "What Race will you be?"')
defaults write "$setChk" myRace -string "$myRace"
else
    echo "You selected: $myRace"
fi

### Define Class name
myClass=$(defaults read "$setChk" myClass)

### Choose Class
if [[ -z "$myClass" ]]; then
### Open a dialog box and ask the user for their avatar's class
myClass=$(osascript -e 'tell application "System Events" to choose from list {"Warrior", "Thief", "Archer", "Magika"} with prompt "What Class will you be?"')
defaults write "$setChk" myClass -string "$myClass"
else
if [[ "$myClass" == "false" ]]; then
myClass=$(osascript -e 'tell application "System Events" to choose from list {"Warrior", "Thief", "Archer", "Magika"} with prompt "What Class will you be?"')
defaults write "$setChk" myClass -string "$myClass"
else
    defaults write "$setChk" myClass "$myClass"
fi
    echo "You selected: $myClass"
    defaults write "$setChk" myClass "$myClass"
    fi

### Award base points
if [ $(defaults read "$setChk" basePoints) -eq 0 ]; then
if [ $myRace == "Human" ];
then
### Apply human base points
defaults write "$setChk" basePoints -int 14
echo "14 base points added for $myRace race"
fi
if [ $myRace == "Elf" ];
then
### Apply elf base points
defaults write "$setChk" basePoints -int 13
echo "13 base points added for $myRace race"
fi
if [ $myRace == "Draco" ];
then
### Apply draco base points
defaults write "$setChk" basePoints -int 15
echo "15 base points added for $myRace race"
fi
if [ $myRace == "Titon" ];
then
## Apply titon base points
defaults write "$setChk" basePoints -int 14
echo "14 base points added for $myRace race"
fi
else
echo "Base points already awarded"
fi

### Set raceCodes
if [ -z $(defaults read "$setChk" raceCode) ]; then
if [ $myRace == "Human" ];
then
### Apply human raceCode for points table
defaults write "$setChk" raceCode -string 01
raceCode=$(defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ $myRace == "Elf" ];
then
### Apply elf raceCode for points table
defaults write "$setChk" raceCode -string 02
raceCode=$(defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ $myRace == "Draco" ];
then
### Apply draco raceCode for points table
defaults write "$setChk" raceCode -string 03
raceCode=$(defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ $myRace == "Titon" ];
then
### Apply titon raceCode for points table
defaults write "$setChk" raceCode -string 04
raceCode=$(defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
else
echo "raceCode already set"
fi

### Apply Class Points



defaults write "$setChk" setDone -int 1