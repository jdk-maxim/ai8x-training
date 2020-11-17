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
echo "Running on OS: $(uname -a)"

if ! command -v python3
then
    echo "python3 is not installed, but is required..."
    exit 1
fi

if ! command -v pip3
then
    echo "pip3 is not installed, but is required..."
    exit 1
fi

do_a_test_expect_success "python3 -m pip install -U pip wheel setuptools" "Update python basics"
do_a_test_expect_success "python3 -m pip --version" "Show pip version"

echo "PWD $(pwd)"
echo "Changing to checkout directory..."
cd $GITHUB_WORKSPACE || exit 1
echo "PWD $(pwd)"
echo "Directory contents: $(ls)"

do_a_test_expect_success "pyenv local 3.6.9" "Set pyenv local vesion"
do_a_test_expect_success "python3 -m venv ." "Set pythong to use venv"
do_a_test_expect_success "bin/activate"        "bin/activate"
do_a_test_expect_success "python3 -m pip install -r requirements.txt" "Install requirements.txt"
