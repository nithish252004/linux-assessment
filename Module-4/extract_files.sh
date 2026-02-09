#!/bin/bash



echo "Extracting the Required Paramaters passes"
echo ""

INPUT_FILE="$1"
OUTPUT_FILE="output.txt"


if [ $# -ne 1 ]; then
	echo "Give only one Argument after the file name"
	exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
	echo "Input File Does'nt Exist"
	exit 1
fi
COUNT=0

while read -r line
do
	COUNT=$((COUNT+1))
	if [ $COUNT -gt 50 ]; then
		break
	fi

	if echo "$line" | grep -q '"frame.time"' ||\
	   echo "$line" | grep -q '"wlan.fc.type"' ||\
	   echo "$line" | grep -q '"wlan.fc.subtype"'
	then 
	   echo "$line" >> "$OUTPUT_FILE"
	fi


done < "$INPUT_FILE"
echo ""
echo "Output is saved in a File $OUTPUT_FILE"

