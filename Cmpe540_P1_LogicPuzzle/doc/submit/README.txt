.class files are given with the .java files. So, there is no need to compile the java files again.

If files wanted to be compiled:
1- Make sure that java sdk is in the PATH. 
2- Open a command line (or console) and enter the directory of this README file.
3- Type  

javac com\eminsenay\cmpe540\p1\Constraint.java com\eminsenay\cmpe540\p1\CSPModel.java com\eminsenay\cmpe540\p1\GeneticAlgorithmSolver.java com\eminsenay\cmpe540\p1\ProblemGeneticAlgorithm.java 

for only compiling genetic algorithm solver and

javac com\eminsenay\cmpe540\p1\Constraint.java com\eminsenay\cmpe540\p1\CSPModel.java com\eminsenay\cmpe540\p1\MinConflictsSolver.java com\eminsenay\cmpe540\p1\ProblemMinConflicts.java

for only compiling minimum conflicts solver and 

javac com\eminsenay\cmpe540\p1\Constraint.java com\eminsenay\cmpe540\p1\CSPModel.java com\eminsenay\cmpe540\p1\GeneticAlgorithmSolver.java com\eminsenay\cmpe540\p1\MinConflictsSolver.java com\eminsenay\cmpe540\p1\ProblemGeneticAlgorithm.java com\eminsenay\cmpe540\p1\ProblemMinConflicts.java

for both at the same time.

To run the software:

1- Open a command line (or console) and enter the directory of this README file.
2- Type

java com.eminsenay.cmpe540.p1.ProblemGeneticAlgorithm

for executing genetic algorithm solver and

java com.eminsenay.cmpe540.p1.ProblemMinConflicts

for executing minimum conflicts solver

Note: For windows, RUNME_BOTH.bat, RUNME_GENETIC_ALG.bat and RUNME_MIN_CONFLICTS.bat files are supplied. 
These files compile and run the part/parts of the software. To run these:

1- Open a command line (or console) and enter the directory of this README file.
2- Type
RUNME_GENETIC_ALG.bat 
or
RUNME_MIN_CONFLICTS.bat
or
RUNME_BOTH.bat

Note2: Some output files are given in the Example Outputs directory. Both problems randomly initializes a
start state, so no input is required.

