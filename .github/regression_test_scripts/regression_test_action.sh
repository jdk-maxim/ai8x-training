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
    exit
fi

if ! command -v pip3
then
    echo "pip3 is not installed, but is required..."
    exit
fi

python3 --version
python3 -m pip --version

echo "Updating python basics..."
python3 -m pip install -U pip wheel setuptools

python3 pip3 --version

# FIXME: Should these be in requirements.txt ?
# FIXME: Shoudl not be needed? pip3 install Cython 
#pip3 install pylint
#pip3 install flake8

#pylint --version
#flake8 --version

echo "PWD $(pwd)"
echo "Changing to checkout directory..."
cd $GITHUB_WORKSPACE || exit
echo "PWD $(pwd)"
echo "Directory contents: $(ls)"

do_a_test_expect_success "python3 pip install -r requirements.txt" "Install requirements.txt"
