
/**
 * Name: Emin Þenay
 * Student ID: 2002103907
 * Date: Mar 26, 2005
 * Time: 6:01:11 PM
 */
public class Piece {
    int letter; //the letter place of the piece a=0
    int number; //the number place of the piece number=numplace-1
    long trace; //will store moves before made
    /** The trace of the first piece is 1
     * if piece can jump to right trace of the new piece is 41
     * if piece can jump to left trace of the new piece is 21
     * if piece can jump to front trace of the new piece is 11 
     * then the trace of the newer piece will be 141,241,441,121,221... */
    int depth; //depth of the first piece is 1, the new piece (where it moved) is 10, 100...
    int WhereToGo; //1=forward 2=left 4=right
    Piece(int let, int num, long tra, int dep)
    {
        letter=let;
        number=num;
        trace=tra;
        depth=dep;
        WhereToGo=0;
    }
    void WillGo(int num)
    {
        WhereToGo+=num;
    }
    void HasGone(int num)
    {
        WhereToGo-=num;
    }
}
