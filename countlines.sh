#!/bin/bash
##Purpose:count the number of lines in files located in the current directory when they belong to an owner or when were created in a specific month
##Version:1.0
##Author:Pedro Gonzalez
## START ##

fun(){
	local owner="$1"
	local month="$2"
	if  [[ -n $owner && -n $month ]] ;then
		echo "only one argument is allowed"
	elif [[ -n $owner ]] ; then
		find . -type f -user $owner -exec bash -c 'echo "File: {} Lines: $(wc -l < "{}")"' \;
	elif [[ -n $month ]] ; then
		find . -type f -exec bash -c 'file_month=$(date -r "{}" "+%B"); [[ ${file_month,,} == *"${month,,}"* ]] && echo "File: {} Lines: $(wc -l < "{}")"' \;
	else 
		echo "invalid, no argument"
		echo $'search by owner... countlines.sh -o [user] \nsearch by month... countlines.sh -m [month]'

	fi
}

while getopts ":o:m:" option; do
		case $option in
			o) owner=$OPTARG
				;;
			m) month=$OPTARG
				;;
			:) echo "option -$OPTARG requires an argument"
				;;
			\?) echo $' invalid, something is wrong \nsearch by owner... countlines.sh -o [user] \nsearch by month... countlines.sh -m [month]'
				;;
		esac
done
fun "$owner" "$month"
## END ##
