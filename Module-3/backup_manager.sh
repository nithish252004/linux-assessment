#!/bin/bash

echo "Requirement 1 - Command line arguments and Quoting"

SOURCE_DIR="$1"
BACKUP_DIR="$2"
FILE_TYPE="$3"

if [ $# -ne 3 ]; then
	echo "Missing Arguments"
	echo "Give as Arg1 : Source-dir path, Arg2 :Backup-dir path, Arg2 : Type of the File" 
	exit 1
fi

echo "Source : $SOURCE_DIR"
echo "Backup : $BACKUP_DIR"
echo "Extension : $FILE_TYPE"
echo ""
echo "Rquirement 2 - Globbing"

FILES=( "$SOURCE_DIR"/*"$FILE_TYPE" )

if [ ! -e "${FILES[0]}" ]; then
	echo "No Such Files Found"
	exit 1

fi

echo " Files Found"
for file in "${FILES[@]}"
do
	echo "File Found : $(basename "$file")"
done
echo ""
echo "Requirement 3 - Backcount Variable"
export BACK_COUNT=0
echo "Initialized Backcount variable"

for file in "${FILES[@]}"
do
        cp "$file" "$BACKUP_DIR/"
	((BACK_COUNT++))
done
echo "Files pushed to backup folder"
echo "Backup Files : $BACK_COUNT"
echo ""
echo "Requirement 4 - Listing the Files with the inclusion of its Size"
for file in "${FILES[@]}"
do
	size=$(stat -c%s "$file")
	echo "File name : $(basename "$file") | Size : "$size""
done
echo ""
echo "Requirement 5 - Conditional Execution"
echo ""
echo "Requirement 5.1 - Check whether the backup directory exists"
if [ ! -d "$BACKUP_DIR" ]; then
	echo "Backup Directory Does'nt exist , creating it"
	mkdir -p "$BACKUP_DIR"
	if [ $? -ne 0 ]; then
		echo "Failed to create a directory"
		exit 1
	fi
	echo "Backup Directory Created Sucessfully"
fi
echo ""
echo "Requirement 5.2 - Check if file exist"
if [ ! -e "${FILES[0]}" ]; then
	echo "No Files Exist with the extension you gave"
	exit 1
fi
echo ""
echo "Requirement 5.3 - Backup with timestamp"
echo ""
echo "Starting Backup"
for file in "${FILES[@]}"
do
	filename=$(basename "$file")
	destination="$BACKUP_DIR/$filename"

	if [ ! -f "$destination" ]; then
		echo "Copying new file: $filename"
	        cp "$file" "$destination"
	        BACK_COUNT = $((BACK_COUNT + 1))
	else 
		if [ "$file" -nt "$destination" ]; then
			echo "Updating Old file $filename"
			cp "$file" "$destination"
			BACK_COUNT=$((BACK_COUNT + 1))
		else
			echo "File Already Exist"
		fi
	fi
done
echo "Backup Completed!"
echo "Total Files Backed Up: $BACK_COUNT"
echo ""
echo "Requirement 6 - Backup Report"
LOG_FILE="$BACKUP_DIR/backup_report.log"
TOTAL_FILES="${#FILES[@]}"
TOTAL_SIZE=0
for file in "${FILES[@]}"
do
	size=$(stat -c%s "$file")
	TOTLA_SIZE=$((TOTAL_SIZE+size))
done

echo "BACKUP REPORT" > "$LOG_FILE"
echo "" >> "$LOG_FILE"
echo "TOTAL FILES PROCESSED: $TOTAL_FILES" >> "$LOG_FILE"
echo "TOTAL FILES BACKED UP: $BACK_COUNT" >> "$LOG_FILE"
echo "TOTAL SIZE BACKED UP : $TOTAL_SIZE" >> "$LOG_FILE"
echo "BACKUP DIRECTORY PATH: $BACKUP_DIR" >> "$LOG_FILE"
echo "REPORT ON : $(date)" >> "$LOG_FILE"
echo ""
echo "BACKUP FILE SAVED AT $LOG_FILE"

