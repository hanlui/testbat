#!/bin/bash

freq=("16387" "8177" "4091" "2049" "1023" "511" "257" "123" "67" "29" "17")
tmpdir="tmpwav"

echo ""
echo "********************************************"
echo "              bat quick test 2              "
echo "--------------------------------------------"
echo "bat quick test for analysis"
echo "usage:"
echo "  $0 <1 to generate new file>"
echo "     <blank to use current file>"
echo "********************************************"
echo ""

generate=$1
mkdir $tmpdir -p
if [ $generate = "1" ]; then
	for f in "${freq[@]}"
	do
		alsabat -Pdefault --standalone -F $f --saveplay "$tmpdir/$f.wav"
	done
fi

case_pass=0
case_all=0
for f in "${freq[@]}"
do
	alsabat -F $f --local --file "$tmpdir/$f.wav"
	if [ $? -eq 0 ]; then
		let case_pass=case_pass+1
	fi
	let case_all=case_all+1
done
let passrate=$case_pass*100/$case_all
echo "passrate: [ $passrate% ]"
