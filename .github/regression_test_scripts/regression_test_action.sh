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

echo "Starting push actions"
echo "Running on OS: $(uname -a)"
command -v python3
python3 --version
pip3 --version

# FIXME: Should these be in requirements.txt ?
# FIXME: Shoudl not be needed? pip3 install Cython 
#pip3 install pylint
#pip3 install flake8

#pylint --version
#flake8 --version

echo "PWD $(pwd)"
echo "Changing to checkout directory..."
cd $GITHUB_WORKSPACE
echo "PWD $(pwd)"
echo "Directory contents: $(ls)"

do_a_test_expect_success "pip3 install -r requirements.txt" "Install requirements.txt"
