
/**
 * Name: Emin Þenay
 * Student ID: 2002103907
 * Date: Mar 25, 2005
 * Time: 1:10:12 PM
 */
public class Board {
    Board() {
    }

    void GetInput(Game MyGame) {
        String Text = TextIO.getln();
        Text = Text.trim();
        if (Text.length() == 0)
            Text = TextIO.getln();
        Text = Text.toLowerCase();
        if (Text.startsWith("load"))
        {
            MyGame.Status = 1;
            int FileNameStart = Text.indexOf('(') + 1;
            MyGame.Elements=new String[1];
            MyGame.Elements[0] = new String(Text.substring(FileNameStart,Text.length()-1));
        }
        else if (Text.startsWith("save"))
        {
            MyGame.Status = 2;
            int FileNameStart = Text.indexOf('(') + 1;
            MyGame.Elements=new String[1];
            MyGame.Elements[0] = new String(Text.substring(FileNameStart,Text.length()-1));
        }
        else //piece places are given i.e. a1-a3-a5
        {
            int i = 0 , j = 1 , k = 0;
            MyGame.Elements = new String[(Text.length()+1)/3];
            while (Text.length() > j)
            {
                MyGame.Elements[k] = new String(Text.substring(i,j+1));
                i=i+3;
                j=j+3;
                k++;
            }
        }
    }

    void GiveOutput(int isBlack) {
        if (isBlack == 1)
            TextIO.put("Black>");
        else
            TextIO.put("White>");
    }

    void GiveOutput(String output) {
        TextIO.putln(output);
    }
    int EndGame(){
        char tmp = TextIO.getChar();
        if (tmp == 'Y' || tmp == 'y')
            return 1;
        return 0;
    }
    void DisplayBoard(Game MyGame)
    {
        for (int i = 7 ; i >= 0 ; i--)
        {
            int j;
            for (j = 0 ; j < 8 ; j++)
            {
                if (MyGame.boardArray[j][i] == 0)
                    TextIO.put('0');
                else if (MyGame.boardArray[j][i] == 1)
                    TextIO.put('B');
                else if (MyGame.boardArray[j][i] == 2)
                    TextIO.put('W');
            }
            TextIO.putln(" "+(i+1));
        }
        TextIO.putln("abcdefgh");
    }

}
