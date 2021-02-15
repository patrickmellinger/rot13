#!/bin/bash
# A simple utility for manipulating strings with the ROT13 substitution cipher
# Written by Patrick Mellinger, mellingerpat@gmail.com
# https://github.com/patrickmellinger/rot13
# set unoffical bash strict mode
set -euo pipefail

# set global variables
readonly SCRIPTNAME=$(basename $0 )
readonly PARAM1=${1:-}
readonly PARAM2=${2:-}

# where the actual encryption happens
# for more information about ROT13: https://en.wikipedia.org/wiki/ROT13
function transmute {
	local input_text=${1:-}
	local output_text=$(echo "${input_text}" | tr 'a-zA-Z' 'n-za-mN-ZA-M' )
	echo ${output_text}
}

# does two things:
# first, it handles input from STDIN via the pipe
# second, if no parameters are given it will prompt the user to enter text
function keyboard {
	read input_line
        local output=$(transmute ${input_line} )
        echo "${output}"
}

# handles file inputs
function eff {
	local input_file=${1:-}
	while read line
        do
		local output=$(transmute "${line}" )
                echo ${output}
        done < ${input_file}
}

# handles inline input
function eye {
	local input=${1:-}
	local output=$(transmute ${input} )
	echo "${output}"
}

# handles help and usage 
function aytch {
	cat <<-Transmission_terminated
	
	usage: ${SCRIPTNAME} options
	
	    This script will rotate your text 13 characters to the right. It was written for English, but might work for other languages as well. 

	    It does not rotate digits or special characters. A-Z, upper and lower case.
	
	    This method of encryption is known as ROT13. It as a variant of the Caesar Cipher.
	
	    It takes input from STDIN, as a parameter (-i), a file (-f), or from a prompt (no options). Options cannot be combined.

	OPTIONS:
	    -i --inline	    This option is for encrypting text as a parameter. Immediately after the -i or --inline needs to be your quoted text. Prints to STDOUT.
	    -f --file	    For encrypting the entire contents of a file. Immediately after -f or --file you need to specify a file name. Prints to STDOUT.
	    -h --help	    Use this option to print this help message. 
	    -t --tests      This options is for running unit tests. Immediately after -t or --tests you need to specify the path to shunit2. For more information about shunit2: https://github.com/kward/shunit2
	    NO OPTIONS	    If you run this script without any options, it prompts you to enter text unless text is supplied via STDIN.
		
	EXAMPLES:
	    Encrypting from STDIN:
	    echo 'dogs are good' | ./${SCRIPTNAME}
	
	    Encrypting text as a parameter:
	    ./${SCRIPTNAME} -i "we don't deserve dogs"
		
	    Encrypting from a prompt:
	    ./${SCRIPTNAME} 
	    type in your input on the next line, then hit enter
		
	    Asking for help:
	    ./${SCRIPTNAME} -h
		
	    Encrypting a file:
	    ./${SCRIPTNAME} -f filename

	    FOR MORE INFORMATION: https://github.com/patrickmellinger/rot13

Transmission_terminated
}

# for when the parameters are wrong
function error {
	>&2 echo "parameters incorrect. please refer to the instructions for help: ./${SCRIPTNAME} --help"
        exit 1
}

# function to kick off shunit2 tests
# shunit2 fails if anything is passed to this function
# so, instead of using $1 to keep the case statement uniform, $PARAM2 is referenced directly
function run_tests {
	source ${PARAM2} 
}

# generates 15 random A-Z and a-z characters to use in testing
function generate_gibberish {
	local output=$(cat /dev/urandom | tr -dc \"[:alpha:]\" | head -c 15 )
	echo ${output} 
}

# for setting up the testing environment
# shunit2 requires this function name
function oneTimeSetUp() {
	touch test_file.txt
	for line in {1..5}
	do
		local line_output=$(generate_gibberish )
		echo "${line} ${line_output}" >> test_file.txt
	done
}

# for cleaning up the test environment
# shunit2 requires this function name
function oneTimeTearDown() {
	rm test_file.txt
	rm testing_file.txt
	rm one_way.txt
	rm back_again.txt
}

# for testing whether or not the encryption is working properly
# ROT13 goes back to normal if you re-encrypt what's already encrypted
function test_transmute() {
	local -r test_string=$(generate_gibberish )
	local one_way=$(transmute "${test_string}" )
	local back_again=$(transmute "${one_way}" )
	local -r tested_string="${back_again}"
	assertEquals "raw strings don't match" "${test_string}" "${tested_string}"
}

# for testing if the eff function is working
function test_file() {
	cp test_file.txt testing_file.txt
	eff testing_file.txt > one_way.txt
	eff one_way.txt > back_again.txt
	local testing_text=$(cat test_file.txt )
	local back_again_text=$(cat back_again.txt )
	assertEquals "files don't match" "${testing_text}" "${back_again_text}"
}

# for testing if the eye function is working
function test_inline() {
	local -r test_string=$(generate_gibberish )
	local one_way=$(eye ${test_string} )
	local back_again=$(eye ${one_way} )
	assertEquals "inline strings don't match" "${test_string}" "${back_again}"
}

# for testing input from stdin via the keyboard function
# testing the keyboard prompt remains untested, even though it executes the same code this test is testing
function test_stdin() {
	local -r test_string=$(generate_gibberish )
	local one_way=$(echo ${test_string} | ./${SCRIPTNAME} )
	local back_again=$(echo ${one_way} | ./${SCRIPTNAME} )
	assertEquals "stdin strings don't match" "${test_string}" "${back_again}"
}

function main {
	case ${PARAM1} in
		"")		keyboard
				;;
		-f)		eff ${PARAM2}
				;;
		--file)		eff ${PARAM2}
				;;
		-i)		eye ${PARAM2}
				;;
		--inline)	eye ${PARAM2}
				;;
		-h) 		aytch
				;;
		--help) 	aytch
				;;
		-t)		run_tests 
				;;
		--tests)	run_tests 
				;;
		*) 		error
				;;
	esac	
}

main
