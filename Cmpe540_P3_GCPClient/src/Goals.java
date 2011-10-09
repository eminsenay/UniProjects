import java.util.ArrayList;


public class Goals {
	/*
	 * (<= (GOAL ROBOT 0) (TRUE (GOLD ?X)) (DISTINCT ?X A))
	 * 
	 * goalName = ROBOT 0;
	 * goalRequirements = GOLD ?X, DISTINCT ?X A;
	 * 
	 */
	
	private String goalName = "";
	private ArrayList<String> goalRequirements = new ArrayList<String>();
	
	
	public String getGoalName() {
		return goalName;
	}
	public void setGoalName(String goalName) {
		this.goalName = goalName;
	}
	public ArrayList<String> getGoalRequirements() {
		return goalRequirements;
	}
	public void setGoalRequirements(ArrayList<String> goalRequirements) {
		this.goalRequirements = goalRequirements;
	}

}
