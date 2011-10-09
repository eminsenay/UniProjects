import java.util.ArrayList;


public class Rules {
	/*
	 * (<= (NEXT (CELL ?Y)) (DOES ROBOT MOVE) (TRUE (CELL ?X)) (ADJACENT ?X ?Y))
	 * 
	 * nextTruth = CELL ?Y;
	 * action = DOES ROBOT MOVE;
	 * ruleRequirements = CELL ?X, ADJACENT ?X ?Y;
	 * 
	 */
	
	private String nextTruth = "";
	private String action = "";
	private ArrayList<String> ruleRequirements = new ArrayList<String>();
	
	
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getNextTruth() {
		return nextTruth;
	}
	public void setNextTruth(String nextTruth) {
		this.nextTruth = nextTruth;
	}
	public ArrayList<String> getRuleRequirements() {
		return ruleRequirements;
	}
	public void setRuleRequirements(ArrayList<String> ruleRequirements) {
		this.ruleRequirements = ruleRequirements;
	}
	
	

}
