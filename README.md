# RegressionTester
A simple yet powerful bash script to run programmable regression tests on your program

## Details
The bash script titled automated_tester.sh can be used to run different types of automated unit testing to speed up development. The script has constants around the top of the file which have to be manually programmed to produce the correct tests. Providing a more powerful configuration mechanism would be overkill and wouldn't acheive any useful purpose. There are 8 default constants that need to be configured
<ul>
  <li><FONT FACE="courier">input_files</FONT> : The names of your input test files need to go here. i.e. the files you will use as standard input to your program. For example in the repository there are test files called <FONT FACE="courier">test_for_regressor$x.txt</FONT> which serve as input to the program testWithInput.cpp. <br>NOTE : The first line of these tests have to have the command line arguments that will be used to execute the program in this format "<FONT FACE="courier">// COMMAND LINE ARGUMENTS FOR TEST : <the arguments here></FONT>"</li>
  <li><FONT FACE="courier">correct_output_files</FONT> : This will be the names of the output files that have matching suffixes when compared to the input files. For example the repository has <FONT FACE="courier">testOutputCorrect1.txt</FONT> and <FONT FACE="courier">testOutputCorrect2.txt</FONT> which are outputs of <FONT FACE="courier">test_for_regressor1.txt</FONT> and <FONT FACE="courier">test_for_regressor2.txt</FONT></li>
  <li><FONT FACE="courier">program</FONT> : This contains the file with the main() function that needs to be compiled</li>
  <li><FONT FACE="courier">extra_dependancies</FONT> : This contains extra files that need to be compiled as seperate modules. For example a project can be compiled as such <FONT FACE="courier">g++ file_with_main other_files</FONT> so here other_files will be the extra_dependancies.</li>
  <li><FONT FACE="courier">COMPILER</FONT> : The compiler for the compilation.<li>
  <li><FONT FACE="courier">COMPILE</FONT> : The highest command for compilation that sews together every dependancy</li>
  <li><FONT FACE="courier">DEFAULT_DIFF</FONT> : The default program used to check if the output is correct by matching with correct output. For example an output file with the same number of each individual digit can be checked against the correct output and return no output if the digits match. REQUIREMENT FOR DIFF : The checking program needs to output nothing if there is a match between the output and the correct output and return the details of the mismatch if there is a mismatch</li>
</ul>

# How To Run
The script can be run after programming the script's behaviour by typing `bash automated_tester.sh <--verbose or -v>` with or without the verbose command. With verbose the script will inform the user of the memory usage, the time taken and further details about the mismatch in the output produced by the program as compared to the actual correct output.
  
