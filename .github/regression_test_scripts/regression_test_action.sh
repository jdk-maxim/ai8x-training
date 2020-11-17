#!/bin/sh -l

# Bold fonts
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BBlue='\033[1;34m'        # Blue
BWhite='\033[1;37m'       # White

do_a_test_expect_success()
{
	echo
	printf "\t %s***> Running Test %s with command: %s\n" "${BBlue}" "$2" "$1"
	echo

	# Run the command, parameter 1
	if ! $1;
	then
		echo
		printf "\t %s***> Failed to %s\n" "${BRed}" "$2"
		echo
		exit 1
	else
		echo
		printf "\t %s***> %s Completed, Success\n" "${BGreen}" "$2"
		echo
	fi
}

do_a_test_expect_failure()
{
	echo
	printf "\t %s***> Running Test %s with command: %s\n" "${BBlue}" "$2" "$1"
	echo

	# Run the command, parameter 1

	if $1;
	then
		echo
		printf "\t %s***> %s Completed without Error, but was expected to fail\n" "${BRed}" "$2"
		echo
		exit 1
	else
		echo
		printf "\t %s***> %s Failed as expected, Success\n" "${BGreen}" "$2"
		echo
	fi
}

show_banner()
{
    printf "\n\n%s***********************************\n" "${BBlue}"
    printf     "%s%s" "${BBlue}" "$1"
    printf "\n\n%s***********************************\n" "${BBlue}"
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
do_a_test_expect_success "pytest test_*.py" "Run all python tests of format test_*py"
