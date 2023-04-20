#!/bin/sh

# Encodes any video in av1. This is a very slow but extremely efficient codec.
#
# Example: $ ./av1.sh video.mp4 output.mkv 3:00 60
# The last 2 parameters are the beginning and duration of the video fragment.

# Options
CRF=20
AUDIO_CODEC="libopus"
AUDIO_BITRATE="512k"

# Video
VIDEO_FILE="$2.video.webm"
ENCODING_OPTIONS="-c:v libaom-av1 -crf $CRF -b:v 0 -pix_fmt yuv420p -g 300"
ffmpeg -ss $3 -i "$1" -t $4 $ENCODING_OPTIONS -pass 1 -an -sn -f null /dev/null && \
ffmpeg -ss $3 -i "$1" -t $4 $ENCODING_OPTIONS -pass 2 -an -sn "$VIDEO_FILE"
rm ffmpeg2pass*.log

# Audio
AUDIO_FILE="$2.audio.opus"
ffmpeg -ss $3 -i "$1" -t $4 -c:a $AUDIO_CODEC -b:a $AUDIO_BITRATE -ac 2 "$AUDIO_FILE"

# Final video
ffmpeg -i "$VIDEO_FILE" -i "$AUDIO_FILE" -c copy "$2"
