#!/bin/bash

bin="bat"
file_sin="default.wav"
logdir="tmp"
# default devices
dev_playback="default"
dev_capture="default"
# features passes vs. features all
feature_pass=0
feature_cnt=0

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
	sleep 4
}

print_result () {
	echo "[$feature_pass/$feature_cnt] features passes."
}

echo "*******************************************"
echo "            BAT feature tests              "
echo "-------------------------------------------"
echo "usage:"
echo "  $0 <device-playback> <device-capture>"

# init
mkdir -p $logdir
init_counter

if [ $# -eq 2 ]; then
	dev_playback=$1
	dev_capture=$2
elif [ $# -eq 1 ]; then
	dev_playback=$1
	dev_capture=$1
fi

echo "current setting:"
echo "  $0 $dev_playback $dev_capture"

# test items
echo "============================================"
echo "$feature_cnt: generate test file with default params"
echo "-------------------------------------------"
$bin --saveplay ${file_sin} --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: play wav file and detect"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture --file ${file_sin} --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: generate sine wave and detect"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable channel number: 1"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -c 1 --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable channel number: 2"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -c 2 -F 19:16757 --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable sample rate: 44100"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -r 44100 --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable sample rate: 48000"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -r 48000 --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable duration: in samples"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -n 16387 --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable duration: in seconds"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -n 2.5s --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable data depth: 8 bit"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -f U8 --saveplay U8_2.wav --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable data depth: 16 bit"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -f S16_LE --saveplay S16_LE_2.wav --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable data depth: 24 bit"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -f S24_3LE --saveplay S24_3LE_2.wav --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable data depth: 32 bit"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -f S32_LE --saveplay S32_LE_2.wav --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable data depth: cd"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -f cd --log=$logdir/$feature_cnt.log
evaluate_result $?
echo "============================================"
echo "$feature_cnt: configurable data depth: dat"
echo "-------------------------------------------"
$bin -P $dev_playback -C $dev_capture -f dat --log=$logdir/$feature_cnt.log
evaluate_result $?
print_result
echo "*******************************************"
