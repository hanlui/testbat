#!/bin/bash

# test files stored in 2 directories: 48000/ and 44100/;
# format of file name: $rate_$nsample_$hzl_$hzr.wav.
#   $rate: sample rate
#   $nsample: samples in file
#   $hzl: frequency of left channel in Hertz
#   $hzr: frequency of right channel in Hertz

DIR_48K=48000
DIR_44K=44100
# threshold level, 26dB is about 5% noise in amplitude
level=26

parse_filename () {
	if [ $# -ne 1 ]; then
		echo "Invalid input"
		return 1
	fi
	path=`echo "$1" | cut -d'/' -f2`
	name=`echo "$path" | cut -d'.' -f1`
	rate=`echo "$name" | cut -d'_' -f1`
	nsample=`echo "$name" | cut -d'_' -f2`
	hzl=`echo "$name" | cut -d'_' -f3`
	hzr=`echo "$name" | cut -d'_' -f4`
#echo "path=$path, name=$name, rate=$rate, nsample=$nsample, hzl=$hzl, hzr=$hzr"
	return 0
}

test_wavs () {
	if [ $# -ne 1 ]; then
		echo "Invalid input: $1"
		return 1
	fi
	pass=0
	fail=0
	for f in $1/*.wav; do
		parse_filename $f
		if [ $? -eq 0 ]; then
			cmdline="alsabat --snr-db $level --local -r$rate -c2 -n$nsample -F$hzl:$hzr --file $f"
			echo "command: "$cmdline
			$cmdline
			if [ $? -ne 0 ]; then
				fail=$((fail+1))
				echo "fail on $i Hz"
				echo ""
			else
				pass=$((pass+1))
				echo ""
			fi
		fi
	done
	echo "Test result of $1/: pass($pass) fail($fail)"
	return 0
}

echo ""
echo "======1.1 stress test on loopback signal: 48000"
test_wavs $DIR_48K
echo ""
echo "======1.2 stress test on loopback signal: 44100"
test_wavs $DIR_44K
