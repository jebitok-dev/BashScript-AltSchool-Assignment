#!/bin/bash 

# check if params are passed correctly and valid number arguements
if [ "$#" -ne 2 ]; then
	echo "Usage: $0 source_directory destination_directory"
	exit 1
fi

# Assign source and destination directories to variables
source_dir="$1"
destination_dir="$2"

# Check if source directory exists and create directory on same path if it doesn't exist
if [ ! -d "$source_dir" -o ! -d "$destination_dir" ]; then
       echo "Source and Destination should be directories"
       mkdir -p "$1"
       mkdir -p "$2"
       echo "Directories created"
       exit 1
fi

# Create backup filename with timestamp
backup_file="backup_$(date +'%Y%m%d_%H%M%S').tar.gz"

# Create tar archive of source directory
tar -czf "$destination_dir/$backup_file" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"

echo "Backup created: $destination_dir/$backup_file"

