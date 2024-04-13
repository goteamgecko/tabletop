#!/bin/env bash

# Define plist
currentUser=$(stat -f %Su /dev/console)
prefList="com.goteamgecko.tabletop.npccreator.plist"
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
    userName=$(osascript -e 'Tell application "System Events" to display dialog "Please enter your real name:" with title "Dragon Breath Dungeon™ npc creation tool" default answer ""' -e 'text returned of result' 2>/dev/null)

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
        /usr/bin/defaults write "$setChk" npcRace -string "$false"
        /usr/bin/defaults write "$setChk" npcGender -string "$false"
        /usr/bin/defaults write "$setChk" npcClass -string "$false"
        /usr/bin/defaults write "$setChk" raceCode -string 00
        /usr/bin/defaults write "$setChk" classCode -string 00
        /usr/bin/defaults write "$setChk" classAttrib -int 0
        /usr/bin/defaults write "$setChk" raceAttrib -int 0
    fi

    # Print the user's name
    echo "Hello, $userName!"
fi

# Start the Dragon Breath Dungeon™ npc creation tool
setDone=$(/usr/bin/defaults read "$setChk" setDone)
if [[ "$setDone" == 0 ]]; then
    # Continue
    echo "Dragon Breath Dungeon™ npc creation tool continuing"
else
    startOver=$(osascript -e 'set answer to button returned of (display dialog "There is already a Dragon Breath Dungeon™ npc that has been created. Do you want to restart the Dragon Breath Dungeon™ npc creation process or would you like to continue with the existing npc?" with title "Dragon Breath Dungeon™ npc creation tool" buttons {"Restart tool", "Continue"} default button "Continue")')
    if [[ "$startOver" == "Restart tool" ]]; then
        rm "$setChk"
        echo "Previous settings removed. Please run the Dragon Breath Dungeon™ npc creation tool again"
        exit 69 ### Start again
    fi
fi

echo "Starting the Dragon Breath Dungeon™ npc creation tool"

# Define npc name
npcName=$(/usr/bin/defaults read "$setChk" npcName)

# Check npc Name
    if [[ -z "$npcName" ]]; then
# Open a dialog box and ask the user for their npc's name
    npcName=$(osascript -e 'Tell application "System Events" to display dialog "What is the name of your npc?" with title "Dragon Breath Dungeon™ npc creation tool" default answer ""' -e 'text returned of result' 2>/dev/null)
# Check if the user entered a name
    if [[ -z "$npcName" ]]; then
        echo "No npc name entered. Exiting."
        exit 1
    else
        # Encrypt userName in base64 before writing to plist
        echo "npc name: $npcName"
        echo "Thanks for choosing your npc name, $npcName, $userName"
        /usr/bin/defaults write "$setChk" npcName -string "$npcName"
        encodednpc=$(echo "$npcName" | base64)
        /usr/bin/defaults write "$setChk" encodednpc "$encodednpc"
    fi
else
echo "Thanks for returning, $userName, your npc, $npcName, is ready to set up"
fi
then
echo "username: $userName"
echo "npcname: $npcName"
else
echo "Failure"
echo "Failure"
echo "Failure"
echo "Failure"
exit 222 ### No clue what happened
fi

### Define race name
npcRace=$(/usr/bin/defaults read "$setChk" npcRace)

### Check npc Race
if [[ "$npcRace" == "false" ]]; then
### Open a dialog box and ask the user for their npc's race
npcRace=$(osascript -e 'tell application "System Events" to choose from list {"Human", "Elf", "Draco", "Titon"} with prompt "What race will you be?"')
/usr/bin/defaults write "$setChk" npcRace -string "$npcRace"
# Check if the user entered an npc race
    if [[ "$npcRace" == "false" ]]; then
        echo "No npc race entered. Exiting."
        exit 1
    else
        echo "You selected: $npcRace"
        /usr/bin/defaults write "$setChk" npcRace -string "$npcRace"
    fi
fi

### Define npc Gender
npcGender=$(/usr/bin/defaults read "$setChk" npcGender)

### Check npc Gender
if [[ "$npcGender" == "false" ]]; then
### Open a dialog box and ask the user for their npc's gender
npcGender=$(osascript -e 'tell application "System Events" to choose from list {"NonBinary", "Female", "Male"} with prompt "What gender will you be?"')
echo "npc genger: $npcGender"
/usr/bin/defaults write "$setChk" npcGender -string "$npcGender"
# Check if the user entered an npc race
    if [[ "$npcGender" == "false" ]]; then
        echo "No npc gender entered. Exiting."
        exit 1
    else
        echo "You selected: $npcGender"
        /usr/bin/defaults write "$setChk" npcGender -string "$npcGender"
    fi
    
fi

### Define npc Class
npcClass=$(/usr/bin/defaults read "$setChk" npcClass)

### Choose Class
if [[ "$npcClass" == "false" ]]; then
### Open a dialog box and ask the user for their npc's class
npcClass=$(osascript -e 'tell application "System Events" to choose from list {"Warrior", "Thief", "Archer", "Magika"} with prompt "What class will you be?"')
/usr/bin/defaults write "$setChk" npcClass -string "$npcClass"
# Check if the user entered an npc class
    if [[ "$npcClass" == "false" ]]; then
        echo "No npc class entered. Exiting."
        exit 1
    else
        echo "You selected: $npcClass"
        /usr/bin/defaults write "$setChk" npcClass -string "$npcClass"
    fi
fi

### Award base points
if [ "$(/usr/bin/defaults read "$setChk" basePoints)" -eq 0 ]; then
if [ "$npcRace" == "Human" ];
then
### Apply human base points
/usr/bin/defaults write "$setChk" basePoints -int 14
echo "14 base points added for $npcRace race"
fi
if [ "$npcRace" == "Elf" ];
then
### Apply elf base points
/usr/bin/defaults write "$setChk" basePoints -int 13
echo "13 base points added for $npcRace race"
fi
if [ "$npcRace" == "Draco" ];
then
### Apply draco base points
/usr/bin/defaults write "$setChk" basePoints -int 15
echo "15 base points added for $npcRace race"
fi
if [ "$npcRace" == "Titon" ];
then
## Apply titon base points
/usr/bin/defaults write "$setChk" basePoints -int 14
echo "14 base points added for $npcRace race"
fi
else
echo "Base points already awarded"
echo "npcRace: $npcRace"
fi

### Set raceCodes
if [ "$(/usr/bin/defaults read "$setChk" raceCode)" == 00 ]; then
if [ "$npcRace" == "Human" ];
then
### Apply human raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 01
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ "$npcRace" == "Elf" ];
then
### Apply elf raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 02
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ "$npcRace" == "Draco" ];
then
### Apply draco raceCode for points table
/usr/bin/defaults write "$setChk" raceCode -string 03
raceCode=$(/usr/bin/defaults read "$setChk" raceCode)
echo "raceCode: $raceCode"
fi
if [ "$npcRace" == "Titon" ];
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
if [ "$npcClass" == "Warrior" ];
then
### Apply warrior classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 01
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
if [ "$npcClass" == "Thief" ];
then
### Apply thief classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 02
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
if [ "$npcClass" == "Archer" ];
then
### Apply archer classCode for points table
/usr/bin/defaults write "$setChk" classCode -string 03
classCode=$(/usr/bin/defaults read "$setChk" classCode)
echo "classCode: $classCode"
fi
if [ "$npcClass" == "Magika" ];
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
if [ "$npcClass" == "Warrior" ];
then
### Apply warrior classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 4
/usr/bin/defaults write "$setChk" classAttribStr -int 4
/usr/bin/defaults write "$setChk" classAttribSte -int 1
/usr/bin/defaults write "$setChk" classAttribSub -int 2
/usr/bin/defaults write "$setChk" classAttribRan -int 1
/usr/bin/defaults write "$setChk" classAttribCom -int 2
/usr/bin/defaults write "$setChk" classAttribMag -int 2
echo "$npcClass attributes set"
fi
if [ "$npcClass" == "Thief" ];
then
### Apply thief classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 2
/usr/bin/defaults write "$setChk" classAttribStr -int 1
/usr/bin/defaults write "$setChk" classAttribSte -int 4
/usr/bin/defaults write "$setChk" classAttribSub -int 3
/usr/bin/defaults write "$setChk" classAttribRan -int 2
/usr/bin/defaults write "$setChk" classAttribCom -int 3
/usr/bin/defaults write "$setChk" classAttribMag -int 1
echo "$npcClass attributes set"
fi
if [ "$npcClass" == "Archer" ];
then
### Apply archer classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 3
/usr/bin/defaults write "$setChk" classAttribStr -int 2
/usr/bin/defaults write "$setChk" classAttribSte -int 2
/usr/bin/defaults write "$setChk" classAttribSub -int 1
/usr/bin/defaults write "$setChk" classAttribRan -int 4
/usr/bin/defaults write "$setChk" classAttribCom -int 3
/usr/bin/defaults write "$setChk" classAttribMag -int 1
echo "$npcClass attributes set"
fi
if [ "$npcClass" == "Magika" ];
then
### Apply magika classAttrib for points table
/usr/bin/defaults write "$setChk" classAttribAtt -int 1
/usr/bin/defaults write "$setChk" classAttribStr -int 1
/usr/bin/defaults write "$setChk" classAttribSte -int 2
/usr/bin/defaults write "$setChk" classAttribSub -int 2
/usr/bin/defaults write "$setChk" classAttribRan -int 3
/usr/bin/defaults write "$setChk" classAttribCom -int 2
/usr/bin/defaults write "$setChk" classAttribMag -int 5
echo "$npcClass attributes set"
fi
/usr/bin/defaults write "$setChk" classAttrib -int 1
fi

### Set raceAttrib
if [ "$(/usr/bin/defaults read "$setChk" raceAttrib)" == 0 ]; then
if [ "$npcRace" == "Human" ];
then
### Apply human raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 2
/usr/bin/defaults write "$setChk" raceAttribStr -int 2
/usr/bin/defaults write "$setChk" raceAttribSte -int 2
/usr/bin/defaults write "$setChk" raceAttribSub -int 2
/usr/bin/defaults write "$setChk" raceAttribRan -int 2
/usr/bin/defaults write "$setChk" raceAttribCom -int 2
/usr/bin/defaults write "$setChk" raceAttribMag -int 2
echo "$npcRace attributes set"
fi
if [ "$npcRace" == "Elf" ];
then
### Apply elf raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 2
/usr/bin/defaults write "$setChk" raceAttribStr -int 1
/usr/bin/defaults write "$setChk" raceAttribSte -int 2
/usr/bin/defaults write "$setChk" raceAttribSub -int 2
/usr/bin/defaults write "$setChk" raceAttribRan -int 3
/usr/bin/defaults write "$setChk" raceAttribCom -int 3
/usr/bin/defaults write "$setChk" raceAttribMag -int 1
echo "$npcRace attributes set"
fi
if [ "$npcRace" == "Draco" ];
then
### Apply draco raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 3
/usr/bin/defaults write "$setChk" raceAttribStr -int 3
/usr/bin/defaults write "$setChk" raceAttribSte -int 1
/usr/bin/defaults write "$setChk" raceAttribSub -int 1
/usr/bin/defaults write "$setChk" raceAttribRan -int 4
/usr/bin/defaults write "$setChk" raceAttribCom -int 1
/usr/bin/defaults write "$setChk" raceAttribMag -int 1
echo "$npcRace attributes set"
fi
if [ "$npcRace" == "Titon" ];
then
### Apply titon raceAttrib for points table
/usr/bin/defaults write "$setChk" raceAttribAtt -int 3
/usr/bin/defaults write "$setChk" raceAttribStr -int 2
/usr/bin/defaults write "$setChk" raceAttribSte -int 2
/usr/bin/defaults write "$setChk" raceAttribSub -int 1
/usr/bin/defaults write "$setChk" raceAttribRan -int 2
/usr/bin/defaults write "$setChk" raceAttribCom -int 2
/usr/bin/defaults write "$setChk" raceAttribMag -int 2
echo "$npcClass attributes set"
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
baseDir="/Users/$currentUser/Library/Preferences/tabletop/npcs"
npcplist="com.goteamgecko.tabletop.$npcName.plist"

### Check if the directory exists
if [ ! -d "$baseDir" ]; then
    ### Directory does not exist, create it
    mkdir -p "$baseDir"
    echo "Directory created: $baseDir"
else
    echo "Directory already exists: $baseDir"
fi

### Write out the npc plist
/usr/bin/defaults write "$baseDir/$npcplist" attribMag "$attribMag"
/usr/bin/defaults write "$baseDir/$npcplist" attribCom "$attribCom"
/usr/bin/defaults write "$baseDir/$npcplist" attribRan "$attribRan"
/usr/bin/defaults write "$baseDir/$npcplist" attribSub "$attribSub"
/usr/bin/defaults write "$baseDir/$npcplist" attribSte "$attribSte"
/usr/bin/defaults write "$baseDir/$npcplist" attribStr "$attribStr"
/usr/bin/defaults write "$baseDir/$npcplist" attribAtt "$attribAtt"
/usr/bin/defaults write "$baseDir/$npcplist" npcLevel "$npcLevel"
/usr/bin/defaults write "$baseDir/$npcplist" npcClass "$npcClass"
/usr/bin/defaults write "$baseDir/$npcplist" npcRace "$npcRace"
/usr/bin/defaults write "$baseDir/$npcplist" npcName "$npcName"

/usr/bin/defaults write "$setChk" setDone -int 1

exit 0