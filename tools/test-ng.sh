#!/bin/bash
# test-ng without any cruft, since we're on unix land
# TODO: blatant hack to make auto-generated ISE circuit fairies happy
export XILINX_DSP=/opt/Xilinx/14.7/ISE_DS/ISE
export XILINX_EDK=/opt/Xilinx/14.7/ISE_DS/EDK
export XILINX_PLANAHEAD=/opt/Xilinx/14.7/ISE_DS/PlanAhead 
export LD_LIBRARY_PATH=/opt/Xilinx/14.7/ISE_DS/ISE//lib/lin64:/opt/Xilinx/14.7/ISE_DS/ISE/lib/lin64:/opt/Xilinx/14.7/ISE_DS/ISE/smartmodel/lin64/installed_lin64/lib:/opt/Xilinx/14.7/ISE_DS/ISE/sysgen/lib:/opt/Xilinx/14.7/ISE_DS/EDK/lib/lin64:/opt/Xilinx/14.7/ISE_DS/common/lib/lin64
export XILINX=/opt/Xilinx/14.7/ISE_DS/ISE/
export PATH=/opt/Xilinx/14.7/ISE_DS/ISE//bin/lin64:/opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64:/opt/Xilinx/14.7/ISE_DS/ISE/sysgen/util:/opt/Xilinx/14.7/ISE_DS/ISE/sysgen/bin:/opt/Xilinx/14.7/ISE_DS/ISE/../../../DocNav:/opt/Xilinx/14.7/ISE_DS/PlanAhead/bin:/opt/Xilinx/14.7/ISE_DS/EDK/bin/lin64:/opt/Xilinx/14.7/ISE_DS/EDK/gnu/microblaze/lin/bin:/opt/Xilinx/14.7/ISE_DS/EDK/gnu/powerpc-eabi/lin/bin:/opt/Xilinx/14.7/ISE_DS/EDK/gnu/arm/lin/bin:/opt/Xilinx/14.7/ISE_DS/EDK/gnu/microblaze/linux_toolchain/lin64_be/bin:/opt/Xilinx/14.7/ISE_DS/EDK/gnu/microblaze/linux_toolchain/lin64_le/bin:/opt/Xilinx/14.7/ISE_DS/common/bin/lin64:/home/a-l-r/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export LMC_HOME=/opt/Xilinx/14.7/ISE_DS/ISE/smartmodel/lin64/installed_lin64

TB_NAME=pipelined2
TMPDIR=`mktemp -d -p tmp`

# NOTE: mind to change testbench names and branch delay slot availability

echo "[*] tmpdir: ${TMPDIR}"
echo "[*] testing: $1"

# mips-as.py
java -jar tools/mars.jar nc db mc CompactDataAtZero a dump .text HexText project/code.txt $1

# simulate.py
pushd project
./${TB_NAME}_tb_isim_beh.exe -intstyle ise -tclbatch ../tools/share/isim.cmd -wdb project/${TB_NAME}_tb_isim_beh.wdb > ../${TMPDIR}/output
popd
# sed(1) post-processing
sed -i '/^ISim P\.20131013 (signature 0xfbc00daa)$/d' ${TMPDIR}/output
sed -i '/^This is a Full version of ISim.$/d' ${TMPDIR}/output
sed -i '/^Time resolution is 1 ps$/d' ${TMPDIR}/output
sed -i '/^Simulator is doing circuit initialization process\.$/d' ${TMPDIR}/output
sed -i '/^Finished circuit initialization process\.$/d' ${TMPDIR}/output
sed -i '/^Stopped at time : .*$/d' ${TMPDIR}/output
# add a newline for compatibility with MARS outputs
echo '' >> ${TMPDIR}/output
# remove $time
sed -i 's/^[ ]*[0-9]*//g' ${TMPDIR}/output

# simulate-mars.py
java -jar tools/mars.jar db mc CompactDataAtZero nc $1 > ${TMPDIR}/ref_output

colordiff -u ${TMPDIR}/ref_output ${TMPDIR}/output
DIFF_EXIT_STATUS=$?

if [ ${DIFF_EXIT_STATUS} -eq 0 ]; then
	echo "[+] test passed on $1"
else
	echo "[-] test failed on $1, manual inspection needed"
	read
fi

