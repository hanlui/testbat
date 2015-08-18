#!/bin/bash

script="./testbat.sh"	#script for bat path test
log=$0.log

# Usage:
#
# 1. please edit following variables per platform (HSW, BDW, SKL, ...)
#
##################### variables need edit #####################################
# default devices. You can edit per platform.
# dev dp playback
devdp="plughw:0,3"
# dev hdmi playback
devhp="plughw:0,7"
# dev analog playback
devcp="plughw:0,0"
# dev analog capture
devcm="plughw:0,0"

# target frequency of test points. You can edit the value and choose
# how many points to check.
freq00=10
freq01=31
freq02=73
freq03=155
freq04=380
freq05=977
freq06=1932
freq07=4119
freq08=8197
freq09=16197

# repeats of testing, please edit per requirement
n=1
# 1 for combo and 2 for lineout/linein
chan=1
##################### variables need edit #####################################

# 2. connection and command
#
#    command for mono channel test:
#      $ ./testbat-all.sh 1 <number of repeats>
#    command will pause.
#    for each item a), b) and c), connect cable and hit 'Enter' to continue.
#    to bypass, input 'b'.
#    connection for mono channel test: (an adapter must be applied)
#    a) DP hp		<---> adapter mic
#    b) HDMI hp		<---> adapter mic
#    c) adapter hp	<---> adapter mic
#
#    command for dual channel test:
#      $ ./testbat-all.sh 2 <number of repeats>
#    command will pause.
#    for each item a), b) and c), connect cable and hit 'Enter' to continue.
#    to bypass, input 'b'.
#    connection for dual channel test:
#    a) DP hp		<---> line in mic
#    b) HDMI hp		<---> line in mic
#    c) line out hp	<---> line in mic
#

if [ $# -eq 2 ]; then
	chan=$1
	n=$2
elif [ $# -eq 1 ]; then
	chan=$1
else
	echo "Use default parameter: ${chan} channel, ${n} repeat."
fi

echo "Please connect DP hp to mic, and then hit 'Enter' key to continue."
echo "To bypass, input 'b' and then hit 'Enter' key."
read c
if [ "${c}" != "b" ]; then
	echo "Test DP hp to mic ${n} rounds"
	${script} ${devdp} ${devcm} ${chan} ${freq00} ${n} >> ${log}
	${script} ${devdp} ${devcm} ${chan} ${freq01} ${n} >> ${log}
	${script} ${devdp} ${devcm} ${chan} ${freq02} ${n} >> ${log}
	${script} ${devdp} ${devcm} ${chan} ${freq03} ${n} >> ${log}
	${script} ${devdp} ${devcm} ${chan} ${freq04} ${n} >> ${log}
	${script} ${devdp} ${devcm} ${chan} ${freq05} ${n} >> ${log}
	${script} ${devdp} ${devcm} ${chan} ${freq06} ${n} >> ${log}
	${script} ${devdp} ${devcm} ${chan} ${freq07} ${n} >> ${log}
	${script} ${devdp} ${devcm} ${chan} ${freq08} ${n} >> ${log}
	${script} ${devdp} ${devcm} ${chan} ${freq09} ${n} >> ${log}
	echo "Test is Done"
fi
echo ""
echo "Please connect HDMI hp to mic, and then hit 'Enter' key to continue."
echo "To bypass, input 'b' and then hit 'Enter' key."
read c
if [ "${c}" != "b" ]; then
	echo "Test HDMI hp to mic ${n} rounds"
	${script} ${devhp} ${devcm} ${chan} ${freq00} ${n} >> ${log}
	${script} ${devhp} ${devcm} ${chan} ${freq01} ${n} >> ${log}
	${script} ${devhp} ${devcm} ${chan} ${freq02} ${n} >> ${log}
	${script} ${devhp} ${devcm} ${chan} ${freq03} ${n} >> ${log}
	${script} ${devhp} ${devcm} ${chan} ${freq04} ${n} >> ${log}
	${script} ${devhp} ${devcm} ${chan} ${freq05} ${n} >> ${log}
	${script} ${devhp} ${devcm} ${chan} ${freq06} ${n} >> ${log}
	${script} ${devhp} ${devcm} ${chan} ${freq07} ${n} >> ${log}
	${script} ${devhp} ${devcm} ${chan} ${freq08} ${n} >> ${log}
	${script} ${devhp} ${devcm} ${chan} ${freq09} ${n} >> ${log}
	echo "Test is Done"
fi
echo ""
echo "Please connect hp to mic, and then hit 'Enter' key to continue."
echo "To bypass, input 'b' and then hit 'Enter' key."
read c
if [ "${c}" != "b" ]; then
	echo "Test hp to mic ${n} rounds"
	${script} ${devcp} ${devcm} ${chan} ${freq00} ${n} >> ${log}
	${script} ${devcp} ${devcm} ${chan} ${freq01} ${n} >> ${log}
	${script} ${devcp} ${devcm} ${chan} ${freq02} ${n} >> ${log}
	${script} ${devcp} ${devcm} ${chan} ${freq03} ${n} >> ${log}
	${script} ${devcp} ${devcm} ${chan} ${freq04} ${n} >> ${log}
	${script} ${devcp} ${devcm} ${chan} ${freq05} ${n} >> ${log}
	${script} ${devcp} ${devcm} ${chan} ${freq06} ${n} >> ${log}
	${script} ${devcp} ${devcm} ${chan} ${freq07} ${n} >> ${log}
	${script} ${devcp} ${devcm} ${chan} ${freq08} ${n} >> ${log}
	${script} ${devcp} ${devcm} ${chan} ${freq09} ${n} >> ${log}
	echo "Test is Done"
fi
