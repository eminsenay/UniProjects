package global;
import java.sql.Date;;

/**
 * @author ozan
 *
 */
public final class InputChecker {
	
	/**
	 * private constructor.
	 */
	private InputChecker() {
		
	}
	/**
	 * @param inputStr input
	 * @return true if input is a string<br>
	 * false otherwise
	 */
	public static boolean checkString(final String inputStr) {
		if (inputStr == null) {
			return false;
		}
		// strangely enough jsp sends empty inputs as 
		// "" strings (not as null strings)
		if (inputStr.trim().length() == 0) {
			return false;
		}
		if (inputStr.contains("\'")) {
			return false;
		}
		return true;
	}
	/**
	 * @param inputStr input
	 * @return true if input is an int<br>
	 * false otherwise
	 */
	public static boolean checkInt(final String inputStr) {
		if (inputStr == null) {
			return false;
		}
		// strangely enough jsp sends empty inputs as 
		// "" strings (not as null strings)
		if (inputStr.trim().length() == 0) {
			return false;
		}
		try {
			Integer.parseInt(inputStr);
		} catch (NumberFormatException e) {
			return false;
		}		
		return true;
	}

	/**
	 * @param inputStr input
	 * @return true if input is an int<br>
	 * false otherwise
	 */
	public static boolean checkBoolean(final String inputStr) {
		if (inputStr == null) {
			return false;
		}
		// strangely enough jsp sends empty inputs as 
		// "" strings (not as null strings)
		if (inputStr.trim().length() == 0) {
			return false;
		}
		if (inputStr.compareToIgnoreCase("true") == 0) {
			return true;
		} 
		if (inputStr.compareToIgnoreCase("false") == 0) {
			return true;
		}
		else {
			return false; 
		}
	}
	/**
	 * @param inputStr input
	 * @return true if input is an Double<br>
	 * false otherwise
	 */
	public static boolean checkDouble(final String inputStr) {
		if (inputStr == null) {
			return false;
		}
		// strangely enough jsp sends empty inputs as 
		// "" strings (not as null strings)
		if (inputStr.trim().length() == 0) {
			return false;
		}
		try {
			Double.parseDouble(inputStr);
		} catch (NumberFormatException e) {
			return false;
		}		
		return true;
	}
	
	
	/**
	 * @param inputStr input
	 * @return true if input is a date<br>
	 * false otherwise
	 * format is yyyy-mm-dd
	 */
	public static boolean checkDate(final String inputStr) {
		if (inputStr == null) {
			return false;
		}
		// strangely enough jsp sends empty inputs as 
		// "" strings (not as null strings)
		if (inputStr.trim().length() == 0) {
			return false;
		}
		try {
			Date.valueOf(inputStr);
		} catch (final IllegalArgumentException ex) {
			return false;
		}
		return true;
	}
}
