
import java.io.*;
import java.util.ArrayList;
import java.util.Stack;

/**
 * Name: Emin Þenay
 * Student ID: 2002103907
 * Date: Mar 25, 2005
 * Time: 1:05:52 PM
 */
public class Game {
    int Turn; //0=white 1=black
    int[][] boardArray;  //empty = 0, black = 1, white = 2
    String[] Elements; // contains list of the move given
    int Status; //0=either black or white will move, 1=load, 2=save

    Game()
    {
        //allocating space for board
        boardArray=new int[8][8];
        //Setting the turn
        Turn=0;     //0 means it is white's turn
        //Setting empty places at two ends
        for(int let = 0 ; let < 8 ; let++)
        {
            boardArray[let][0] = 0;
            boardArray[let][7] = 0;
        }
        for(int num = 1 ; num < 3 ; num++)
            for(int let = 0 ; let < 8 ; let++)
            {
                //setting white pieces
                boardArray[let][num] = 2;
                //setting black pieces
                boardArray[let][7-num] = 1;
                //setting other empty places
                boardArray[let][5-num] = 0;
            }
    }

    void SaveGame(String fileName, Board b)
    {
        FileOutputStream out; // declare a file output object
        PrintStream p; // declare a print stream object
        try
        {
          // Create a new file output stream
          // connected to String fileName
          out = new FileOutputStream(fileName);

          // Connect print stream to the output stream
          p = new PrintStream( out );

          //writing the turn to file
          if(Turn == 0) //If white's turn
            p.println ("W");
          else //If Black's turn
            p.println("B");
          //Turn is written, now board will be written

          for(int num = 7 ; num >= 0 ; num--)
          {
              for (int let = 0 ; let < 8 ; let++)
              {
                  if(boardArray[let][num] == 0) //which means this square of the board is empty
                    p.print(0);
                  else if (boardArray[let][num] == 1) //black piece is here
                    p.print('B');
                  else  //white piece is here
                    p.print('W');
              }
              p.print('\n');    //print newline
          }
          p.close();
          Status = 0;
          b.GiveOutput("Game Saved!");
        }
        //If an error occurs
        catch (Exception e)
        {
          b.GiveOutput(e.toString());
          System.exit(2);
        }
    }

    void LoadGame(String fileName, Board b)
    {
        //Initializing the variables
        File inputFile = new File (fileName);
        BufferedReader reader = null;

        //Opening The File
        try {
            reader = new BufferedReader(new FileReader(inputFile));
        } catch (FileNotFoundException e) { //If specified file cannot be found
            b.GiveOutput(e.toString());
            System.exit(3);
        }

        //Reading from the file
        String line=""; //creating the string which will be used to read from file
        char temp;
        try
        {
            String Output = new String("Game Loaded!\n");
            //Firstly, we need to take the first letter (or line) to determine the turn
            if ((line = reader.readLine()) != null)
            {
                if (line.equals("B")) //This means it is Black's turn
                {
                    Turn = 1;
                    Output += "Black's Turn.";
                }
                else  //It is White's turn
                {
                    Turn = 0;
                    Output += "White's Turn.";
                }
            }
            b.GiveOutput(Output);
            //now, reading up to the end of the file and setting the board according to it
            int linenumber = 7;  //linenumber - 1 of the board
            while ((line = reader.readLine()) != null)
            {
                for ( int let = 0 ; let < 8 ; let++ )
                {
                    //taking the specific character from the string. It may be 0, B or W
                    temp = line.charAt(let);
                    if (temp == '0')
                        boardArray[let][linenumber] = 0; //means it is empty
                    else if (temp == 'B')
                        boardArray[let][linenumber] = 1; //means Black piece is there
                    else if (temp == 'W')
                        boardArray[let][linenumber] = 2; //means White peace is there
                    else
                        b.GiveOutput("There is an error while loading.");
                 }
                linenumber--;
            }
            Status = 0;
        } catch (IOException e)
        { //If an error occurs
            b.GiveOutput(e.toString());
            System.exit(4);
        }
    }

    int[] Convert (String place)
    {
        int[] numbers = new int[2];
        char letter = place.charAt(0);
        int num = (int)place.charAt(1)-'1';
        numbers[0] = letter - 'a';
        numbers[1] = num;
        return numbers;
    }

    int Control(Board b) //return 2: white wins return 1: black wins 0:else
    {
        if (Status == 1) //User entered load command
            LoadGame(Elements[0],b);
        else if (Status == 2) //User entered save command
            SaveGame(Elements[0],b);
        else //User wants to move a piece
        {

            int [] AllPieces = new int[33];
            AllPieces = FindAllPieces(Turn);
            int tmp;

            // Learning how many places in Elements String array
            // e.g a1,a2,a3 or a1,a2
            int length = Elements.length;
            // creating an integer array to store the numerical
            // representation length*2 of places
            // one for letter and one for number
            int [] places = new int[length*2];
            // Getting numerical representations for moves made
            tmp = 0;
            for (int i = 0; i < length ; i++)
            {
                //int j = 0;
                int temp[] = new int[2];
                temp = Convert(Elements[i]);
                places[tmp++]=temp[0];
                places[tmp++]=temp[1];
            }
            //places in the boardArray is taken
            //now, we must check whether this move is valid or invalid
            int isCorrect = InputCheck(places);
            //If the move is invalid
            if(isCorrect == 0)
            {
                b.GiveOutput("Invalid Move");
                return 0;
            }
            //If the move is valid
            else
            {
                // Now, it is time to check all available moves which
                // have jumps

                // First, declare ArrayLists which will hold all best
                // moves of a piece and the best moves of the turn

                // This will hold the largest jump made by
                // the piece and all best moves of the piece
                ArrayList returned = new ArrayList();

                // This will hold the best moves of the turn
                ArrayList PossibleMoves = new ArrayList();

                // This will help to determine which moves are the best
                // moves of the turn
                int maxdepth = 0;
                for(int i = 0 ; AllPieces[i] != 9 ; i++)
                {
                    returned = BestMove(AllPieces[i++],AllPieces[i]);
                    Integer newdepth = (Integer)returned.get(0);

                    // A move with more jumps found, clearing all
                    // best move candidates and add the new candidate
                    if (maxdepth < newdepth.intValue())
                    {
                        maxdepth = newdepth.intValue();
                        PossibleMoves.clear();
                        PossibleMoves.addAll(returned);
                    }

                    // A move with the same number of jumps found,
                    // adding the new best move candidate
                    else if (maxdepth == newdepth.intValue() && maxdepth != 0)
                        PossibleMoves.addAll(returned);
                }
                // the format of the PossibleMoves is as follows:
                // depth,letterint,numberint,...,9,depth,...
                // First, we will check the validity of the given move
                // again by looking at the depths
                int notmatched = 0;
                int CurrentDepth = findDepth(places);
                if (CurrentDepth == maxdepth)
                {
                    // now, we will check the input combination of all
                    // possible inputs
                    int k = 0;
                    for (int i = 1 ; i < PossibleMoves.size() ; i++)
                    {
                        for (int j = 0 ; j < places.length ; j++)
                        {
                            k++;
                            Integer temp = new Integer(0);
                            temp = (Integer)PossibleMoves.get(i++);
                            if (places[j] != temp.intValue())
                                notmatched = 1;
                        }
                        if (notmatched == 0)
                            break;
                        notmatched = 0;
                        i = k + 3;
                        k = k + 2;
                    }
                }
                int GameEnd = 0;
                if(notmatched == 1 || CurrentDepth != maxdepth)
                {
                    // we will print the possible input combinations
                    // according to the greediness rule
                    //PossibleMoves.add(0,new Integer(places[0]));
                    //PossibleMoves.add(1,new Integer(places[1]));
                    b.GiveOutput(Greediness(PossibleMoves));
                }
                // if the move of the player is matched or there are
                // no jumps in this turn (then player can play any
                // piece he has), we need to change the places of the
                // pieces, change the turn and control if it is the
                // end of the game
                else if (notmatched == 0 || maxdepth == 0)
                {
                    // GameEnd controls only one type of game end, which
                    // is to move to the first (or the last) row
                    GameEnd = MovePiece(places,maxdepth);
                    Turn = (Turn+1)%2;
                    if (GameEnd == 1)
                    {
                        // white's turn, but it has recently changed
                        // white wins
                        if (Turn == 1)
                            return 2;
                        else
                            return 1;
                    }
                    // Now, we need to check the game end, which is to be blocked
                    // by the pieces of opponent. So, finding places of all pieces

                    // creating an array of 16*2+1=33 integers
                    // 16:max number of pieces, 2: 1 for letter and 1 for
                    // number 1:for the end, we'll put 9 at the end
                    AllPieces = FindAllPieces(Turn);
                    int IsBlocked = 1;
                    tmp=0;
                    for (tmp = 0 ; AllPieces[tmp] != 9 ; tmp++)
                    {
                        IsBlocked = CheckBlocked(AllPieces[tmp++],AllPieces[tmp],Turn);
                        if (IsBlocked == 0)
                            break;
                    }
                    // If all pieces are blocked by opponent, the game is over.
                    if (IsBlocked == 1)
                        return Turn+1;

                }
            }
        }
        return 0;
    }

    int InputCheck(int[] moves) {   //return 0: invalid 1: valid
        // initializing variables which will be used for turn analysis
        // white cannot go to lower numbers, black cannot go to higher numbers
        int White = 1, j = 1, color = 2;
        if (Turn == 1) //black's turn
        {
            color = 1;
            White = -1;
            j = 2;
        }
        // checking if inputs are given correctly (letter and number btw 0 and 7)
        for (int i = 0 ; i < moves.length ; i++)
            if (moves[i] < 0 || moves[i] > 7)
                return 0;
        // checking if there is a correct coloured piece in initial place
        if (boardArray[moves[0]][moves[1]] != color)
            return 0;
        // we will check all given places by pairs
        for (int i = 0 ; i < moves.length-2 ; i=i+2)
        {
            //checking the borders
            if(moves[i] < 0 || moves[i] > 7 || moves[i+1] < 0 | moves[i+1] > 7)
                return 0;
            // if length is 4, this means that given piece has only one move,
            // and therefore it can go next square on the board
            if(moves.length != 4)
            {
                // if letters are the same, numbers must be different than each other,
                // also their difference must be 2
                if (moves[i] == moves[i+2])
                {
                    if (moves[i+3] - moves[i+1] != 2*White)
                        return 0;
                }
                //if letters are different, this difference must be 2
                else
                {
                    if (moves[i+2] - moves[i] != 2 && moves[i+2] - moves[i] != -2)
                        return 0;
                }
            }
            else
            {
                // if letters are the same, numbers must be different than each other,
                // also their difference must be 2 or 1
                if (moves[i] == moves[i+2])
                {
                    if (moves[i+3] - moves[i+1] != 2*White && moves[i+3] - moves[i+1] != White)
                        return 0;
                }
                // if letters are different, this difference must be 2 or 1
                else
                {
                    if (moves[i+2] - moves[i] != 2 && moves[i+2] - moves[i] != 1 &&
                            moves[i+2] - moves[i] != -2 && moves[i+2] -moves[i] != -1)
                        return 0;
                }
            }
            // if there is another piece in place to jump on board
            if(boardArray[moves[i+2]][moves[i+3]] != 0)
                return 0;
            // if different coloured piece does not exist on the jumped place
            if(moves[i+2] - moves[i] == 2 || moves[i+2] - moves[i] == -2)
            {
                if(boardArray[(moves[i+2]+moves[i])/2][moves[i+1]] != j)
                    return 0;
            }
            if(moves[i+1] - moves[i+3] == 2 || moves[i+1] - moves[i+3] == -2)
            {
                if(boardArray[moves[i]][(moves[i+1]+moves[i+3])/2] != j)
                    return 0;
            }
        }
        //last two pieces' border check
        if(moves[moves.length-2] < 0 || moves[moves.length-1] <0 ||
           moves[moves.length-2] > 7 || moves[moves.length-1] >7)
        {
            return 0;
        }
        //if given places obey all these rules
        return 1;
    }

    ArrayList BestMove(int let, int num)
    {
        //declare a Stack object in order to hold possible moves
        Stack PieceHolder = new Stack();
        //declare a ArrayList object in order to list possible moves
        ArrayList PieceList = new ArrayList();
        //initialize the first element and push it onto the stack
        Piece a = new Piece(let,num,1,1);
        ToGo(let,num,a,0); // letter, number, piece, from
                           // from: 1=right, 2=left, 0=none
        PieceHolder.push(a);
        //find the possible moves
        while(!PieceHolder.isEmpty())
        {
            // pop from the stack and get and element
            a = (Piece) PieceHolder.pop();
            // declaring and initializing place and trace variables for
            // the new place
            int newLetter = a.letter, newNumber = a.number;
            long newTrace = 1;

            // If the element cannot jump further, newCreated will be
            // changed to 0
            int newCreated = 1;

            // Initialize from variable that will prevent the piece to
            // move the place it was before.
            // we will use it to prevent infinite loops caused by moving
            // left,than right,then left...
            // 0 means from back, 1 means from right, 2 means from left
            int from = 0;
            if(a.WhereToGo > 3)//which means that piece can jump to right
            {
                from = 2; //piece comes from left to the new place
                a.HasGone(4);
                newLetter+=2;
                newTrace=a.trace+40*a.depth;
            }
            else if(a.WhereToGo > 1)// which means that piece can jump
                                    // to left
            {
                from = 1; //piece comes from the right to the new place
                a.HasGone(2);
                newLetter-=2;
                newTrace=a.trace+20*a.depth;
            }
            else if(a.WhereToGo > 0)//which means that piece can jump to front
            {
                from = 0; //piece comes from the back
                a.HasGone(1);
                if (Turn == 0)//white's turn
                    newNumber+=2;
                else //black's turn
                    newNumber-=2;
                newTrace=a.trace+10*a.depth;
            }
            else // which means the piece can jump to nowhere
            // either that is the last place it can reach or it could not
            // jump at all
            {
                newCreated = 0;
                int added = 0;
                // If the place of the piece is before another move, we will
                // add the piece next to this move. We will understand this
                // by trace values
                // Now, iterating through the PieceList and searching it
                // int ListSize = PieceList.size();
                for(int i = 0 ; i < PieceList.size() ; i++)
                {
                    Piece temp = (Piece) PieceList.get(i);
                    if(temp.trace == a.trace)
                    {
                        // first, change trace in order to be searched for
                        // the next element
                        newTrace = a.trace % a.depth;
                        // then, add the piece next to the other
                        PieceList.add(i+1,new Piece(a.letter,a.number,newTrace,a.depth));
                        added = 1;
                    }
                }
                //If the place of the piece is from the last move
                if (added == 0)
                {
                    // first, change trace in order to be searched for
                    // the next element
                    a.trace = a.trace % a.depth;
                    //then, add the piece to the end of the PieceList
                    PieceList.add(a);
                }
            }
            // now, we need to push new place of the piece to
            // the PieceList (if it exists of course)
            if (newCreated == 1)
            {
                // first, creating the new piece
                Piece b = new Piece(newLetter,newNumber,newTrace,a.depth*10);
                // then, finding available moves for the piece
                ToGo(newLetter,newNumber,b,from);
                // we have finished our work with the old piece for now,
                // we should push it again
                PieceHolder.push(a);
                //we now push the new piece to th PieceHolder
                PieceHolder.push(b);
            }
        }
        // Now, the function will choose best move from the available moves
        int maxdepth = 0;
        // temp will store the places of the best moves
        // letter and number places of the best move will be listed
        // continuously If there are two best moves, there will be
        //  a 9 between them
        ArrayList temp = new ArrayList();
        for (int i = 0 ; i < PieceList.size() ; i++)
        {
            Piece t = (Piece) PieceList.get(i);
            if (t.depth > maxdepth)
                temp.clear();
            if (t.depth >= maxdepth)
            {
                maxdepth = t.depth;
                while(t.depth != 1)
                {
                    temp.add(new Integer(t.letter));
                    temp.add(new Integer(t.number));
                    i++;
                    t = (Piece) PieceList.get(i);
                }
                temp.add(new Integer(9));
            }
        }
        ArrayList ReturnList = new ArrayList();
        ArrayList nineIndex = new ArrayList();
        // counting nines and determining the places of nines in the list
        // help to understand how many possible moves are there
        for (int i = 0 ; i < temp.size() ; i++)
        {
            Integer l = new Integer(0);
            l = (Integer) temp.get(i);
            if(l.intValue() == 9)
                nineIndex.add(new Integer(i));
        }
        // moves are in the reverse order, i.e. last move is in the first
        // place. We need to change the order of them
        int countbegin = 0;
        for (int i = 0 ; i < nineIndex.size() ; i++)
        {
            ReturnList.add(new Integer(let));
            ReturnList.add(new Integer(num));
            Integer tmp = new Integer(0);
            tmp = (Integer) nineIndex.get(i);
            int countend = tmp.intValue();
            while ( countend != 0 && countend > countbegin)
            {
                ReturnList.add(temp.get(countend-2));
                ReturnList.add(temp.get(countend-1));
                countend = countend-2;
            }
            countbegin = tmp.intValue() + 1;
            // ReturnList will contain the depth, move combination, and
            // 9 and sth and moves again...
            ReturnList.add(new Integer(9));
            ReturnList.add(new Integer(9));
        }
        int i = 0;
        while (maxdepth != 1)
        {
            maxdepth/=10;
            i++;
        }
        ReturnList.add(0,new Integer(i));
        // Removing last 9
        ReturnList.remove(ReturnList.size()-1);
        return ReturnList;
    }

    void ToGo(int letter,int number,Piece a,int from)
    //color: 0 = white 1 = black
    //from: 1:right 2:left 0:none
    {
        // boardArray[x][y]==0 -> empty, 1->black, 2->white
        // if the place to jump rightside is empty and in the board, if
        // the piece jumped has different color and if this piece did
        // not come from the right
        if (letter < 6)
            if(boardArray[letter+2][number] == 0 && letter < 6 &&
                    boardArray[letter+1][number] == Turn+1 && from != 1)
                a.WillGo(4);
        // if the place to jump leftside is empty and in the board,
        // if the piece jumped has different color
        // and if this piece did not come from the left
        if (letter > 1)
            if(boardArray[letter-2][number] == 0 && letter > 1 &&
                    boardArray[letter-1][number] == Turn+1 && from != 2)
                a.WillGo(2);
        // if the place to jump forward is empty and in the board,
        // if the piece jumped has different color
        if(Turn == 0 && number < 6)//if our piece is white
        {
            if(boardArray[letter][number+2] == 0 && number < 6  &&
               boardArray[letter][number+1] == 1)
                a.WillGo(1);
        }
        if (Turn == 1 && number > 1)//if our piece is black
        {
            if(boardArray[letter][number-2] == 0 && number > 1  &&
               boardArray[letter][number-1] == 2)
                a.WillGo(1);
        }
    }
    String Greediness(ArrayList moves)
    {
        String output = new String();
        int count = 1;
        output = "According to the greediness rule possible moves are:" + '\n' + (count++) +". ";
        for (int i = 1 ; i < moves.size() ; i++)
        {
            //taking letter value
            Integer tmp = (Integer) moves.get(i++);
            char lettertmp =(char)(tmp.intValue() + 'a');
            Character letterch = new Character(lettertmp);
            String letter = new String(letterch.toString());
            //taking number value
            tmp = (Integer) moves.get(i);
            int number = tmp.intValue() +1;
            output += letter+number+"-";
            tmp = (Integer) moves.get(i+1);
            if (tmp.intValue() == 9) //this means move combination is over
            {
                //deleting the "-" at the end of the line
                output = output.substring(0,output.length()-1);
                // we will pass to the next combination
                i = i+2;
                output += "\n" + (count++) + ". ";
            }
        }
        //removing last number sequence and returning the string
        return output.substring(0,output.length()-3);
    }
    int MovePiece (int [] places, int hasjumps)
    {
        // first, deleting the piece from the starting point
        boardArray[places[0]][places[1]] = 0;
        // then, putting the piece to the end point
        if (Turn == 0) //white's turn
            boardArray[places[places.length-2]][places[places.length-1]] = 2;
        else // black's turn
            boardArray[places[places.length-2]][places[places.length-1]] = 1;
        // then, deleting the elements if it is needed
        if (hasjumps != 0)
        {
            for (int i = 0 , j = 1 ; j < places.length ; i++ , j++)
            {
                if (i < places.length - 2 && places[i] == places[i+2])
                    boardArray[places[i]][(places[j] + places[j+2]) / 2] = 0;
                else if (j < places.length - 2 && places[j] == places[j+2])
                    boardArray[(places[i] + places[i+2])/2][places[j]] = 0;
                i++;
                j++;
            }
        }
        // now, checking the end of the game
        if (places[places.length-1] == 7 || places[places.length-1] == 0)
            return 1;
        return 0;
    }
    int [] FindAllPieces (int isBlack)
    {
        int [] AllPieces = new int[33];
                int count=0;
                for(int i = 0 ; i < 8 ; i++)
                {
                    for(int j = 0 ; j < 8 ; j++)
                        if(boardArray[i][j] != 0 &&
                           boardArray[i][j]%2 == isBlack)//which means it is the correct colored piece
                        {
                            AllPieces[count++] = i; //for letter
                            AllPieces[count++] = j; //for number
                        }

                }
                AllPieces[count] = 9;
        return AllPieces;
    }
    int CheckBlocked(int letter, int number, int IsBlack)
    {
        int result1=0,result2=0,result3=0;
        switch(letter)
        {
            case 0:
                result1 = checkLeftRight(2,letter,number,0);
                break;
            case 1:
                result1 = checkLeftRight(2,letter,number,0);
                result2 = checkLeftRight(1,letter,number,1);
                break;
            case 2: case 3: case 4: case 5:
                result1 = checkLeftRight(2,letter,number,0);
                result2 = checkLeftRight(2,letter,number,1);
                break;
            case 6:
                result1 = checkLeftRight(1,letter,number,0);
                result2 = checkLeftRight(2,letter,number,1);
                break;
            case 7:
                result2 = checkLeftRight(2,letter,number,1);
                break;
        }
        result3 = checkFront (letter,number,IsBlack);
        if (result1 == 1 || result2 == 1 || result3 == 1)
            return 0;
        return 1;
    }
    int checkLeftRight (int Type, int letter, int number, int left)
    // Type 1: piece in b or g, Type 2: else
    {
        int i = -1;
        if (left == 0)
            i = 1;
        if (Type == 1)
        {
            //check next square is empty or not
            if (boardArray[letter+i][number] == 0)
                return 1;
        }
        else
        {
            //check next square is empty or not
            if (boardArray[letter+i][number] == 0)
                return 1;
            //if not empty, check if it has different color and check 2 next to it is empty
            if (boardArray[letter][number] != boardArray[letter+i][number] && boardArray[letter+2*i][number] == 0)
                return 1;
        }
        return 0;
    }
    int checkFront (int letter, int number, int IsBlack)
    {
        int i = 1;
        if (IsBlack == 1)//blacks move to smaller numbers when moving to front
            i = -1;
        if (boardArray[letter][number+i] == 0)
            return 1;
        if (boardArray[letter][number] != boardArray[letter][number+i] && boardArray[letter][number+2*i] == 0)
            return 1;
        return 0;
    }
    //finds the depth of given input
    int findDepth(int [] places)
    {
        int depth = (places.length - 2)/2;
        if (depth == 1) // no jump or 1 jump have both 1 depths, but no jump must have 0 depth
        {
            if (places[0] - places[2] == 1 || places[0] - places[2] == -1 ||
                places[1] - places[3] == 1 || places[1] - places[3] == -1)
                depth = 0;
        }
        return depth;
    }
}
