#!/bin/sh

# Encodes any video in av1.
# This is a very slow but extremely efficient codec.
#
# Example: $ ./av1.sh video.mp4 video.webm

ffmpeg -i "$1" -c:v libaom-av1 -crf 20 -b:v 0 -pix_fmt yuv420p -pass 1 -an -f null /dev/null
ffmpeg -i "$1" -c:v libaom-av1 -crf 20 -b:v 0 -pix_fmt yuv420p -pass 2 -c:a libopus -b:a 512k "$2"
rm ffmpeg2pass*.log
