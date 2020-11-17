#!/bin/sh -l

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold fonts
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

do_a_test_expect_success()
{
	echo
	printf "\t ${BBlue}***> Running Test %s with command: %s\n${Color_Off}" "$2" "$1"
	echo

	# Run the command, parameter 1
	if ! $1;
	then
		echo
		printf "\t ${BRed}***> Failed to %s\n${Color_Off}" "$2"
		echo
		exit 1
	else
		echo
		printf "\t ${BGreen}***> %s Completed, Success\n${Color_Off}" "$2"
		echo
	fi
}

do_a_test_expect_failure()
{
	echo
	printf "\t ${BBlue}***> Running Test %s with command: %s\n${Color_Off}" "$2" "$1"
	echo

	# Run the command, parameter 1

	if $1;
	then
		echo
		printf "\t ${BRed}***> %s Completed without Error, but was expected to fail\n${Color_Off}" "$2"
		echo
		exit 1
	else
		echo
		printf "\t ${BGreen}***> %s Failed as expected, Success\n${Color_Off}" "$2"
		echo
	fi
}

show_banner()
{
    printf "\n\n${BWhite}***********************************\n"
    printf     " ${BWhite}$1\n"
    printf "\n\n${BWhite}***********************************\n"
}

show_banner "Starting regression actions"

show_banner "Verify required commands exist"
do_a_test_expect_success "uname -a" "Running on OS:"
do_a_test_expect_success "command -v python3" "python3 install check"
do_a_test_expect_success "command -v pip3" "pip3 install check"
do_a_test_expect_success "python3 -m pip install -U pip wheel setuptools" "Update python basics"
do_a_test_expect_success "python3 -m pip install -U pip wheel setuptools" "Update python basics"
do_a_test_expect_success "python3 -m pip --version" "Show pip version"

do_a_test_expect_success "pwd" "Current directory"
do_a_test_expect_success "cd $GITHUB_WORKSPACE" "Changing to checkout directory..."
do_a_test_expect_success "pwd" "Checkout directory"
do_a_test_expect_success "ls" "Directory contents"

show_banner "Starting Regression Tests..."
do_a_test_expect_success "python3 -m pip install -r requirements.txt" "Install requirements.txt"
