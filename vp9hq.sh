#!/bin/sh

# Encodes any video in vp9.
# Maintains good video quality.
#
# Example: $ ./vp9hq.sh video.mp4 video.webm

COMMON_PARAMS="-c:v libvpx-vp9 -crf 20 -b:v 0 -pix_fmt yuv420p"

ffmpeg -i "$1" $COMMON_PARAMS -pass 1 -an -f null /dev/null
ffmpeg -i "$1" $COMMON_PARAMS -pass 2 -c:a libopus -b:a 512k -ac 2 "$2"
rm ffmpeg2pass*.log
