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
	 * @return true if input is a string, even if empty<br>
	 * false otherwise
	 */
	public static boolean checkStringCanEmpty(final String inputStr) {
		if (inputStr == null) {
			return false;
		}
		if (inputStr.contains("\'")) {
			return false;
		}
		return true;
	}
	
	
	public static boolean checkIntCanEmpty(final String inputStr) {
		
		if (inputStr == null) {
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
	
	/**
	 * @param inputStr date input
	 * @return yyyy-mm-dd type string
	 */
	public static String convertDate(final String inputStr) {
		
		String ret = null;
		String[] dateArgs;
		
		if (inputStr.contains("/")) {
			dateArgs = inputStr.split("/");
		}
		
		else {
			dateArgs = inputStr.split("\\.");
		}
		
		ret = "";
		
		for (int i = 0; i < dateArgs.length; i++) {
			
			ret += dateArgs[dateArgs.length - i - 1];
			
			if (i != dateArgs.length - 1) {
				ret += "-";
			}
		}

		return ret;
		
	}
	
	/**
	 * @param inputStr date string in yyyy-mm-dd format
	 * @return date string in dd/mm/yyyy format
	 */
	public static String reverseDate(String inputStr)
	{
		String ret = "";
		
		String[] args;
		
		args = inputStr.split("-");
		
		for (int i = args.length - 1; i >= 0; i--) {
			
			ret += args[i];
			
			if (i != 0) {
				ret += "/";
			}
		}
		
		return ret;
	}

}
