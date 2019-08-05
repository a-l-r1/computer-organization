#!/bin/sh
tmpdir=`mktemp -d -p tmp`

echo 'now launching MARS, beware of dead loops'
tools/simulate-mars.py $2 > ${tmpdir}/ref_output
tools/simulate.py $1 $2 > ${tmpdir}/output

dos2unix ${tmpdir}/ref_output
dos2unix ${tmpdir}/output

sed -i '1,5d' ${tmpdir}/output
sed -i 's/^.*[0-9].*@/@/g' ${tmpdir}/output

sed -i 's/\0\n//g' ${tmpdir}/ref_output
sed -i 's/\0\n//g' ${tmpdir}/output

colordiff -u ${tmpdir}/ref_output ${tmpdir}/output

echo 'please ignore the trailing newline of output'

echo 'return code' $?

if [ $? == 0 ]
then
	echo 'correct! have a nice day.'
fi

#rm -rf ${tmpdir}

