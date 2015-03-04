# RegressionTester
A simple yet powerful bash script to run programmable regression tests on your program

## Details
The bash script</font> titled automated_tester.sh can be used to run different types of automated unit testing to speed up development. The script has constants around the top of the file which have to be manually programmed to produce the correct tests. Providing a more powerful configuration mechanism would be overkill and wouldn't acheive any useful purpose. There are 8 default constants that need to be configured

<br>`INPUT_FILES` : The names of your input test files need to go here. i.e. the files you will use as standard input to your program. For example in the repository there are test files called `test_for_regressor$x.txt`</FONT> which serve as input to the program testWithInput.cpp. <br>NOTE : The first line of these tests have to have the command line arguments that will be used to execute the program in this format "`// COMMAND LINE ARGUMENTS FOR TEST : `<the arguments here>"
`CORRECT_OUTPUT_FILES` : This will be the names of the output files that have matching suffixes when compared to the input files. For example the repository has `testOutputCorrect1.txt` and `testOutputCorrect2.txt` which are outputs of `test_for_regressor1.txt` and `test_for_regressor2.txt`
<br>`PROGRAM` : This contains the file with the main() function that needs to be compiled
<br>`EXTRA_DEPENDANCIES` : This contains extra files that need to be compiled as seperate modules. For example a project can be compiled as such `g++ file_with_main other_files` so here `other_files` will be the extra_dependancies.
<br>`COMPILER` : The compiler for the compilation.
<br>`COMPILE` : The highest command for compilation that sews together every dependancy
<br>`DEFAULT_DIFF` : The default program used to check if the output is correct by matching with correct output. For example an output file with the same number of each individual digit can be checked against the correct output and return no output if the digits match. REQUIREMENT FOR DIFF : The checking program needs to output nothing if there is a match between the output and the correct output and return the details of the mismatch if there is a mismatch

# How To Run
The script can be run after programming the script's behaviour by typing 
  `bash automated_tester.sh <--verbose or -v>` 
with or without the verbose command. With verbose the script will inform the user of the memory usage, the time taken and further details about the mismatch in the output produced by the program as compared to the actual correct output.
  
