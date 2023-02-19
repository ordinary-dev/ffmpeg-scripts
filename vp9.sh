#!/bin/sh

# Encodes any video in vp9.
#
# Example: $ ./vp9.sh video.mp4 video.webm

ffmpeg -i "$1" -c:v libvpx-vp9 -crf 30 -b:v 0 -pix_fmt yuv420p -pass 1 -an -f null /dev/null
ffmpeg -i "$1" -c:v libvpx-vp9 -crf 30 -b:v 0 -pix_fmt yuv420p -pass 2 -c:a libopus -b:a 196k "$2"
rm ffmpeg2pass*.log
