#!/bin/env bash

# Define plist
currentUser=$(stat -f %Su /dev/console)
prefList="com.goteamgecko.tabletop.monstercreator.plist"
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
    userName=$(osascript -e 'Tell application "System Events" to display dialog "Please enter your real name:" with title "Dragon Breath Dungeon™ Monster creation tool" default answer ""' -e 'text returned of result' 2>/dev/null)

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
        /usr/bin/defaults write "$setChk" monsterRace -string "$false"
        /usr/bin/defaults write "$setChk" monsterLevel -string "$false"
        /usr/bin/defaults write "$setChk" monsterClass -string "$false"
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
    startOver=$(osascript -e 'set answer to button returned of (display dialog "There is already a Dragon Breath Dungeon™ Monster that has been created. Do you want to restart the Dragon Breath Dungeon™ Monster creation process or would you like to continue with the existing Monster?" with title "Dragon Breath Dungeon™ Monster creation tool" buttons {"Restart tool", "Continue"} default button "Continue")')
    if [[ "$startOver" == "Restart tool" ]]; then
        rm "$setChk"
        echo "Previous settings removed. Please run the Dragon Breath Dungeon™ Monster creation tool again"
        exit 69 ### Start again
    fi
fi

echo "Starting the Dragon Breath Dungeon™ Monster creation tool"

# Define Monster name
monsterName=$(/usr/bin/defaults read "$setChk" monsterName)

# Check Monster Name
    if [[ -z "$monsterName" ]]; then
# Open a dialog box and ask the user for their Monster's name
    monsterName=$(osascript -e 'Tell application "System Events" to display dialog "What is the name of your Monster?" with title "Dragon Breath Dungeon™ Monster creation tool" default answer ""' -e 'text returned of result' 2>/dev/null)
# Check if the user entered a name
    if [[ -z "$monsterName" ]]; then
        echo "No Monster name entered. Exiting."
        exit 1
    else
        # Encrypt userName in base64 before writing to plist
        echo "Monster name: $monsterName"
        echo "Thanks for choosing your Monster name, $monsterName, $userName"
        /usr/bin/defaults write "$setChk" monsterName -string "$monsterName"
        encodedMonster=$(echo "$monsterName" | base64)
        /usr/bin/defaults write "$setChk" encodedMonster "$encodedMonster"
    fi
else
echo "Thanks for returning, $userName, your monster, $monsterName, is ready to set up"
fi
then
echo "username: $userName"
echo "monsterName: $monsterName"
else
echo "Failure"
echo "Failure"
echo "Failure"
echo "Failure"
exit 222 ### No clue what happened
fi

### Define race name
monsterRace=$(/usr/bin/defaults read "$setChk" monsterRace)

### Check Monster Race
if [[ "$monsterRace" == "false" ]]; then
### Open a dialog box and ask the user for their Monster's race
monsterRace=$(osascript -e 'tell application "System Events" to choose from list {"Shark", "Hawk", "Dino", "Worm"} with prompt "What race will your monster be?"')
/usr/bin/defaults write "$setChk" monsterRace -string "$monsterRace"
# Check if the user entered a monster race
    if [[ "$monsterRace" == "false" ]]; then
        echo "No monster race entered. Exiting."
        exit 1
    else
        echo "You selected: $monsterRace"
        /usr/bin/defaults write "$setChk" monsterRace -string "$monsterRace"
    fi
fi

### Define Monster Level
monsterLevel=$(/usr/bin/defaults read "$setChk" monsterLevel)

### Check Monster Level
if [[ "$monsterLevel" == "false" ]]; then
### Open a dialog box and ask the user for their Monster's Level
monsterLevel=$(osascript -e 'tell application "System Events" to choose from list {"Level 01", "Level 02", "Level 03"} with prompt "What Level will your monster be?"')
echo "Monster genger: $monsterLevel"
/usr/bin/defaults write "$setChk" monsterLevel -string "$monsterLevel"
# Check if the user entered a monster race
    if [[ "$monsterLevel" == "false" ]]; then
        echo "No Monster level entered. Exiting."
        exit 1
    else
        echo "You selected: $monsterLevel"
        /usr/bin/defaults write "$setChk" monsterLevel -string "$monsterLevel"
    fi
    
fi

### Define Monster Class
monsterClass=$(/usr/bin/defaults read "$setChk" monsterClass)

### Choose Class
if [[ "$monsterClass" == "false" ]]; then
### Open a dialog box and ask the user for their Monster's class
monsterClass=$(osascript -e 'tell application "System Events" to choose from list {"Rage", "Dark", "Dire", "Mystic"} with prompt "What class will you be?"')
/usr/bin/defaults write "$setChk" monsterClass -string "$monsterClass"
# Check if the user entered a monster class
    if [[ "$monsterClass" == "false" ]]; then
        echo "No monster class entered. Exiting."
        exit 1
    else
        echo "You selected: $monsterClass"
        /usr/bin/defaults write "$setChk" monsterClass -string "$monsterClass"
    fi
fi

### Award base points
if [ "$(/usr/bin/defaults read "$setChk" basePoints)" -eq 0 ]; then
if [ "$monsterRace" == "Shark" ];
then
### Apply Shark base points
/usr/bin/defaults write "$setChk" basePoints -int 16
echo "14 base points added for $monsterRace race"
fi
if [ "$monsterRace" == "Hawk" ];
then
### Apply Hawk base points
/usr/bin/defaults write "$setChk" basePoints -int 15
echo "13 base points added for $monsterRace race"
fi
if [ "$monsterRace" == "Dino" ];
then
### Apply Dino base points
/usr/bin/defaults write "$setChk" basePoints -int 17
echo "15 base points added for $monsterRace race"
fi
if [ "$monsterRace" == "Worm" ];
then
## Apply Worm base points
/usr/bin/defaults write "$setChk" basePoints -int 16
echo "14 base points added for $monsterRace race"
fi
else
echo "Base points already awarded"
echo "monsterRace: $monsterRace"
fi

### Set raceCodes
if [ "$(/usr/bin/defaults read "$setChk" raceCode)" == 00 ]; then
if [ "$monsterRace" == "Shark" ];
then
### Apply shark raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 05
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ "$monsterRace" == "Hawk" ];
then
### Apply hawk raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 06
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ "$monsterRace" == "Dino" ];
then
### Apply dino raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 07
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ "$monsterRace" == "Worm" ];
then
### Apply worm raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 08
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
else
echo "raceCode: $raceCode already set"
fi

### Set classCode
if [ "$(/usr/bin/defaults read "$setChk" classCode)" == 00 ]; then
if [ "$monsterClass" == "Rage" ];
then
### Apply rage classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 05
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
if [ "$monsterClass" == "Dark" ];
then
### Apply dark classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 06
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
if [ "$monsterClass" == "Dire" ];
then
### Apply dire classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 07
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
if [ "$monsterClass" == "Mystic" ];
then
### Apply mystic classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 08
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
else
echo "classCode: $classCode already set"
fi

### Set classAttrib
if [ "$(/usr/bin/defaults read "$setChk" classAttrib)" == 0 ]; then
if [ "$monsterClass" == "Rage" ];
then
### Apply rage classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 5
/usr/bin/defaults write "$setChk" classAttribStr -int 5
/usr/bin/defaults write "$setChk" classAttribSte -int 2
/usr/bin/defaults write "$setChk" classAttribSub -int 3
/usr/bin/defaults write "$setChk" classAttribRan -int 2
/usr/bin/defaults write "$setChk" classAttribCom -int 3
/usr/bin/defaults write "$setChk" classAttribMag -int 3
echo "$monsterClass attributes set"
fi
if [ "$monsterClass" == "Dark" ];
then
### Apply dark classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 3
/usr/bin/defaults write "$setChk" classAttribStr -int 2
/usr/bin/defaults write "$setChk" classAttribSte -int 5
/usr/bin/defaults write "$setChk" classAttribSub -int 4
/usr/bin/defaults write "$setChk" classAttribRan -int 3
/usr/bin/defaults write "$setChk" classAttribCom -int 4
/usr/bin/defaults write "$setChk" classAttribMag -int 2
echo "$monsterClass attributes set"
fi
if [ "$monsterClass" == "Dire" ];
then
### Apply dire classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 4
/usr/bin/defaults write "$setChk" classAttribStr -int 3
/usr/bin/defaults write "$setChk" classAttribSte -int 3
/usr/bin/defaults write "$setChk" classAttribSub -int 2
/usr/bin/defaults write "$setChk" classAttribRan -int 5
/usr/bin/defaults write "$setChk" classAttribCom -int 4
/usr/bin/defaults write "$setChk" classAttribMag -int 2
echo "$monsterClass attributes set"
fi
if [ "$monsterClass" == "Mystic" ];
then
### Apply mystic classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 2
/usr/bin/defaults write "$setChk" classAttribStr -int 2
/usr/bin/defaults write "$setChk" classAttribSte -int 3
/usr/bin/defaults write "$setChk" classAttribSub -int 3
/usr/bin/defaults write "$setChk" classAttribRan -int 4
/usr/bin/defaults write "$setChk" classAttribCom -int 3
/usr/bin/defaults write "$setChk" classAttribMag -int 6
echo "$monsterClass attributes set"
fi
/usr/bin/defaults write "$setChk" classAttrib -int 1
fi

### Set raceAttrib
if [ "$(/usr/bin/defaults read "$setChk" raceAttrib)" == 0 ]; then
if [ "$monsterRace" == "Shark" ];
then
### Apply Shark raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 3
/usr/bin/defaults write "$setChk" raceAttribStr -int 3
/usr/bin/defaults write "$setChk" raceAttribSte -int 3
/usr/bin/defaults write "$setChk" raceAttribSub -int 4
/usr/bin/defaults write "$setChk" raceAttribRan -int 4
/usr/bin/defaults write "$setChk" raceAttribCom -int 3
/usr/bin/defaults write "$setChk" raceAttribMag -int 3
echo "$monsterRace attributes set"
fi
if [ "$monsterRace" == "Hawk" ];
then
### Apply Hawk raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 3
/usr/bin/defaults write "$setChk" raceAttribStr -int 2
/usr/bin/defaults write "$setChk" raceAttribSte -int 4
/usr/bin/defaults write "$setChk" raceAttribSub -int 4
/usr/bin/defaults write "$setChk" raceAttribRan -int 5
/usr/bin/defaults write "$setChk" raceAttribCom -int 4
/usr/bin/defaults write "$setChk" raceAttribMag -int 2
echo "$monsterRace attributes set"
fi
if [ "$monsterRace" == "Dino" ];
then
### Apply Dino raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 5
/usr/bin/defaults write "$setChk" raceAttribStr -int 5
/usr/bin/defaults write "$setChk" raceAttribSte -int 2
/usr/bin/defaults write "$setChk" raceAttribSub -int 2
/usr/bin/defaults write "$setChk" raceAttribRan -int 5
/usr/bin/defaults write "$setChk" raceAttribCom -int 2
/usr/bin/defaults write "$setChk" raceAttribMag -int 2
echo "$monsterRace attributes set"
fi
if [ "$monsterRace" == "Worm" ];
then
### Apply Worm raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 4
/usr/bin/defaults write "$setChk" raceAttribStr -int 4
/usr/bin/defaults write "$setChk" raceAttribSte -int 3
/usr/bin/defaults write "$setChk" raceAttribSub -int 2
/usr/bin/defaults write "$setChk" raceAttribRan -int 4
/usr/bin/defaults write "$setChk" raceAttribCom -int 3
/usr/bin/defaults write "$setChk" raceAttribMag -int 3
echo "$monsterClass attributes set"
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

### Build plist file from the data collected
baseDir="/Users/$currentUser/Library/Preferences/tabletop/monsters"
monsterplist="com.goteamgecko.tabletop.$monsterName.plist"

### Check if the directory exists
if [ ! -d "$baseDir" ]; then
    ### Directory does not exist, create it
    mkdir -p "$baseDir"
    echo "Directory created: $baseDir"
else
    echo "Directory already exists: $baseDir"
fi

### Write out the monster plist
/usr/bin/defaults write "$baseDir/$monsterplist" attribMag "$attribMag"
/usr/bin/defaults write "$baseDir/$monsterplist" attribCom "$attribCom"
/usr/bin/defaults write "$baseDir/$monsterplist" attribRan "$attribRan"
/usr/bin/defaults write "$baseDir/$monsterplist" attribSub "$attribSub"
/usr/bin/defaults write "$baseDir/$monsterplist" attribSte "$attribSte"
/usr/bin/defaults write "$baseDir/$monsterplist" attribStr "$attribStr"
/usr/bin/defaults write "$baseDir/$monsterplist" attribAtt "$attribAtt"
/usr/bin/defaults write "$baseDir/$monsterplist" monsterLevel "$monsterLevel"
/usr/bin/defaults write "$baseDir/$monsterplist" monsterClass "$monsterClass"
/usr/bin/defaults write "$baseDir/$monsterplist" monsterRace "$monsterRace"
/usr/bin/defaults write "$baseDir/$monsterplist" monsterName "$monsterName"

### SetupDone
/usr/bin/defaults write "$setChk" setDone -int 1

exit 0