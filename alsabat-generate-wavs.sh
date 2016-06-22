#!/bin/bash

# Generate test wav files.
# test files stored in 2 directories: 48000/ and 44100/;
# format of file name: $rate_$nsample_$hzl_$hzr.wav.
#   $rate: sample rate
#   $nsample: samples in file
#   $hzl: frequency of left channel in Hertz
#   $hzr: frequency of right channel in Hertz

begin=500
end=14999
nsample=4096

init () {
	pass=0
	fail=0
	hzl=$begin
	hzr=$((hzl+1))
}

generate_wavs () {
	cnt=0
	mkdir -p $rate
	for ((i=$begin; i<$end; )); do
		filename="${rate}/${rate}_${nsample}_${hzl}_${hzr}.wav"
		commands="alsabat --standalone -r$rate -c2 -n$nsample -F$hzl:$hzr --saveplay $filename"
		echo "command: $commands"
		$commands
		let i=i+2
		let hzl=hzl+2
		let hzr=hzr+2
		let cnt=cnt+1
	done
	echo "$cnt wavs generated in $rate/"
}

if [ $# -eq 2 ]; then
	begin=$1
	end=$2
elif [ $# -ne 0 ]; then
	exit 1
fi

echo "generate wav from $begin Hz to $end Hz"

echo ""
echo "======1.1 generate test files with sample rate 48000"
rate=48000
init
generate_wavs
echo ""
echo "======1.2 generate test files with sample rate 44100"
rate=44100
init
generate_wavs
echo ""
echo "done"

