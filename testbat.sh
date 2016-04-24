#!/bin/bash

exe="alsabat"
file_sin="default.wav"
file_sin_dual="default_dual.wav"
logdir="tmp"
# default devices
dev_playback="default"
dev_capture="default"
# features passes vs. features all
feature_pass=0
feature_cnt=0

commands="$exe -P $dev_playback -C $dev_capture"

init_counter () {
	feature_pass=0
	feature_all=0
}

evaluate_result () {
	feature_cnt=$((feature_cnt+1))
	if [ $1 -eq 0 ]; then
		feature_pass=$((feature_pass+1))
		echo "pass"
	else
		echo "fail"
	fi
#	sleep 4
}

print_result () {
	echo "[$feature_pass/$feature_cnt] features passes."
}

feature_test () {
	echo "============================================"
	echo "$feature_cnt: ALSA $2"
	echo "-------------------------------------------"
	echo "$commands $1 --log=$logdir/$feature_cnt.log"
	$commands $1 --log=$logdir/$feature_cnt.log
	evaluate_result $?
	echo "$commands $1" >> $logdir/$((feature_cnt-1)).log
}

# test items
feature_list_test () {
	commands="$exe"
	feature_test "--saveplay ${file_sin}" "generate test file with default params"
	feature_test "-P $dev_playback" "single line mode, playback"
	feature_test "-C $dev_capture --standalone" "single line mode, capture"
	commands="$exe -P $dev_playback -C $dev_capture"
	feature_test "--file ${file_sin}" "play wav file and detect"
	feature_test "" "generate sine wave and detect"
	feature_test "-c1" "configurable channel number: 1"
	feature_test "-c2 -F 19:16757" "configurable channel number: 2"
	feature_test "-r44100" "configurable sample rate: 44100"
	feature_test "-r48000" "configurable sample rate: 48000"
	feature_test "-n16387" "configurable duration: in samples"
	feature_test "-n2.5s" "configurable duration: in seconds"
	feature_test "-f U8 --saveplay U8.wav" "configurable data depth: 8 bit"
	feature_test "-f S16_LE --saveplay S16_LE.wav" "configurable data depth: 16 bit"
	feature_test "-f S24_3LE --saveplay S24_3LE.wav" "configurable data depth: 24 bit"
	feature_test "-f S32_LE --saveplay S32_LE.wav" "configurable data depth: 32 bit"
	feature_test "-f cd --saveplay cd.wav" "configurable data depth: cd"
	feature_test "-f dat --saveplay dat.wav" "configurable data depth: dat"
	tmpfreq=17583
	feature_test "-F $tmpfreq --standalone" "standalone mode: play and capture"
	latestfile=`ls -t1 /tmp/bat.wav.* | head -n 1`
	feature_test "--local -F $tmpfreq --file $latestfile" "local mode: analyze local file"

	print_result
}

feature_test_tiny () {
	echo "============================================"
	echo "$feature_cnt: tinyalsa $2"
	echo "-------------------------------------------"
	echo "$commands -c2 -t $1 --log=$logdir/$feature_cnt.log"
	$commands -c2 -t $1 --log=$logdir/$feature_cnt.log
	evaluate_result $?
	echo "$commands -c2 -t $1" >> $logdir/$((feature_cnt-1)).log
}

# tinyalsa test items; device may not support "default" name nor some formats
feature_list_test_tiny () {
	commands="$exe"
	feature_test_tiny "-P $dev_playback" "single line mode, playback"
	feature_test_tiny "-C $dev_capture --standalone" "single line mode, capture"
	commands="$exe -P $dev_playback -C $dev_capture"
	feature_test_tiny "--saveplay ${file_sin_dual}" "generate sine wave and detect"
	feature_test_tiny "--file ${file_sin_dual}" "play wav file and detect"
	feature_test_tiny "-F 19:16757" "configurable channel number: 2"
	feature_test_tiny "-r44100" "configurable sample rate: 44100"
	feature_test_tiny "-r48000" "configurable sample rate: 48000"
	feature_test_tiny "-n16387" "configurable duration: in samples"
	feature_test_tiny "-n2.5s" "configurable duration: in seconds"
	feature_test_tiny "-f S16_LE --saveplay S16_LE.wav" "configurable data depth: 16 bit"
	feature_test_tiny "-f S32_LE --saveplay S32_LE.wav" "configurable data depth: 32 bit"
	feature_test_tiny "-f cd --saveplay cd.wav" "configurable data depth: cd"
	feature_test_tiny "-f dat --saveplay dat.wav" "configurable data depth: dat"
	tmpfreq=17583
	feature_test_tiny "-F $tmpfreq --standalone" "standalone mode: play and capture"
	latestfile=`ls -t1 /tmp/bat.wav.* | head -n 1`
	feature_test_tiny "--local -F $tmpfreq --file $latestfile" "local mode: analyze local file"

	print_result
	}

echo "*******************************************"
echo "                BAT Test                   "
echo "-------------------------------------------"

# get device
echo "usage:"
echo "  $0 <sound card>"
echo "  $0 <device-playback> <device-capture> <1 for tinyalsa, blank for alsa>"

use_tinyalsa="0"

if [ $# -eq 3 ]; then
	dev_playback=$1
	dev_capture=$2
	use_tinyalsa=$3
elif [ $# -eq 2 ]; then
	dev_playback=$1
	dev_capture=$2
elif [ $# -eq 1 ]; then
	dev_playback=$1
	dev_capture=$1
fi

echo "current setting:"
echo "  $0 $dev_playback $dev_capture $3"

# run
logdir="tmp"
mkdir -p $logdir
init_counter
if [ $use_tinyalsa = "1" ]; then
	feature_list_test_tiny
else
	feature_list_test
fi

echo "*******************************************"
