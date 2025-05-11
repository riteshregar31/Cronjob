#!/bin/bash

# Directory paths
TEXT_DIR="/Users/riteshregar/documents/mentor_cmdp/input"  # Folder containing text files
CSV_FILE="/Users/riteshregar/documents/mentor_cmdp/output.csv"
ARCHIVE_DIR="/Users/riteshregar/documents/mentor_cmdp/archive"
NAME_MAP="/Users/riteshregar/documents/mentor_cmdp/name_map.csv"  

# Create the output directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Ensure the CSV file has headers if it doesn't already exist
if [ ! -f "$CSV_FILE" ]; then
    echo "File Name,Name,Frequency,Timestamp" > "$CSV_FILE"
fi

# Generate a random number between 1 and 20
RANDOM_NUM=$((RANDOM % 20 + 1))

# Get the name associated with the random number from the name_map.csv
RANDOM_NAME=$(awk -F, -v num=$RANDOM_NUM 'NR == num + 1 {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}' "$NAME_MAP")

# Check if the name is found
if [ -z "$RANDOM_NAME" ]; then
    echo "Error: Could not find name for number $RANDOM_NUM in $NAME_MAP"
    exit 1
fi

# Loop through each text file in the input directory
for TEXT_FILE in "$TEXT_DIR"/*.txt; do
    if [[ -f "$TEXT_FILE" ]]; then  # Ensure it's a file
        # Count the frequency of the random name in the current text file
        FREQUENCY=$(grep -o -i "\b$RANDOM_NAME\b" "$TEXT_FILE" | wc -l)
        
        # Get the current timestamp for when the file is accessed
        TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

        # Log the timestamp to a file in the archive directory for the current text file
        FILENAME_BASENAME=$(basename "$TEXT_FILE")
        echo "File accessed at: $TIMESTAMP" >> "$ARCHIVE_DIR/${FILENAME_BASENAME}_access_timestamp.txt"
        
        # Log to the CSV file: file name, frequency, timestamp
        echo "$(basename "$TEXT_FILE"),$RANDOM_NAME,$FREQUENCY,$TIMESTAMP" >> "$CSV_FILE"
        
        # Archive the timestamp for processing each file
        echo "$TIMESTAMP" >> "$ARCHIVE_DIR/timestamp_archive.txt"
        
        # Output the processed information
        echo "Processed file: $(basename "$TEXT_FILE")"
        echo "Searched word: $RANDOM_NAME"
        echo "Frequency: $FREQUENCY"
        echo "Timestamp: $TIMESTAMP"
    fi
done

