#!/bin/bash
exe=bat
devp="plughw:0,3"
devc="plughw:0,0"
chan=1
freq=16975
n=20
#log=$0.log

echo "Input: exe freq n"
if [ $# -eq 5 ]; then
	devp=$1
	devc=$2
	chan=$3
	freq=$4
	n=$5
fi
echo "run './${exe} -P ${devp} -C ${devc} -c ${chan} -F ${freq}' with ${n} repeats"

#rm -f ${log}
pass=0
fail=${n}
for ((i = 0; i < ${n}; i++ ))
do
	#./${exe} -P plughw:0,3 -C plughw:0,0 -c 1 -n 0.5s -F ${freq} >> ${log}
	./${exe} -P ${devp} -C ${devc} -c ${chan} -F ${freq}
	if [ $? -eq 0 ]; then
		echo "pass"
		pass=$((pass+1))
		fail=$((fail-1))
	else
		echo "fail"
	fi
done

echo "test" ${n} "rounds, pass" ${pass} "fail" ${fail} ", passrate" $((pass*100/n)) "%"
