#!/bin/bash
loops=100
pass=0
samples=2000
freq=("16387")
#freq=("16387" "8177" "4091" "2049" "1023" "511" "257" "123" "67" "29" "17")

echo ""
echo "******************************"
echo "      bat stress test         "
echo "------------------------------"
echo "usage:"
echo "  bs.sh <samples>"
echo "  bs.sh <samples> <loops>"
echo "******************************"
echo ""

if [ $# -eq 2 ]; then
	samples=$1
	loops=$2
elif [ $# -eq 1 ]; then
	samples=$1
fi

for f in "${freq[@]}"
do
	pass=0
#	for i in {1..3}
	for ((i=0; i<${loops}; )); do
		bat -F $f -n $samples --log=tmp.log
		if [ $? -eq 0 ]; then
			let pass=pass+1
		fi
		let i=i+1
		echo "test round: $i/$loops"
	done
	echo "passrate for freq [ $f ]: [ $pass% ]"
done
