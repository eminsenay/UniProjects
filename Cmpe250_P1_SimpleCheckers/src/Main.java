
/**
 * Name: Emin Þenay
 * Student ID: 2002103907
 * Date: Apr 9, 2005
 * Time: 6:13:19 PM
 */
public class Main {
    public static void main(String [] args)
    {
        Game MyGame = new Game();
        Board Display = new Board();
        int EndOfGame = 0;
        Display.GiveOutput(">Welcome to CMPE 250 Checkers");
        while (true)
        {
            Display.DisplayBoard(MyGame);
            Display.GiveOutput(MyGame.Turn);
            Display.GetInput(MyGame);
            EndOfGame = MyGame.Control(Display);
            if (EndOfGame != 0)
            {
                String EndGameStr = new String("Game Over - ");
                if (EndOfGame == 1) // black player wins
                    EndGameStr += "Black ";
                else
                    EndGameStr += "White ";
                EndGameStr += "Player Wins!! \n>Would you like to play another game (Y/N)?";
                Display.GiveOutput(EndGameStr);
                int Question = Display.EndGame();
                if (Question == 0)
                    break;
                else
                {
                    MyGame = new Game();
                    EndOfGame = 0;
                }
            }

        }
        System.exit(0);
    }
}
