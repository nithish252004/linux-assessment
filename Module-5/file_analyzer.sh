#!/bin/bash
echo "Module-5 File Analyzer"

view_help(){
	cat << EOF
	
	FILE ANALYZER



How to use :
./file_analyzer.sh [options]


options:
	-d     : Search inside the directory
	-k     : Search a Keyword inside a file
	-f     : search inside a file
	--help : View Help menu


EOF
}
echo "Requirement 1 - Help functionality"
if [[ "$1" == "--help" ]]; then
	view_help
	exit 0
fi
echo "In order to view --help , execute the command as ./file_analyzer.sh --help"
echo ""
echo "Requirement-2 - Parse the options with getopts"
echo ""
echo "Requirement-3 Keyword Validation"
validate_keyword() {
        if [[ -z "$KEYWORD" ]]; then
                echo "Keyword Cannot be empty"
		exit 1
        fi
        if [[ ! "$KEYWORD" =~ ^[a-zA-Z0-9_]+$ ]]; then
                echo "Invalid Keyword, Only letters,numbers,underscore are allowed"
                exit 1
        fi
}
while getopts ":d:k:f:" opt; do 
	case "$opt" in
		d)
			DIRECTORY="$OPTARG"
			;;
		k) 
			KEYWORD="$OPTARG"
			;;
		f)
			FILE="$OPTARG"
			;;
		\?)
			echo "Invalid Option : -$OPTARG"
			view_help
			exit 1
			;;
		:)
			echo "No Arugements given by the user"
			exit 1
			;;
	esac
done
validate_keyword
echo "After KeyWord Validation"
echo "Directory : $DIRECTORY"
echo "File      :$FILE"
echo "Keyword   :$KEYWORD"
echo ""
ERROR_LOG="errors.log"
log_error(){
        echo "ERROR : $1" | tee -a "$ERROR_LOG"
}

echo "Requirement-4 Search Keyword using Here String"
if [[ -n "$FILE" ]]; then
	echo "Checking Whether the keyword exist in the file"

	if [[ ! -f "$FILE" ]]; then
		log_error "File Does'nt Exist, Try Again"
		exit 1
	fi

	content=$(cat "$FILE")
	grep "$KEYWORD" <<< "$content"

	if [[ $? -eq 0 ]]; then
		echo "$KEYWORD Found in the $FILE"
	else
		echo "$KEYWORD is not found in the $FILE"
	fi
fi
echo ""
search_directory() {

	echo "Requirement-5 Recursive Search"

		if [[ ! -d "$DIRECTORY" ]]; then
			log_error "Directory Does'nt Exist , Try Again"
			exit 1
		fi

		if grep -r "$KEYWORD" "$DIRECTORY" ; then
			echo "$KEYWORD is found in the $DIRECTORY"
		else
			echo "$KEYWORD is not found in the $DIRECTORY"
		fi
	}



if [[ -n "$DIRECTORY" ]]; then 
       echo "Checking whether the keyword exist in the directory"
       search_directory
fi       
echo "Error Logging"
echo ""
echo "Script Name : $0"
echo "Total Arguments passed : $@"
echo "Number of Arguments passed : $#"
echo ""

if [[ $# -eq 0 ]]; then
	log_error "No options provided, Try again"
	view_help
	exit 1
fi

