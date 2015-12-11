#!/bin/bash

###########################################################################
#            BAT sound path test: connection
#==========================================================================
#    connection for mono channel test: (an adapter must be applied)
#    a) DP hp		<---> adapter mic
#    b) HDMI hp		<---> adapter mic
#    c) adapter hp	<---> adapter mic
#
#    connection for dual channel test:
#    a) DP hp		<---> line in mic
#    b) HDMI hp		<---> line in mic
#    c) line out hp	<---> line in mic
#

bin="bat"
log="$0.log"

# default device: hdmi playback
devhp="plughw:0,3"
# default device: dp playback
devdp="plughw:0,7"
# default device: analog playback
devap="default"
# default device: analog capture
devac="default"
# 1 for combo and 2 for lineout/linein
chans=2
# loops of testing
loops=10
# count of passes vs. count of all
cnt_pass=0

# target frequency of test points. You can edit the value and choose
# how many points to check.
freq_table=("10" "31" "73" "155" "380" "977" "1932" "4119" "8197" "16197")
#freq_table=("16387" "8177" "4091" "2049" "1023" "511" "257" "123" "67" "29" "17")

init_counter () {
	cnt_pass=0
}

evaluate_result () {
	if [ $1 -eq 0 ]; then
		cnt_pass=$((cnt_pass+1))
		echo "pass"
	else
		echo "fail"
	fi
}

print_result () {
	echo "[$cnt_pass/$loops] passes. Passrate $((cnt_pass*100/loops)) %"
}

# pass rate of a given frequency. parameter list:
# <playback device> <capture device> <frequency>
passrate_at_a_freq () {
	init_counter
	for ((i=0; i<$loops; i++))
	do
		$bin -P $1 -C $2 -c $chans -F $3
		evaluate_result $?
	done
	print_result
}

# pass rate of the frequency table. parameter list:
# <playback device> <capture device>
passrate_of_freq_table () {
	echo "Loop test of $1 --> $2, $loops rounds"
	for f in "${freq_table[@]}"
	do
		echo "testing $f Hz..."
		passrate_at_a_freq $1 $2 $f >> ${log}
		echo "passrate for $f Hz: $((cnt_pass*100/loops))%"
	done
	echo "Loop test of $1 --> $2 is Done"
}

echo "*****************************************"
echo "         BAT sound path test             "
echo "========================================="
echo "usage:"
echo "  $0 <channels>"
echo "  $0 <channels> <loops>"
echo "  $0 <channels> <loops> <analog playback dev> <analog capture dev>"
echo "  $0 <channels> <loops> <analog playback dev> <analog capture dev> <hdmi playback dev> <dp playback dev>"

if [ $# -eq 1 ]; then
	chans=$1
elif [ $# -eq 2 ]; then
	chans=$1
	loops=$2
elif [ $# -eq 4 ]; then
	chans=$1
	loops=$2
	devap=$3
	devac=$4
elif [ $# -eq 6 ]; then
	chans=$1
	loops=$2
	devap=$3
	devac=$4
	devhp=$5
	devdp=$6
fi

echo "current setting:"
echo "  bin:              $bin"
echo "  hdmi playback:    $devhp"
echo "  dp playback:      $devdp"
echo "  ananlog playback: $devap"
echo "  ananlog capture:  $devac"
echo "  channels:         $chans"
echo "  loops:            $loops"

echo "Please connect DP hp to mic, and then hit 'Enter' key to continue."
echo "To bypass, input 'b' and then hit 'Enter' key."
read c
if [[ "$c" != "b" ]]; then
	passrate_of_freq_table $devdp $devac
fi
echo ""
echo "Please connect HDMI hp to mic, and then hit 'Enter' key to continue."
echo "To bypass, input 'b' and then hit 'Enter' key."
read c
if [[ "$c" != "b" ]]; then
	passrate_of_freq_table $devhp $devac
fi
echo ""
echo "Please connect hp to mic, and then hit 'Enter' key to continue."
echo "To bypass, input 'b' and then hit 'Enter' key."
read c
if [[ "$c" != "b" ]]; then
	passrate_of_freq_table $devap $devac
fi

