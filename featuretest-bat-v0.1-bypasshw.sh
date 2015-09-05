#!/bin/bash

# Please edit variables per platform
bin="./bat"
dev_playback="plughw:0,0"
dev_capture="plughw:0,0"
file_sin="test.wav"
file_dbg="./saveplay.wav"

echo "====quick start"
${bin} -P ${dev_playback} -c 1 -F 997 -n 0.5s --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 997 -l -f ${file_dbg}
echo "====feature: play wav file and detect"
${bin} -P ${dev_playback} -C ${dev_capture} -f ${file_sin} -l
echo "====feature: generate sine wave and detect"
${bin} -P ${dev_playback} -F 13,16974 --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 13,16974 -l -f ${file_dbg}
echo "====feature: configurable channel number"
${bin} -P ${dev_playback} -c 1 -F 997 --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 997 -l -f ${file_dbg}
echo "====feature: configurable sample rate: 44100"
${bin} -P ${dev_playback} -c 1 -F 997 -r 44100 --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 997 -l -f ${file_dbg}
echo "====feature: configurable sample rate: 48000"
${bin} -P ${dev_playback} -c 1 -F 997 -r 48000 --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 997 -l -f ${file_dbg}
echo "====feature: configurable duration: in samples"
${bin} -P ${dev_playback} -c 1 -F 997 -n 45678 --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 997 -l -f ${file_dbg}
echo "====feature: configurable duration: in seconds"
${bin} -P ${dev_playback} -c 1 -F 997 -n 2.5s --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 997 -l -f ${file_dbg}
echo "====feature: configurable data depth: 8 bit"
${bin} -P ${dev_playback} -c 1 -F 997 -s 1 --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 997 -l -f ${file_dbg}
echo "====feature: configurable data depth: 16 bit"
${bin} -P ${dev_playback} -c 1 -F 997 -s 2 --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 997 -l -f ${file_dbg}
echo "====feature: configurable data depth: 24 bit"
${bin} -P ${dev_playback} -c 1 -F 997 -s 3 --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 997 -l -f ${file_dbg}
echo "====feature: configurable data depth: 32 bit"
${bin} -P ${dev_playback} -c 1 -F 997 -s 4 --saveplay ${file_dbg}
${bin} -P ${dev_playback} -C ${dev_capture} -F 997 -l -f ${file_dbg}
