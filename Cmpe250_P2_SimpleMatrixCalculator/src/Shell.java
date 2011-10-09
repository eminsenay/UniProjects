
import java.util.ArrayList;
import java.util.Hashtable;

/**
 * Student ID: 2002103907
 * Project: Cmpe 250 Project #2 - Simple Matrix Calculator
 * Date: 29.Nis.2005
 * Time: 15:42:25
 * @author Emin Þenay
 */
public class Shell {
    /**
     * Construct a new Shell.
     */
    Shell() {
        // construct a new Hashtable
        variables = new Hashtable();
    }
    /**
     * Evaluate the given operations with the given matrices.
     *
     * @param tokenList Operators and Matrices (right handside).
     * @throws Exception When there is an error in the given input.
     * @return The resulting matrix.
     */
    Matrix evaluate (String [] tokenList) throws Exception
    {
        // initialize 2 ArrayLists which will be used to
        // store matrices and operators
        ArrayList matrixList = new ArrayList();
        ArrayList opList = new ArrayList();

       /* // initialize multiplicator which is used to store
        // the scalar multiplication
        double multiplicator = 1;*/

        // chack all tokens
        for (int i = 0; i < tokenList.length; i++)
        {
            if (tokenList[i].matches("[a-zA-Z_]+")) // if there is a variable name
            {
                // add the corresponding matrix to the matrixList
                Matrix M = (Matrix)variables.get(tokenList[i]);
                matrixList.add(M);
            }
            else if (tokenList[i].compareTo("(") == 0) // if there is a paranthesis
            {
                int [] rowAndCol = new int[2];

                // take the row and column values of tokens inside the paranthesis
                rowAndCol = paranthesis(tokenList[i+1],tokenList[i+3]);

                i=i+4; //we are passing tokens up to the )

                // setting the evaluated matrix to the matrixList
                matrixList.set(matrixList.size()-1,
                        eval((Matrix)matrixList.get(matrixList.size()-1),rowAndCol[0],rowAndCol[1]));
            }
            else if (tokenList[i].compareTo("'") == 0) // if there is a transpose operation
            {
                //taking the last element in the matrixList
                Matrix M = (Matrix)matrixList.get(matrixList.size()-1);
                Matrix tmp = new Matrix(M);

                // transposing the matrix
                tmp.transpose();

                //setting the transposed matrix in the place of the old matrix
                matrixList.set(matrixList.size()-1,tmp);
            }
            // if there are multiplication, addition, division or subtraction operators
            else if (tokenList[i].compareTo("+") == 0 || tokenList[i].compareTo("-") == 0 ||
                    tokenList[i].compareTo("*") == 0 || tokenList[i].compareTo("/") == 0)
            {
                // adding the operator to the opList
                opList.add(tokenList[i]);
            }

            //if there is a scalar multiplication
            else if (tokenList[i].matches("[0-9]+") || tokenList[i].matches("[0-9]+.[0-9]+")
            || tokenList[i].matches("-[0-9]+") || tokenList[i].matches("-[0-9]+.[0-9]+"))
            {
                matrixList.add(tokenList[i]);
            }

            // element cannot be different than these, if there is an element different than these,
            // that means user entered a wrong input
            else
                throw new Exception("Error");
        }// end of for

        // we have to evaluate the operations which are in the arraylist now
        return eval(matrixList,opList);
    }
    /**
     * Matrices created by the user are stored here.
     */
    Hashtable variables;
    /**
     * Give the integer values of the row and column given
     * in paranthesis. If there is a : in paranthesis,
     * corresponding value will be -1, else (value - 1) will
     * be returned because row and column numbers given in
     * shell are starting from 1 and in the Matrix class,
     * these are starting from 0
     *
     * @param row String representation of the row.
     * @param col String representation of the column.
     * @throws Exception When there is a wrong input in paranthesis.
     * @return int[] which contains row and column numbers, respectively.
     */

    int [] paranthesis (String row, String col) throws Exception
    {
        // initialize a new integer array
        int []rowAndCol = new int[2];

        // control if given inputs are really numbers or ":"
        if (!row.matches("[0-9:]") || !col.matches("[0-9:]"))
            throw new Exception("Wrong input in paranthesis");

        // : means "all", in this case -1 is set
        // else, (value - 1) is set because user starts to count from 1
        // but program starts to count from 0 in row and column numbers
        if (row.compareTo(":") == 0)
            rowAndCol[0] = -1;
        else
            rowAndCol[0] = Integer.parseInt(row) - 1;
        if (col.compareTo(":") == 0)
            rowAndCol[1] = -1;
        else
            rowAndCol[1] = Integer.parseInt(col) - 1;
        return rowAndCol;
    }
    /**
     * Give the requested matrix with row and col values.
     * If row is -1, column col; else if col is -1 row row
     * is returned. Else, a matrix which contains the
     * element in the row and col numbers of the original
     * matrix is returned.
     *
     * @param M Original matrix.
     * @param row Requested row number.
     * @param col Requested column number.
     * @throws Exception When there is an error in the row
     * or column values.
     * @return The resulting matrix.
     */
    Matrix eval (Matrix M, int row, int col) throws Exception
    {
        // setting the control variable
        boolean inputCheck = true;

        // initializig a new matrix
        Matrix N = new Matrix();

        // getting correct matrices by inspecting row and
        // column numbers
        if (row == -1)
            inputCheck = M.getCol(col,N);
        else if (col == -1)
            inputCheck = M.getRow(row,N);
        else
        {
            MyDouble value = new MyDouble(0);
            inputCheck = M.getElem(row,col,value);
            N = new Matrix(1,1,value.todouble());
        }

        // if row or col are bigger than the number of
        // row or column of matrix, false is returned
        if (inputCheck == false)
            throw new Exception("Wrong input in row or column values");
        return N;
    }
     /**
     * Evaluate the given operations with given matrices.
     * Operations cannot be ' or ( . This function is used
     * by evaluate function.
     *
     * @param varList List which contains the matrices and scalar values.
     * @param opList List which contains operations.
     * @throws Exception When there is an error
     * (mostly dimensions of matrices do not match).
     * @return The resulting matrix.
     */
    Matrix eval (ArrayList varList, ArrayList opList) throws Exception
    {
         // while there exists more than one element in the varlist
         // last element eill be returned
        while (varList.size() > 1)
        {
            // elements in varlist can be Matrices or double values
            // taking the correct one
            String ScalarCheck1 = new String();
            String ScalarCheck2 = new String();
            Matrix firstMat = new Matrix();
            Matrix secondMat = new Matrix();
            try {
                ScalarCheck1 = (String)varList.get(0);
            } catch (ClassCastException e) {
                firstMat = (Matrix)varList.get(0);
            }
            try {
                ScalarCheck2 = (String)varList.get(1);
            } catch (ClassCastException e) {
                secondMat = (Matrix)varList.get(1);
            }

            // removing the taken elements from varList
            varList.remove(0);
            varList.remove(0);

            //taking the operator and removing it from the opList
            String oper = (String)opList.get(0);
            opList.remove(0);

            // we took the elements correctly; now, determining the operation

            // if both of the elements are scalars
            if (ScalarCheck1.length() != 0 && ScalarCheck2.length() != 0)
            {
                // taking double values
                double val1 = Double.parseDouble(ScalarCheck1);
                double val2 = Double.parseDouble(ScalarCheck2);

                // doing the operation
                double result = operation(val1,val2,oper);
                Double Res = new Double(result);

                //adding it again to the varList
                varList.add(0,Res.toString());
            }

            // if only first element is scalar
            else if (ScalarCheck1.length() != 0)
            {
                // creating the matrix to be multiplied
                Matrix M = new Matrix(secondMat);

                // Scalars can only be multiplied with matrices, input check
                if (oper.compareTo("*") != 0)
                    throw new Exception("Scalars can only be multiplied with matrices");

                // do the multiplication and add the result to the varList
                M.times(Double.parseDouble(ScalarCheck1));
                varList.add(0,M);
            }
            // if only second element is scalar
            else if (ScalarCheck2.length() != 0)
            {
                // creating the matrix to be multiplied
                Matrix M = new Matrix(firstMat);

                // Scalars can only be multiplied with matrices, input check
                if (oper.compareTo("*") != 0)
                    throw new Exception("Scalars can only be multiplied with matrices");

                // do the multiplication and add the result to the varList
                M.times(Double.parseDouble(ScalarCheck2));
                varList.add(0,M);
            }

            // if both elements are matrices
            else
            {
                // creating the matrix to have the operations and doing the operation
                Matrix tmp = new Matrix();
                tmp = operation(firstMat,secondMat,oper);

                //adding the resulting matrix to the varList
                varList.add(0,tmp);
            }
        }

        // last element can be a scalar or a matrix
        // if it is scalar, we need to create a new 1 to 1 matrix
        // and send scalar value in it because of the implementation        
        String tmp = new String();
        try {
            tmp = (String)varList.get(0);
            Matrix M = new Matrix(1,1,Double.parseDouble(tmp));
            return M;
        } catch(ClassCastException e) {
            Matrix M = (Matrix)varList.get(0);
            return M;
        }
    }

    /**
     * Take the input line by line, parse and return
     * the parsed input.
     *
     * @return The parsed input.
     */
    String [] takeInput ()
    {
        // get the line
        String line = TextIO.getln();

        // split the line by finding the " ".
        String [] result = line.split("\\s"); //we split the string according to blanks
        return result;
    }
    /**
     * Take the input, check which input is entered and call
     * appropriate methods to handle all kinds of inputs. Stops
     *  working when user enters "exit" command.
     */
    void control ()
    {
        do {
            // printing >
            TextIO.put(">");

            // taking  and parsing the input
            String [] inputStr = takeInput();

            // initializing check variable to control input check
             boolean check = true;

            // initializig equalindex which will store the index of the "=" (if it exists)
            int equalIndex;

            // determining the given input
            if (inputStr[0].compareTo("save") == 0 && inputStr[1].compareTo("(") == 0) // which means save
                try {
                    save(inputStr[2],inputStr[4]);
                } catch (Exception e) {
                    TextIO.putln(e.toString());
                    continue;
                }
            else if (inputStr[0].toLowerCase().compareTo("exit") == 0) // user want to quit the program
                break;
            else  // which means first token is a variable name
            {
                // we will search the "=" in the inputStr now
                // if = cannot be found, this means user wants to print sth
                // else user wants to do operations on matices
                boolean found = false;
                for (equalIndex = 0; equalIndex < inputStr.length ; equalIndex++)
                    if (inputStr[equalIndex].compareTo("=") == 0)
                    {
                        found = true;
                        break;
                    }
                if (!found) // user wants to print sth
                {
                    // checking if the user wants to print the entire matrix
                    // or specific elements of it
                    if (inputStr.length == 1) // print the entire matrix (no "(" exists)
                        try {
                            print (inputStr[0],-1,-1);
                        } catch (Exception e) {
                            TextIO.putln(e.toString());
                            continue;
                        }
                    else // user wants to print specific elements (row or column or one element only)
                    {
                        // finding which elements does the user want to print
                        // finding the row and column given in paranthesis
                        int [] rowAndCol = new int[2];
                        try {
                            rowAndCol = paranthesis(inputStr[2],inputStr[4]);
                        } catch (Exception e) {
                            TextIO.putln(e.toString());
                            continue;
                        }
                        // printing the given element
                        try {
                            print(inputStr[0],rowAndCol[0],rowAndCol[1]);
                        } catch (Exception e) {
                            TextIO.putln(e.toString());
                            continue;
                        }
                    }
                }
                else    // user wants to do operations on matrices
                {
                    // checking if the given matrix name obeys
                    // the rules (can contain letters and _)
                    if (!inputStr[0].matches("[A-Za-z_]+"))
                    {
                        TextIO.putln("Matrix name cannot be " + inputStr[0]);
                        continue;
                    }
                    // first finding the matrix in left hand side
                    Matrix lhs = new Matrix();

                    // initializing newMatrix variable to check whether the entered
                    // matrix already exists or it is the first time
                    boolean newMatrix = true;

                    // initializing rowcol variable to store the row
                    // and column number of left handside
                    int [] lhsRowCol = new int[]{-1, -1};
                    if (variables.containsKey(inputStr[0])) // the matrix exists in hashtable,
                    //  which means it is initialized before
                    {
                        lhs = (Matrix)variables.get(inputStr[0]);
                        newMatrix = false;
                        //variables.remove(inputStr[0]);
                    }

                    // checking if a paranthesis exists
                    if (equalIndex > 1)
                    {
                        try {
                            lhsRowCol = paranthesis(inputStr[2],inputStr[4]);
                        } catch (Exception e) {
                            TextIO.putln(e.toString());
                            continue;
                        }

                        // There shouldn't be a paranthesis in a new entered
                        // matrix (which is not in the hashtable)
                        // All elements of the matrix should be initialized first
                        if (newMatrix && (lhsRowCol[0] != -1 || lhsRowCol[1] != -1))
                        {
                            TextIO.putln("All elements of the new matrix should be initialized first");
                            continue;
                        }
                    }
                    // now, finding the entered operation
                    if (inputStr[equalIndex+1].compareTo("load") == 0) // user wants to load the matrix
                    {
                        check = lhs.load(inputStr[equalIndex+3]);
                        variables.put(inputStr[0],lhs);
                    }

                    // user wants to create a matrix with random numbers
                    else if (inputStr[equalIndex+1].compareTo("random") == 0)
                    {
                        // initializing a new matrix with random numbers
                        try {
                            lhs = randomize(inputStr[equalIndex+3],inputStr[equalIndex+5],
                                    inputStr[equalIndex+7],inputStr[equalIndex+9],inputStr[equalIndex+11]);
                        } catch (Exception e) {
                            TextIO.putln(e.toString());
                            continue;
                        }
                        variables.put(inputStr[0],lhs);
                    }

                    // user wants to create an identity matrix
                    else if (inputStr[equalIndex+1].compareTo("identity") == 0)
                    {
                        // initializing a new identity matrix
                        try {
                            lhs = identity(inputStr[equalIndex+3]);
                        } catch (Exception e) {
                            TextIO.putln(e.toString());
                            continue;
                        }
                        variables.put(inputStr[0],lhs);
                    }

                    // user wants to initialize a new matrix with a fixed number
                    else if (inputStr[equalIndex+1].compareTo("matrix") == 0)
                    {
                        // initializing a new matrix with a fixed number
                        try {
                            lhs = construct(inputStr[equalIndex+3],inputStr[equalIndex+5],inputStr[equalIndex+7]);
                        } catch (Exception e) {
                            TextIO.putln(e.toString());
                            continue;
                        }
                        variables.put(inputStr[0],lhs);
                    }

                    // user wants to initialize a new matrix by entering all elements
                    else if (inputStr[equalIndex+1].compareTo("/") == 0)
                    {
                        // initializing a new matrix element by element
                        Matrix result = new Matrix();
                        try{
                            result = initialize();
                        } catch (Exception e) {
                            TextIO.putln(e.toString());
                            continue;
                        }

                        // we need to check if an element or a row or a column
                        // or a new matrix is being initialized
                        if (lhsRowCol[0] == -1 && lhsRowCol[1] == -1)
                            variables.put(inputStr[0],result);
                        else if (lhsRowCol[0] == -1) // column is being initialized
                        {
                            if (!lhs.setCol(lhsRowCol[1],result))
                            {
                                TextIO.putln("Column size must match");
                                variables.put(inputStr[0],lhs);
                                continue;
                            }
                            variables.put(inputStr[0],lhs);
                        }
                        else if (lhsRowCol[1] == -1) // row is being initialized
                        {
                            if (!lhs.setRow(lhsRowCol[0],result))
                            {
                                TextIO.putln("Row size must match");
                                variables.put(inputStr[0],lhs);
                                continue;
                            }
                            variables.put(inputStr[0],lhs);
                        }
                        else //only one element is being initialized
                        {
                            MyDouble val = new MyDouble(0);
                            result.getElem(0,0,val);
                            if(!lhs.setElem(lhsRowCol[0],lhsRowCol[1],val.todouble()))
                            {
                                TextIO.putln("Given coordinate does not exist in matrix");
                                variables.put(inputStr[0],lhs);
                                continue;
                            }
                            variables.put(inputStr[0],lhs);
                        }
                    }
                    else // other operations such as * + ...
                    {
                        // initializing the right handside
                        String[] rhs = new String[inputStr.length-equalIndex-1];
                        for (int i = 1; i <= rhs.length ; i++)
                            rhs[i-1] = inputStr[equalIndex+i];
                        // getting the result
                        try {
                            lhs = set(lhs,lhsRowCol,rhs);
                        } catch (Exception e) {
                            TextIO.putln(e.toString());
                            continue;
                        }
                        variables.put(inputStr[0],lhs);
                    }
                }
                if (check == false)
                {
                    TextIO.putln("Error");
                    continue;
                }
            }
        }while (true);

    }
    /**
     * Save the given matrix to a file fileName.
     *
     * @param varName Name of the matrix.
     * @param fileName Name of the file.
     * @throws Exception When operation is unsuccessful.
     */
    void save (String varName, String fileName) throws Exception
    {
        // setting the control variable
        boolean successful;

        // construct a new Matrix
        Matrix M = new Matrix();

        // control if HashTable contains the given Matrix
        // specified by varName
        if (variables.containsKey(varName))
        {
            M = (Matrix)variables.get(varName);

            // Save the Matrix to the given fileName
            successful  = M.save(fileName);
            if (!successful)
                throw new Exception("Save is not successful");
        }
        else
        {
            throw new Exception("Variable name should be initialized before");
        }
    }
    /**
     * Print the given matrix. If both of row and col is -1,
     * print the entire matrix, else if one of them is -1,
     * print the given row or col, else print the element.
     *
     * @param varName Name of the matrix.
     * @param row Row number.
     * @param col Column number.
     * @throws Exception When given input contains errors.
     */
    void print (String varName, int row, int col) throws Exception

    {
        // constructing needed matrices
        Matrix M = new Matrix();
        Matrix N = new Matrix();

        // checking if the given matrix exists in the Hashtable
        if (!variables.containsKey(varName))
            throw new Exception("Variable " + varName + " is not initialized before");

        // getting the Matrix
        M = (Matrix)variables.get(varName);

        // controlling the row and col numbers
        if (row >= M.getNoRows() || col >= M.getNoCols())
            throw new Exception("given row or column number is bigger than" +
                    " the row or column value of the matrix " + varName);

        // setting the matrix to be printed
        if (row == -1 && col == -1)
            N = new Matrix(M);
        else if (row == -1)
            M.getCol(col,N);
        else if (col == -1)
            M.getRow(row,N);
        else
        {
            MyDouble d = new MyDouble(0);
            M.getElem(row,col,d);
            N = new Matrix(1,d.todouble());
        }

        //printing the first line
        if (row == -1 && col == -1)
            TextIO.putln(varName + " = " + " / ");
        else if (row == -1)
            TextIO.putln(varName + " (:," + (col+1) + ")" + " = " + " / ");
        else if (col == -1)
            TextIO.putln(varName + " (" + (row+1) + ",:)" + " = " + " / ");

        // printing the elements
        for (int rowNo = 0; rowNo < N.getNoRows() ; rowNo++)
        {
            for (int colNo = 0; colNo < N.getNoCols(); colNo++)
            {
                MyDouble value = new MyDouble(0);
                N.getElem(rowNo,colNo,value);
                double result = value.round(2);
                TextIO.put(result + " ");
            }
                TextIO.putln();
        }
        // printing the last line
        TextIO.putln("/");
    }
    /**
     * Initialize the given matrix element by element.
     *
     * @return The resulting matrix.
     * @throws Exception When columns entered false.
     */
    Matrix initialize() throws Exception
    {
        // initializing a new ArrayList which will
        // hold the elements of the matrix
        ArrayList elementList = new ArrayList();
        int row = -1, oldLength = 0;
        while (true)
        {
            row++;

            // taking input from the screen
            String[] inputStr = takeInput();

            // if end of the initialization has come
            if (inputStr[0].compareTo("/") == 0)
                break;

            // checking size of old and new entered columns
            if (oldLength != 0 && inputStr.length != oldLength)
                throw new Exception("Column number of a matrix must remain constant");

            // initializing a new double array which will hold
            // the double values of the matrix elements
            Double [] inputs = new Double[inputStr.length];

            // taking the double values
            inputs = toDoubleArray(inputStr);

            // adding the elements of the column to the arraylist
            for (int i = 0; i < inputs.length; i++)
                elementList.add(inputs[i]);
            oldLength = inputs.length;
        }

        // creating a new matrix from taken row and column numbers
        Matrix M = new Matrix(row,oldLength);
        int counter = 0;

        // setting all elements of the matrix
        for (int rowno = 0; rowno < row; rowno++)
            for (int i = 0; i < oldLength; i++)
            {
                Double value = (Double)elementList.get(counter++);
                M.setElem(rowno,i,value.doubleValue());
            }
        return M;
    }
    /**
     * Create a new matrix which contains random floating points.
     *
     * @param row Row number of the matrix.
     * @param col Column number of the matrix.
     * @param minVal Minimum random value.
     * @param maxVal Maximum random value.
     * @param integerFlag If true, elements of the matrix will be integers.
     * @throws Exception When taken String inputs are not integers or doubles.
     * @return The resulting matrix.
     */
    Matrix randomize (String row, String col, String minVal, String maxVal, String integerFlag) throws Exception
    {
        // parse the given Strings row, col, minVal and maxVal
        int rowNum = Integer.parseInt(row);
        int colNum = Integer.parseInt(col);
        double min = Double.parseDouble(minVal);
        double max = Double.parseDouble(maxVal);

        // initialize the integer flag variable
        boolean intFlag = false;
        if (integerFlag.compareTo("true") == 0)
            intFlag = true;

        // create a new matrix
        Matrix M = new Matrix(rowNum,colNum);

        // randomize the elements of the matrix
        M.makeRandom(min,max,intFlag);
        return M;
    }
    /**
     * Create a new identity matrix.
     *
     * @param num Row and column number of the matrix.
     * @throws Exception When given string is not an integer.
     * @return The resulting matrix.
     */
    Matrix identity (String num) throws Exception
    {
        // parse the given String number
        int number = Integer.parseInt(num);

        // create a new square matrix
        Matrix M = new Matrix(number,0.0);

        // make the matrix an identity matrix
        M.makeIdentity();
        return M;
    }
    /**
     * Create a new matrix. All elements are
     * initialized to a given double.
     *
     * @param row Row number of the matrix.
     * @param col Column number of the matrix.
     * @param val String representation of the double value.
     * @throws Exception When the string inputs are not integers or double.
     * @return The resulting matrix.
     */
    Matrix construct (String row, String col, String val) throws Exception
    {
        // take the integer representations of row and column
        int rowNo = Integer.parseInt(row);
        int colNo = Integer.parseInt(col);

        // take the double representation of value
        double value = Double.parseDouble(val);
        Matrix M = new Matrix(rowNo,colNo,value);
        return M;
    }
    /**
     * Construct a new matrix or change the given vector
     * or element of a matrix.
     *
     * @param M Initial matrix
     * @param rowAndCol Row and column number to be changed.
     * If both of them are -1, a new matrix will be constructed.
     * Else if row is -1, a column vector is set to the given
     * column number of matrix. Else if column is -1, a row vector
     * is set to the given row number of the matrix. Else, a double
     * value is set to the given row and column number of the matrix.
     * @param rhs The matrix which will be evaluated and set to the
     * correct place of the given matrix.
     * @return Created or changed matrix.
     * @throws Exception When there is a dimension mismatch.
     */
    Matrix set (Matrix M, int[] rowAndCol, String [] rhs) throws Exception
    {
        // initializing control variable
        boolean check = true;

        // creating a new matrix and setting it to the given matrix
        Matrix result = new Matrix();
        if (M.matrixArray != null)
            result = new Matrix(M);

        if (rowAndCol[0] == -1 && rowAndCol[1] == -1) // matrix will completely be assigned
            result = new Matrix(evaluate(rhs));

        else if (rowAndCol[0] == -1) //one column will be assigned
            check = result.setCol(rowAndCol[1],evaluate(rhs));

        else if (rowAndCol[1] == -1) //one row will be assigned
            check = result.setRow(rowAndCol[0],evaluate(rhs));

        else // one element will be assigned
        {
            Matrix res = evaluate(rhs);

            // dimension check
            if (res.getNoCols() != 1 || res.getNoRows() != 1)
                throw new Exception("Row and column numbers of rhs must be 1");
            MyDouble value = new MyDouble(0);
            res.getElem(0,0,value);
            result.setElem(rowAndCol[0],rowAndCol[1],value.todouble());
        }
        if (!check)
            throw new Exception("Row and column numbers must match");
        return result;
    }
    /**
     * Parse the given string array to double array.
     *
     * @param inputStr The string array to be parsed.
     * @return Double array created from the string array.
     * @throws Exception If string array contains values
     * different than double.
     */
    Double [] toDoubleArray (String[] inputStr) throws Exception
    {
        // creating a new double array to take the values
        Double[] doubleArray = new Double[inputStr.length];

        // parsing strings to doubles
        for (int i = 0; i < inputStr.length; i++)
            try {
                doubleArray[i] = new Double(Double.parseDouble(inputStr[i]));
            } catch(NumberFormatException e) {
                throw e;
            }
        return doubleArray;
    }
    /**
     * Takes two matrices and returns the result of the given operation.
     * @param first First Matrix.
     * @param second Second Matrix.
     * @param oper Operation ( *, - or + ).
     * @return The resulting Matrix.
     * @throws Exception When the operation cannot be done
     * (mostly because of the dimension mismatch).
     */
    Matrix operation ( Matrix first, Matrix second, String oper) throws Exception
    {
        Matrix tmp = new Matrix(first);
        boolean inputcheck = true;
        // determining the correct operation and
        // doing that operation
        if (oper.compareTo("*") == 0)
            inputcheck = tmp.times(second);
        else if (oper.compareTo("+") == 0)
            inputcheck = tmp.plus(second);
        else if (oper.compareTo("-") == 0)
            inputcheck = tmp.minus(second);

        if (inputcheck == false)
                 throw new Exception("Error in matrix operation");

        return tmp;
    }
    /**
     * Takes two doubles and returns the result of the given operation.
     * @param first First double.
     * @param second Second double.
     * @param oper Operation to be done.
     * @return The result.
     * @throws Exception When operation is different than *, + or -.
     */
    double operation (double first, double second, String oper) throws Exception
    {
        // determining the correct operation and
        // doing that operation
        if (oper.compareTo("*") == 0)
            return first * second;
        else if (oper.compareTo("+") == 0)
            return first + second;
        else if (oper.compareTo("-") == 0)
            return first - second;
        else if (oper.compareTo("/") == 0)
            return first / second;
        else
            throw new Exception("Wrong operation");
    }

}
