#!/bin/bash

# Move to project root directory
cd ../..

if git ls-files -s | grep "\.sh$" | grep "^100644";
then
    #If we get here, that means we found at least one file with unicode in it.
    echo
    printf "\t \033[1;31m***> Found Shell File WITHOUT exec bit set\n\033[0m"
    echo
    exit 1
else
    echo
    printf "\t \033[1;32m***> All shell files have exec bit set\n\033[0m"
    echo
    exit 0
fi
