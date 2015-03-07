# Developed by Aaryaman Sagar
# Email at rmn100@gmail.com
#
# SOME INFORMATION ABOUT SCRIPT
# enter the following command to run the script 
#     bash automated_test.sh                 -> to run without diff output
#     bash automated_test.sh --verbose / -v  -> to run with output printed   
#
# put the command line arguments you want to be passed to the program as the first
# line of the test starting with a "//"
# // COMMAND LINE ARGUMENTS FOR TEST : <arguments> 
# ^ please put spaces and not tabs
#
# WARNING : DO NOT NAME TEST FILES WITH TWO LEADING UNDERSCORES, THEY ARE RESERVED
#           IN THIS SCRIPT FOR ERRONEOUS OUTPUTS
#




# ********************************* CONSTANTS ********************************
# The name for the file with input and correct output
INPUT_FILES="test_for_regressor"
CORRECT_OUTPUT_FILES="testOutputCorrect"

# The name of the program to test
PROGRAM="testWithInput.cpp"

# Add any extra files that need to be compiled to run the program here
EXTRA_DEPENDANCIES=""

# The compiler to use 
COMPILER="g++"

# The flags for the compiler
FLAGS="-std=c++11 -O3 -pedantic -Wall -Werror -Wvla"

# The command used to compile the code, change to compile with custom
# compilation command
COMPILE="$COMPILER $FLAGS $PROGRAM $EXTRA_DEPENDANCIES"

# The standard program used to match against a correct output file and 
# output nothing if the output of the program correctly matches and output
# something if it doesn't. The output of this utility is mirrored when 
# the script is run in verbose mode
DEFAULT_DIFF=diff
# ******************************** CONSTANTS *********************************




# Check for properly formatted command line args, $# is the number of arguments
arg=$1     # Store argument into a variable
if [[ ($arg != "-v" && $arg != "--verbose" && !(-z $arg)) || ($# > 1) ]]; then
    echo -e "Usage : bash automated_test <-v or --verbose or empty>"
    exit
fi




# Write code for compiling the priority queue files here, like below
# exit after outputting that the program didnt compile, redirect stdout
# with usual > filename and stderr with 2> filename
echo -e "Compiling code ......"
echo -e "$COMPILE\n"
$COMPILE -o testExecutable 2> compilation_result
result_of_compile="$(cat compilation_result)"

# remove the extra compiler results file created
rm compilation_result

if [[ !(-z $result_of_compile) ]]; then
    echo -e The program failed to compile ":(((\n"
    if [[ ($arg="-v" || $arg="--verbose") && !(-z $arg) ]]; then
        red='\033[0;31m'    # THE RED COLOR
        no_color='\033[0m'  # NO COLOR
        echo -e "${red}${result_of_compile}${no_color}\n"
    fi

    # :((
    exit
fi




function process_results () {
# REQUIRES : One argument containing the output of the diff
# EFFECTS : Prints out verbose details if the verbose flag is provided
    local local_diff_output=$1
    local local_time_information=$2
    local LOCAL_COUNTER=$3

    # process results here
    if [[ ($arg="-v" || $arg="--verbose") && !(-z $arg) ]]; then
        if [[ !(-z $local_diff_output) ]]; then
            echo -e "\n${local_diff_output}"    # the diff output
        fi
        echo -e "\n"$local_time_information     # the time output


        # if verbose then put results into folder before deleting
        mkdir -p program_test_output   # make folder only if not made

        # put in folder
        cp testOutput  "./program_test_output/__test$LOCAL_COUNTER""_stdout.txt"
        cp errorOutput "./program_test_output/__test$LOCAL_COUNTER""_stderr.txt"
    fi

}



# i has the names of programs that start with $INPUT_FILES and end
# with whatever after that
COUNTER=1
for test_file in $( ls $INPUT_FILES*.txt ); do
    echo -e "------------- TEST $COUNTER --------------"
    echo -e "Executing test : " $test_file


    # Get command line arguments for test from file
    command_line_arguments_for_program="$(head -1 $test_file | cut -d ' ' -f 8-)"
    # The command to run the executable
    command_to_run_executable="./testExecutable $command_line_arguments_for_program"
    # The command to get input from the test file
    get_input_from_test="tail -n +2 $test_file"


    # Write code to write output to file, stderr not considered here
    # so it will go to the console when running this script, here
    # the first line of the test file is skipped as following the format
    # for this testing machine, they will contain the command line arguments
    # that will be used to run the program. As such the result is piped
    # into the executable as input
    (time $get_input_from_test | $command_to_run_executable > testOutput 2> errorOutput) 2> time.txt


    # store the time information in a variable and remove the time file
    time_information="User time taken : ""$(sed -n 2p time.txt | cut -f 2-2)"
    rm time.txt


    # Diff the output and store the output of diff into a variable
    diff_output="$($DEFAULT_DIFF -w testOutput "$CORRECT_OUTPUT_FILES""$COUNTER".txt)"



    # Now print results
    if [[ -z $diff_output ]]; then   # if outout_stored is empty then pass
        echo -e TEST PASSED ":D"
    else
        echo -e TEST FAILED ":("
    fi


    # call a function to print results
    process_results "${diff_output}" "${time_information}" $COUNTER



    # increment counter
    let COUNTER=COUNTER+1
    echo -e #"-----------------------------------------------\n"

done

# Cleanup by removing files 
rm testOutput
rm testExecutable
rm errorOutput

