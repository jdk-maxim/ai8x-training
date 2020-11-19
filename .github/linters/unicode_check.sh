#!/bin/bash

# Move to project root directory
cd ../..

if find . \( -iname "*.py" -o -iname "*.sh" -o -iname "*.c" -o -iname "*.h" \) -print0 | xargs -0 grep -Pn '[^\0-\x7f]';
then
    #If we get here, that means we found at least one file with unicode in it.
    echo
    printf "\t \033[1;31m***> Found Unicode in files\n\033[0m"
    echo
    exit 1
else
    echo
    printf "\t \033[1;32m***> No Unicode found in files\n\033[0m"
    echo
    exit 0
fi
