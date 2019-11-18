#!/bin/bash

TMPDIR=`mktemp -d -p tmp`
echo "[*] tmpdir: ${TMPDIR}"
echo "[*] generating LaTeX code for: $1"
FILENAME=${TMPDIR}/example-single.tex

touch ${FILENAME}

echo "\\begin{lstlisting}[language={[mips]Assembler}]" >> ${FILENAME}
cat $1 >> ${FILENAME}
echo "\\end{lstlisting}" >> ${FILENAME}

echo "\\begin{verbatim}" >> ${FILENAME}

# simulate-mars.py
java -jar tools/mars.jar db mc CompactDataAtZero nc $1 >> ${FILENAME}

echo "\\end{verbatim}" >> ${FILENAME}

xclip < ${FILENAME}

echo "[*] contents copied to X clipboard"

