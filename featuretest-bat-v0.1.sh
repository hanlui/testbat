#!/bin/bash

# Please edit variables per platform
bin="./bat"
dev_playback="plughw:1,0"
dev_capture="plughw:1,0"
file_sin="997.wav"


echo "feature: play wav file and detect"
${bin} -P ${dev_playback} -C ${dev_capture} --file ${file_sin}
echo "feature: generate sine wave and detect"
${bin} -P ${dev_playback} -C ${dev_capture} -F 997
echo "feature: configurable channel number"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997
echo "feature: configurable sample rate: 44100"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997 -r 44100
echo "feature: configurable sample rate: 48000"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997 -r 48000
echo "feature: configurable duration: in samples"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997 -n 45678
echo "feature: configurable duration: in seconds"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997 -n 2.5s
echo "feature: configurable data depth: 8 bit"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997 -f U8
echo "feature: configurable data depth: 16 bit"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997 -f S16_LE
echo "feature: configurable data depth: 24 bit"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997 -f S24_3LE
echo "feature: configurable data depth: 32 bit"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997 -f S32_LE
echo "feature: configurable data depth: cd"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997 -f cd
echo "feature: configurable data depth: dat"
${bin} -P ${dev_playback} -C ${dev_capture} -c 1 -F 997 -f dat
