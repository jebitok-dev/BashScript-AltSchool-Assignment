#!/bin/bash

num_entries=8
list_all=false

usage() {
	echo "Usage: $0 [-d] [-n N] directory"
	echo "Options:"
	echo " -d    List all files and directories"
	echo " -n N   Specify the number of top entries to display (default: 8)"
	exit 1
}

# Parsing command line arguments
while getopts ":dn:" opt; do
	case $opt in
		d)
			list_all=true
			;;
		n) 
			num_entries=$OPTARG
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			usage
			;;
	esac
done

shift $((OPTIND - 1))

# Check if directory argument is provided
if [ -z "$1" ]; then
	echo "Error: Directory argument is missing"
	usage
fi

# Check if directory exists
if [ ! -d "$1" ]; then
	echo "Error: Directory '$1' not found"
	exit 1
fi

# Assign directory argument to a variable
directory=$1

# List disk usage 
if [ "$list_all" == true ]; then
	du -ah "$directory" | sort -rh | head -n "$num_entries"
else
	du -h "$directory" | sort -rh | head -n "$num_entries"
fi
