
import java.util.Random;
import java.io.*;

/**
 * Student ID: 2002103907
 * Project: Cmpe 250 Project #2 - Simple Matrix Calculator
 * Date: 28.Nis.2005
 * Time: 10:54:22
 * @author Emin Þenay
 */

public class Matrix {
   /**
    * Default constructor.
    */
    Matrix()
    {
    }
    /**
     * Construct a square matrix with the given values.
     *
     * @param N Row and column size.
     * @param value Initial value.
     */
    Matrix (int N, double value)
    {
        this (N, N, value);
    }
    /**
     * Construct a matrix with the given row, column and
     * initial values.
     *
     * @param M Row size.
     * @param N Column size.
     * @param value Initial value.
     */
    Matrix (int M, int N, double value)
    {
        // construct a new matrixArray with given row and column values
        matrixArray = new double [M][N];

        // set the values of the elements of the matrix
        for (int row = 0; row < M ; row++)
            for (int col = 0; col < N ; col++)
                matrixArray[row][col] = value;
    }
    /**
     * Construct a matrix with the given row and
     * column values.
     *
     * @param M Row size.
     * @param N Column size.
     */
    Matrix (int M, int N)
    {
        // construct a new matrixArray with given row and column values
        matrixArray = new double[M][N];
    }
    /**
     * Copy constructor.
     *
     * @param M Matrix to be copied.
     */
    Matrix (Matrix M)
    {
        // take the row and column numbers of the matrix to be copied
        int rows = M.getNoRows();
        int cols = M.getNoCols();

        // construct a new matrix with these row and column numbers
        matrixArray = new double[rows][cols];

        // copy the values of the initial matrix
        for (int row = 0; row < rows; row++)
            for (int col = 0; col < cols; col++)
            {
                MyDouble value = new MyDouble(0);
                M.getElem(row, col, value);
                matrixArray[row][col] = value.todouble();
            }
    }
    /**
     * Give the number of columns.
     *
     * @return Number of columns.
     */
    int getNoCols()
    {
        return matrixArray[0].length;
    }
    /**
     * Give the number of rows.
     *
     * @return Number of rows.
     */
    int getNoRows()
    {
        return matrixArray.length;
    }
    /**
     * Give the element in specified row and column numbers.
     *
     * @param x Row number.
     * @param y Column number.
     * @param result Element to be returned.
     * @return True if operation is successful.
     */
    boolean getElem (int x, int y, MyDouble result)
    {
        // set the value of result to the place given
        // by row and column values
        try{
            result.setValue(matrixArray[x][y]);
            return true;
        }catch(ArrayIndexOutOfBoundsException e){
            return false;
        }
    }
    /**
     * Set the element in specified row and column numbers.
     *
     * @param x Row number.
     * @param y Column number.
     * @param value Value to be set.
     * @return True if operation is successful.
     */
    boolean setElem (int x, int y, double value)
    {
        // check if x and y exceeds the row and column number of the matrix
        if (getNoRows() <= x || getNoCols() <= y)
            return false;

        // set the value to the correct place
        matrixArray[x][y] = value;
        return true;
    }
    /**
     * Check if the matrix is square or not.
     *
     * @return True if square, false o/w.
     */
    boolean isSquare()
    {
        if (getNoRows() == getNoCols())
            return true;
        return false;
    }
    /**
     * Check if the matrix is diagonal or not.
     *
     * @return True if diagonal, false o/w.
     */
    boolean isDiagonal()
    {
        // check if the matrix is square
        if (!isSquare())
            return false;

        // check the diagonality of the matrix
        for (int row = 0; row < getNoRows(); row++)
            for (int col = 0; col < getNoCols(); col++)
            {
                if (row == col)
                    continue;
                MyDouble value = new MyDouble(0);
                getElem(row, col, value);
                if (value.todouble() != 0)
                    return false;
            }
        return true;
    }
    /**
     * Check if the matrix is an identity matrix or not.
     *
     * @return True if identity, false o/w.
     */
    boolean isIdentity()
    {
        // check if the matrix is square
        if (!isSquare())
            return false;

        // check if the square matrix is an indentity matrix
        for (int row = 0; row < getNoRows(); row++)
            for (int col = 0; col< getNoCols(); col++)
            {
                MyDouble value = new MyDouble(0);
                getElem(row,col,value);
                if (row == col && value.todouble() != 1.0)
                    return false;
                else if (row != col && value.todouble() != 0.0)
                    return false;
            }
        return true;
    }
    /**
     * Make an identity matrix from the given matrix.
     *
     * @return True if operation is successful.
     */
    boolean makeIdentity()
    {
        // check if the matrix is square
        if (!isSquare())
            return false;

        // set the elements of the square matrix
        for (int row = 0; row < getNoRows() ; row++)
            for (int col = 0; col < getNoCols(); col++)
            {
                if (row == col)
                    setElem(row,col,1);
                else
                    setElem(row,col,0);
            }
        return true;
    }
    /**
     * Make a zero matrix from the given matrix.
     *
     */
    void makeZero()
    {
        // make all elements zero
        for (int row = 0; row < getNoRows(); row++)
            for (int col = 0; col < getNoCols() ; col++)
                setElem(row,col,0);
    }
    /**
     * Assign a random floating point number to each element
     * of the matrix. If intFlag is true, then truncate random numbers.
     *
     * @param minVal Minimum value of the random number.
     * @param maxVal Maximum value of the random number.
     * @param intFlag Integer flag.
     */
    void makeRandom (double minVal, double maxVal, boolean intFlag)
    {
        // create a new seed for random numbers
        Random seed = new Random();

        // if elements are wanted to be integers
        if (intFlag)
        {
            for (int row = 0; row < getNoRows(); row++)
                for (int col = 0; col < getNoCols() ; col++)
                {
                    int diff =(int)(maxVal - minVal + 1);
                    // create a random integer number which has
                    // maximum value of the difference of the
                    // maxVal and minVal
                    int rnd = seed.nextInt(diff);

                    // set the element with this random number + minVal
                    setElem(row,col,rnd + minVal);
                }
        }
        else // if elements are wanted to be doubles
        {
            for (int row = 0; row < getNoRows(); row++)
                for (int col = 0; col < getNoCols() ; col++)
                {
                   // create a random double number between 0.0 and 1.0
                    double rnd = seed.nextDouble();
                    double diff = maxVal - minVal;

                    // multiply the difference with random number to get
                    // a random double between 0 and the difference
                    // of maxVal and minVal
                    rnd *= diff;

                    // set the element with this random number + minVal
                    setElem(row,col,rnd + minVal);
                }
        }
    }
    /**
     * Save matrix to a file.
     *
     * @param fileName Name of the file.
     * @return True if operation is successful.
     */
    boolean save (String fileName)
    {
        FileOutputStream out; //declare a file output object
        PrintStream p; //declare a print stream object

        // open the file and bind p to file
        try {
            out = new FileOutputStream(fileName);
        } catch (FileNotFoundException e) {
            return false;
        }
        p = new PrintStream(out);

        // print row and column numbers of the matrix
        p.println (getNoRows() + " " + getNoCols());

        // print all elements of the matrix with a " " between them
        for (int row = 0; row < getNoRows() ; row++)
        {
            for (int col = 0; col < getNoCols() ; col++)
            {
                MyDouble value = new MyDouble(0);
                getElem(row,col,value);
                p.print (value.todouble() + " ");
            }
            p.print ("\n");
        }
        return true;
    }
    /**
     * Load matrix to a file.
     *
     * @param fileName Name of the file.
     * @return True if operation is successful.
     */
    boolean load(String fileName)
    {
        //initializing the variables
        File inputFile = new File(fileName);
        BufferedReader reader = null;

        //Opening the file
        try {
            reader = new BufferedReader(new FileReader(inputFile));
        } catch (FileNotFoundException e) {
            return false;
        }

        //Reading from the file
        String line = ""; //creating the string which will be used to read from the file
        try {
            line = reader.readLine();
            String [] result = line.split("\\s"); //we split the string according to blanks
            int rowNo = Integer.parseInt(result[0]);
            int colNo = Integer.parseInt(result[1]);

            // construct a new matrixArray according to rowNo and colNo
            matrixArray = new double[rowNo][colNo];

            // we will read and initialize the values
            for (int row = 0; row < rowNo; row++)
            {
                result = (reader.readLine()).split("\\s"); //we split the string according to blanks
                for (int col = 0; col < colNo; col++)
                    setElem(row,col,Double.parseDouble(result[col]));
            }
            return true;
        } catch (IOException e) {
            return false;
        }
    }
    /**
     * Transpose the matrix.
     *
     */
    void transpose()
    {
        // create a copy of the matrix
        Matrix tmp = new Matrix(this);

        // change the matrixArray
        matrixArray = new double[tmp.getNoCols()][tmp.getNoRows()];

        // initialize all elements again
        for (int row = 0; row < tmp.getNoRows(); row++)
            for (int col = 0; col < tmp.getNoCols(); col++)
            {
                MyDouble value = new MyDouble(0);
                tmp.getElem(row,col,value);
                setElem(col,row,value.todouble());
            }

        // delete the copy matrix
        tmp = null;
    }
    /**
     * Negate all elements in the matrix.
     *
     */
    void negate()
    {
        for (int row = 0 ; row < getNoRows(); row++)
            for (int col = 0; col < getNoCols(); col++)
            {
                MyDouble value = new MyDouble(0);

                // get the element
                getElem(row, col, value);

                //set the negated element
                setElem(row,col,-(value.todouble()));
            }
    }
    /**
     * Multiply matrix with another matrix.
     *
     * @param M matrix to be multiplied.
     * @return False if dimensions do not match. True o/w.
     */
    boolean times (Matrix M)
    {
        // check dimension compatibility
        if (getNoCols() != M.getNoRows())
            return false;

        // initialize the element to be set to the matrix
        double i = 0;

        // copy the initial matrix
        Matrix tmp = new Matrix(this);

        // change the matrixArray to the new dimensions
        matrixArray = new double[tmp.getNoRows()][M.getNoCols()];

        // do the multiplication
        for (int rowtmp = 0; rowtmp < tmp.getNoRows(); rowtmp++)
            for (int colM = 0; colM < M.getNoCols(); colM++)
            {
                for (int coltmp = 0; coltmp < tmp.getNoCols(); coltmp++)
                {
                    MyDouble valuetmp = new MyDouble(0);
                    MyDouble valueM = new MyDouble(0);
                    tmp.getElem(rowtmp,coltmp,valuetmp);
                    M.getElem(coltmp,colM,valueM);
                    i += valuetmp.todouble() * valueM.todouble();
                }
                setElem(rowtmp,colM,i);
                i = 0;
            }
        tmp = null;
        return true;
    }
    /**
     * Multiply matrix with a scalar value.
     *
     * @param value Scalar to be multiplied.
     */
    void times (double value)
    {
        // get all elements and set multiplicated values
        for (int row = 0; row < getNoRows(); row++)
            for (int col = 0; col < getNoCols(); col++)
            {
                MyDouble val = new MyDouble(0);
                getElem (row,col,val);
                setElem(row,col,val.todouble()*value);
            }
    }
    /**
     * Add matrix to another matrix.
     *
     * @param M matrix to be added.
     * @return False if dimensions do not match. True o/w.
     */
    boolean plus(Matrix M)
    {
        // dimension check
        if (getNoRows() != M.getNoRows() || getNoCols() != M.getNoCols())
            return false;

        // add matrices
        for (int row = 0; row < getNoRows(); row++)
            for (int col = 0; col < getNoCols() ; col++)
            {
                MyDouble value = new MyDouble(0);
                MyDouble valueM = new MyDouble(0);
                getElem(row,col,value);
                M.getElem(row,col,valueM);
                setElem(row,col,value.todouble()+valueM.todouble());
            }
        return true;
    }
    /**
     * Subtract another matrix from the matrix.
     *
     * @param M matrix to be subtracted.
     * @return False if dimensions do not match. True o/w.
     */
    boolean minus(Matrix M)
    {
        // create a copy of matrix to be added and negate it
        Matrix tmp = new Matrix(M);
        tmp.negate();

        // add the copy matrix to our matrix
        return plus(tmp);
    }
    /**
     * Construct and return a new matrix from the
     * row rowNumber of matrix.
     *
     * @param rowNumber Row number from which a new
     * matrix will be constructed.
     * @param M New matrix.
     * @return True if given rowNumber is smaller than
     * the number of rows in the matrix, false o/w.
     */
    boolean getRow (int rowNumber, Matrix M)
    {
        // change the matrixArray of the given matrix
        M.matrixArray = new double[1][getNoCols()];

        // set all elements of the given matrix
        for (int col = 0; col < getNoCols(); col++)
        {
            MyDouble value = new MyDouble(0);
            if (getElem(rowNumber,col,value))
                M.setElem(0,col,value.todouble());
            else
                return false;
        }
        return true;
    }
    /**
     * Construct and return a new matrix from the
     * column colNumber of matrix.
     *
     * @param colNumber Column number from which a new
     * matrix will be constructed.
     * @param M new matrix.
     * @return True if given colNumber is smaller than
     * the number of columns in the matrix, false o/w.
     */
    boolean getCol (int colNumber, Matrix M)
    {
         // change the matrixArray of the given matrix
        M.matrixArray = new double[getNoRows()][1];

        // set all elements of the given matrix
        for (int row = 0; row < getNoRows(); row++)
        {
            MyDouble value = new MyDouble(0);
            if (getElem(row,colNumber,value))
                M.setElem(row,0,value.todouble());
            else
                return false;
        }
        return true;
    }
    /**
     * Paste values of matrix M to row rowNumber of matrix.
     *
     * @param rowNumber Row number to be changed.
     * @param M Row vector to be pasted.
     * @return False if M is not a row vector or size of
     * the M is bigger than the number of columns in the
     * matrix, true o/w.
     */
    boolean setRow (int rowNumber, Matrix M)
    {
        // dimension check
        if (M.getNoRows() != 1 || M.getNoCols() != getNoCols())
            return false;

        // change all elements of the matrix with the elements
        // of the given matrix
        for (int col = 0; col < getNoCols(); col++)
        {
            MyDouble value = new MyDouble(0);
            M.getElem(0,col,value);
            setElem(rowNumber,col,value.todouble());
        }
        return true;
    }
    /**
     * Paste values of matrix M to column colNumber of matrix.
     *
     * @param colNumber Column number to be changed.
     * @param M Column vector to be pasted.
     * @return False if M is not a column vector or size of
     * the M is bigger than the number of rows in the
     * matrix, true o/w.
     */

    boolean setCol (int colNumber, Matrix M)
    {
        // dimension check
        if (M.getNoCols() != 1 || M.getNoRows() != getNoRows())
            return false;

        // change all elements of the matrix with the elements
        // of the given matrix
        for (int row = 0; row < getNoRows(); row++)
        {
            MyDouble value = new MyDouble(0);
            M.getElem(row,0,value);
            setElem(row,colNumber,value.todouble());
        }
        return true;
    }
    /**
     * Values of a matrix are stored here.
     */
    double [][] matrixArray;
}
