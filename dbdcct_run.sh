#!/bin/env bash

# Define plist
currentUser=$(stat -f %Su /dev/console)
prefList="com.goteamgecko.tabletop.charactercreator.plist"
setChk="/Users/$currentUser/Library/Preferences/$prefList"

# Check if plist exists and if not, create it
if [ ! -f "$setChk" ] && touch "$setChk"

# Check for newGame flag
newGame=$(/usr/bin/defaults read "$setChk" newGame)
if [ "$newGame" == 1 ]; then
    # Start game
    userName=$(/usr/bin/defaults read "$setChk" encodedUsername | base64 -D)
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
        false="false"
        echo "Thanks for saving your game, $userName"
        /usr/bin/defaults write "$setChk" userName -string "$userName"
        /usr/bin/defaults write "$setChk" encodedUsername -string "$encodedUsername"
        /usr/bin/defaults write "$setChk" newGame -int 1
        /usr/bin/defaults write "$setChk" setDone -int 0
        /usr/bin/defaults write "$setChk" basePoints -int 0
        /usr/bin/defaults write "$setChk" usedPoints -int 0
        /usr/bin/defaults write "$setChk" avatarRace -string "$false"
        /usr/bin/defaults write "$setChk" avatarGender -string "$false"
        /usr/bin/defaults write "$setChk" avatarClass -string "$false"
        /usr/bin/defaults write "$setChk" raceCode -string 00
        /usr/bin/defaults write "$setChk" classCode -string 00
        /usr/bin/defaults write "$setChk" classAttrib -int 0
        /usr/bin/defaults write "$setChk" raceAttrib -int 0
    fi

    # Print the user's name
    echo "Hello, $userName!"
fi

# Start the Dragon Breath Dungeon™ character creation tool
setDone=$(/usr/bin/defaults read "$setChk" setDone)
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
avatarName=$(/usr/bin/defaults read "$setChk" avatarName)

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
        /usr/bin/defaults write "$setChk" avatarName -string "$avatarName"
        encodedAvatar=$(echo "$avatarName" | base64)
        /usr/bin/defaults write "$setChk" encodedAvatar "$encodedAvatar"
    fi
else
echo "Thanks for returning, $userName, your avatar, $avatarName, is ready to set up"
fi
then
echo "username: $userName"
echo "avatarname: $avatarName"
else
echo "Failure"
echo "Failure"
echo "Failure"
echo "Failure"
exit 222 ### No clue what happened
fi

### Define race name
avatarRace=$(/usr/bin/defaults read "$setChk" avatarRace)

### Check Avatar Race
if [[ "$avatarRace" == "false" ]]; then
### Open a dialog box and ask the user for their avatar's race
avatarRace=$(osascript -e 'tell application "System Events" to choose from list {"Human", "Elf", "Draco", "Titon"} with prompt "What race will you be?"')
/usr/bin/defaults write "$setChk" avatarRace -string "$avatarRace"
# Check if the user entered an avatar race
    if [[ "$avatarRace" == "false" ]]; then
        echo "No avatar race entered. Exiting."
        exit 1
    else
        echo "You selected: $avatarRace"
        /usr/bin/defaults write "$setChk" avatarRace -string "$avatarRace"
    fi
fi

### Define Avatar Gender
avatarGender=$(/usr/bin/defaults read "$setChk" avatarGender)

### Check Avatar Gender
if [[ "$avatarGender" == "false" ]]; then
### Open a dialog box and ask the user for their avatar's gender
avatarGender=$(osascript -e 'tell application "System Events" to choose from list {"NonBinary", "Female", "Male"} with prompt "What gender will you be?"')
echo "Avatar genger: $avatarGender"
/usr/bin/defaults write "$setChk" avatarGender -string "$avatarGender"
# Check if the user entered an avatar race
    if [[ "$avatarGender" == "false" ]]; then
        echo "No avatar gender entered. Exiting."
        exit 1
    else
        echo "You selected: $avatarGender"
        /usr/bin/defaults write "$setChk" avatarGender -string "$avatarGender"
    fi
    
fi

### Define Avatar Class
avatarClass=$(/usr/bin/defaults read "$setChk" avatarClass)

### Choose Class
if [[ "$avatarClass" == "false" ]]; then
### Open a dialog box and ask the user for their avatar's class
avatarClass=$(osascript -e 'tell application "System Events" to choose from list {"Warrior", "Thief", "Archer", "Magika"} with prompt "What class will you be?"')
/usr/bin/defaults write "$setChk" avatarClass -string "$avatarClass"
# Check if the user entered an avatar class
    if [[ "$avatarClass" == "false" ]]; then
        echo "No avatar class entered. Exiting."
        exit 1
    else
        echo "You selected: $avatarClass"
        /usr/bin/defaults write "$setChk" avatarClass -string "$avatarClass"
    fi
fi

### Award base points
if [ "$(/usr/bin/defaults read "$setChk" basePoints)" -eq 0 ]; then
if [ "$avatarRace" == "Human" ];
then
### Apply human base points
/usr/bin/defaults write "$setChk" basePoints -int 14
echo "14 base points added for $avatarRace race"
fi
if [ "$avatarRace" == "Elf" ];
then
### Apply elf base points
/usr/bin/defaults write "$setChk" basePoints -int 13
echo "13 base points added for $avatarRace race"
fi
if [ "$avatarRace" == "Draco" ];
then
### Apply draco base points
/usr/bin/defaults write "$setChk" basePoints -int 15
echo "15 base points added for $avatarRace race"
fi
if [ "$avatarRace" == "Titon" ];
then
## Apply titon base points
/usr/bin/defaults write "$setChk" basePoints -int 14
echo "14 base points added for $avatarRace race"
fi
else
echo "Base points already awarded"
echo "avatarRace: $avatarRace"
fi

### Set raceCodes
if [ "$(/usr/bin/defaults read "$setChk" raceCode)" == 00 ]; then
if [ "$avatarRace" == "Human" ];
then
### Apply human raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 01
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ "$avatarRace" == "Elf" ];
then
### Apply elf raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 02
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ "$avatarRace" == "Draco" ];
then
### Apply draco raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 03
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ "$avatarRace" == "Titon" ];
then
### Apply titon raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 04
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
else
echo "raceCode: $raceCode already set"
fi

### Set classCode
if [ "$(/usr/bin/defaults read "$setChk" classCode)" == 00 ]; then
if [ "$avatarClass" == "Warrior" ];
then
### Apply warrior classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 01
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
if [ "$avatarClass" == "Thief" ];
then
### Apply thief classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 02
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
if [ "$avatarClass" == "Archer" ];
then
### Apply archer classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 03
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
if [ "$avatarClass" == "Magika" ];
then
### Apply magika classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 04
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
else
echo "classCode: $classCode already set"
fi

### Set classAttrib
if [ "$(/usr/bin/defaults read "$setChk" classAttrib)" == 0 ]; then
if [ "$avatarClass" == "Warrior" ];
then
### Apply warrior classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 4
/usr/bin/defaults write "$setChk" classAttribStr -int 4
/usr/bin/defaults write "$setChk" classAttribSte -int 1
/usr/bin/defaults write "$setChk" classAttribSub -int 2
/usr/bin/defaults write "$setChk" classAttribRan -int 1
/usr/bin/defaults write "$setChk" classAttribCom -int 2
/usr/bin/defaults write "$setChk" classAttribMag -int 2
echo "$avatarClass attributes set"
fi
if [ "$avatarClass" == "Thief" ];
then
### Apply thief classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 2
/usr/bin/defaults write "$setChk" classAttribStr -int 1
/usr/bin/defaults write "$setChk" classAttribSte -int 4
/usr/bin/defaults write "$setChk" classAttribSub -int 3
/usr/bin/defaults write "$setChk" classAttribRan -int 2
/usr/bin/defaults write "$setChk" classAttribCom -int 3
/usr/bin/defaults write "$setChk" classAttribMag -int 1
echo "$avatarClass attributes set"
fi
if [ "$avatarClass" == "Archer" ];
then
### Apply archer classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 3
/usr/bin/defaults write "$setChk" classAttribStr -int 2
/usr/bin/defaults write "$setChk" classAttribSte -int 2
/usr/bin/defaults write "$setChk" classAttribSub -int 1
/usr/bin/defaults write "$setChk" classAttribRan -int 4
/usr/bin/defaults write "$setChk" classAttribCom -int 3
/usr/bin/defaults write "$setChk" classAttribMag -int 1
echo "$avatarClass attributes set"
fi
if [ "$avatarClass" == "Magika" ];
then
### Apply magika classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 1
/usr/bin/defaults write "$setChk" classAttribStr -int 1
/usr/bin/defaults write "$setChk" classAttribSte -int 2
/usr/bin/defaults write "$setChk" classAttribSub -int 2
/usr/bin/defaults write "$setChk" classAttribRan -int 3
/usr/bin/defaults write "$setChk" classAttribCom -int 2
/usr/bin/defaults write "$setChk" classAttribMag -int 5
echo "$avatarClass attributes set"
fi
/usr/bin/defaults write "$setChk" classAttrib -int 1
fi

### Set raceAttrib
if [ "$(/usr/bin/defaults read "$setChk" raceAttrib)" == 0 ]; then
if [ "$avatarRace" == "Human" ];
then
### Apply human raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 2
/usr/bin/defaults write "$setChk" raceAttribStr -int 2
/usr/bin/defaults write "$setChk" raceAttribSte -int 2
/usr/bin/defaults write "$setChk" raceAttribSub -int 2
/usr/bin/defaults write "$setChk" raceAttribRan -int 2
/usr/bin/defaults write "$setChk" raceAttribCom -int 2
/usr/bin/defaults write "$setChk" raceAttribMag -int 2
echo "$avatarRace attributes set"
fi
if [ "$avatarRace" == "Elf" ];
then
### Apply elf raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 2
/usr/bin/defaults write "$setChk" raceAttribStr -int 1
/usr/bin/defaults write "$setChk" raceAttribSte -int 2
/usr/bin/defaults write "$setChk" raceAttribSub -int 2
/usr/bin/defaults write "$setChk" raceAttribRan -int 3
/usr/bin/defaults write "$setChk" raceAttribCom -int 3
/usr/bin/defaults write "$setChk" raceAttribMag -int 1
echo "$avatarRace attributes set"
fi
if [ "$avatarRace" == "Draco" ];
then
### Apply draco raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 3
/usr/bin/defaults write "$setChk" raceAttribStr -int 3
/usr/bin/defaults write "$setChk" raceAttribSte -int 1
/usr/bin/defaults write "$setChk" raceAttribSub -int 1
/usr/bin/defaults write "$setChk" raceAttribRan -int 4
/usr/bin/defaults write "$setChk" raceAttribCom -int 1
/usr/bin/defaults write "$setChk" raceAttribMag -int 1
echo "$avatarRace attributes set"
fi
if [ "$avatarRace" == "Titon" ];
then
### Apply titon raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 3
/usr/bin/defaults write "$setChk" raceAttribStr -int 2
/usr/bin/defaults write "$setChk" raceAttribSte -int 2
/usr/bin/defaults write "$setChk" raceAttribSub -int 1
/usr/bin/defaults write "$setChk" raceAttribRan -int 2
/usr/bin/defaults write "$setChk" raceAttribCom -int 2
/usr/bin/defaults write "$setChk" raceAttribMag -int 2
echo "$avatarClass attributes set"
fi
/usr/bin/defaults write "$setChk" raceAttrib -int 1
fi

raceAtt=$(/usr/bin/defaults read "$setChk" raceAttribAtt)
classAtt=$(/usr/bin/defaults read "$setChk" classAttribAtt)
raceStr=$(/usr/bin/defaults read "$setChk" raceAttribStr)
classStr=$(/usr/bin/defaults read "$setChk" classAttribStr)
raceSte=$(/usr/bin/defaults read "$setChk" raceAttribSte)
classSte=$(/usr/bin/defaults read "$setChk" classAttribSte)
raceSub=$(/usr/bin/defaults read "$setChk" raceAttribSub)
classSub=$(/usr/bin/defaults read "$setChk" classAttribSub)
raceRan=$(/usr/bin/defaults read "$setChk" raceAttribRan)
classRan=$(/usr/bin/defaults read "$setChk" classAttribRan)
raceCom=$(/usr/bin/defaults read "$setChk" raceAttribCom)
classCom=$(/usr/bin/defaults read "$setChk" classAttribCom)
raceMag=$(/usr/bin/defaults read "$setChk" raceAttribMag)
classMag=$(/usr/bin/defaults read "$setChk" classAttribMag)

attribAtt=$(( $raceAtt + $classAtt ))
/usr/bin/defaults write "$setChk" attribAtt "$attribAtt"
echo "Attack: $attribAtt"
attribStr=$(( $raceStr + $classStr ))
/usr/bin/defaults write "$setChk" attribStr "$attribStr"
echo "Strength: $attribStr"
attribSte=$(( $raceSte + $classSte ))
/usr/bin/defaults write "$setChk" attribSte "$attribSte"
echo "Stealth: $attribSte"
attribSub=$(( $raceSub + $classSub ))
/usr/bin/defaults write "$setChk" attribSub "$attribSub"
echo "Subterfuge: $attribSub"
attribRan=$(( $raceRan + $classRan ))
/usr/bin/defaults write "$setChk" attribRan "$attribRan"
echo "Range: $attribRan"
attribCom=$(( $raceCom + $classCom ))
/usr/bin/defaults write "$setChk" attribCom "$attribCom"
echo "Composure: $attribCom"
attribMag=$(( $raceMag + $classMag ))
/usr/bin/defaults write "$setChk" attribMag "$attribMag"
echo "Magic: $attribMag"

/usr/bin/defaults write "$setChk" setDone -int 1

### Build csv file from data collected
printf "Account: Avatar name,Race,Class,Gender,Attack,Strength,Stealth,Subterfuge,Range,Composure,Magic%s\n\
$avatarName,$avatarRace,$avatarClass,$avatarGender,$attribAtt,$attribStr,$attribSte,$attribSub,$attribRan,$attribCom,$attribMag "\
> ~/Desktop/Character_Sheet_${avatarName}.csv
