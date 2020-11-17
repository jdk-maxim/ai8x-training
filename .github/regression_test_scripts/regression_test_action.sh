#!/bin/sh -l

do_a_test_expect_success()
{
	echo
	printf "\t ***> Running Test %s with command: %s\n" "$2" "$1"
	echo

	# Run the command, parameter 1
	if ! $1;
	then
		echo
		printf "\t ***> Failed to %s\n" "$2"
		echo
		exit 1
	else
		echo
		printf "\t ***> %s Completed, Success\n" "$2"
		echo
	fi
}

do_a_test_expect_failure()
{
	echo
	printf "\t ***> Running Test %s with command: %s\n" "$2" "$1"
	echo

	# Run the command, parameter 1

	if $1;
	then
		echo
		printf "\t ***> %s Completed without Error, but was expected to fail\n" "$2"
		echo
		exit 1
	else
		echo
		printf "\t ***> %s Failed as expected, Success\n" "$2"
		echo
	fi
}

echo "Starting regression actions"


echo "Verify required commands exist"
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

echo "\n\n******************************\nStarting Regression Tests...\n******************************\n\n"
do_a_test_expect_success "python3 -m pip install -r requirements.txt" "Install requirements.txt"
