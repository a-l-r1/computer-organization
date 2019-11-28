#!/bin/bash
TB_NAME=pipelined3
CI_FILENAME=tests/cpu/${TB_NAME}/test-list

while IFS= read -r -u3 line; do
    tools/test-ng.sh $line
done 3< ${CI_FILENAME}

