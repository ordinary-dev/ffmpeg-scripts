#!/bin/bash

# Convert all .flac files in the working directory to opus.
#
# Example: ./flac2opus.sh


for file in *.flac; do
    new_name=${file%.flac}.opus
    echo "$file -> $new_name"
    ffmpeg -i "$file" -b:a 512k "$new_name"
done
