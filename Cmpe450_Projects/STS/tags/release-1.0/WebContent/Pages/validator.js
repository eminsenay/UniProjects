/**
 *Bu js validation gerektiren fieldler de kullan?lmak ?zere yap?lm??t?r.
 
 *?rnek validator yaz?m?: mesela sadece ya? i?in
 		valid.number=/^\d{1,2}$/;
 		errorMessages.number="De?eri do?ru bir ya? de?il. L?tfen format? say? olacak ?ekilde giriniz. ?rnek 5,23,..."
 
 *Regular expressionlar?n kullan?m? ile ilgili olarak a??klama en altta bulunmaktad?r.
 *l?tfen errorMessages i de tan?mlay?n ki validationun ne oldu?u kullan?c?ya g?sterilsin
 
 ?rnek kullan?m:
 	<script language=javascript src="../validator.js"></script>  //include 
 
 	<input name="Anonymous" type="text" id="Anonymous" validator="number" 
 			value="l?tfen ya??n?z? yaz?n?z. " onblur="Anonymous_onblur(this)/>  //focus kaybedince...
 	<script language=javascript>
 	funciton Anonymous_onblur(t)
 	{
 		validateElement(t);  
 		//or
 		validateElement(t,true);
 		//or
 		var message=validateElement(t,false);
 		alert(message); 		
 	}
 	</script>
 * @author Anonymous     Thanks to MS Visual Studio 8.0 (.NET 2005) and MSDN
 
Harf d?zeltmeleri;	
k???k ? : &#287;
k???k ? : &#305;
k???k ? : &#351;
b?y?k ? : &#286;
b?y?k ? : &#304;
B?y?k ? : &#350;
 */


    // Validator Object
    var valid = new Object();
    var errorMessages = new Object();

    // REGEX Elements

        // not blank
        valid.isim = /[a-zA-Z0-9\-\.]/;
        
        // matches zip codes
        valid.zipCode = /\d{5}(-\d{4})?/;
        
        // matches with natural numbers
        valid.number = /^\d+$/;
        errorMessages.number="Lutfen Miktar Kismini Tamsayi Olarak Giriniz"; 
        
        //YTL     (coding2)
        valid.YTL=/^\d+(,\d{1,2})?$/;
        errorMessages.YTL="Degeri Dogru YTL Degeri Degil. L?tfen (kurussuz -> 343) yada (kuruslu -> 234,45) Seklinde Giriniz.";

        //matches email
        valid.emailAddress = /^.+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3}|[0-9]{1,3})(\]?)$/;

        // Date xx/xx/xxxx
        valid.Date = /^\d{1,2}(\-|\/|\.)\d{1,2}\1\d{4}$/;




    
    function validateForm(theForm) {
        var elms = theForm.elements; 
        for(var i = 0; i < elms.length; i++) {
           with(elms[i]) { 
              var vld = elms[i].validator;
              if(!vld) continue;               
              var thePat = valid[vld];
              var message = errorMessages[vld]; 
              var okay = thePat.exec(elms[i].value);              
              if(! okay){  
              	alert("'"+elms[i].value+"' "+message);                 
                 elms[i].select();
                 elms[i].focus(); 
                 return false;
              }
           }
        }

        return true;
     }
    function validateElement(theElement) {
        var vld = theElement.validator; 
        if(!vld) 
            return true; 
        var thePat = valid[vld]; 
        var message = errorMessages[vld]; 
        var okay = thePat.exec(theElement.value);              
        if(! okay){  
            alert("'"+theElement.value+"' "+message);                            
            theElement.select();
            theElement.focus(); 
            return false;
        }           
        return true;
     }
     function validateElement(theElement, force) {
        var vld = theElement.validator; 
        if(!vld) {
            if(force)
                return true;
            else
                return ""; 
        }
        var thePat = valid[vld];
        var message = errorMessages[vld]; 
        var okay = thePat.exec(theElement.value);              
        if(! okay){
            if(force) { 
                alert("'"+theElement.value+"' "+message);                             
                theElement.select();
                theElement.focus();
                return false; 
            }
            else                      	
                return "'"+theElement.value+"' "+message;
            
                
           
        }           
        if(force)
            return true;
        else
            return "";
     }
     
     function parseYTLtoFloat(e)
     {
        var res="";  
     	var len=e.length;
     	if(len==0)
     		res="0";		
     	for(;len>0;len--)
     		if(e.charAt(e.length-len)!=',')     	
     			res+=e.charAt(e.length-len); 
     		else
     		{
     			len--;
     			break;
     		}
     		
     	res+='.';
     	if(len>0)
     	{	
     		res+=e.charAt(e.length-len); 
     		len--;
     		if(len>0)
     			res+=e.charAt(e.length-len); 
     		else
     			res+='0';     		
     	}
     	else
     		res+='00';  			    		
     	return res; 
     }
     function convertFloattoYTL(ef)
     {
     	var e=""+ef;
        var res="";  
     	var len=e.length;
     	if(len==0)
     		res="0";		
     	for(;len>0;len--)
     		if(e.charAt(e.length-len)!='.')     	
     			res+=e.charAt(e.length-len); 
     		else
     		{
     			len--;
     			break;
     		}
     		
     	res+=',';
     	if(len>0)
     	{	
     		res+=e.charAt(e.length-len); 
     		len--;
     		if(len>0)
     			res+=e.charAt(e.length-len); 
     		else
     			res+='0';     		
     	}
     	else
     		res+='00';  			    		
     	return res;   		
     } 
     
 /*
 
		The following table contains the complete list of metacharacters and their 
	behavior in the context of regular expressions:

	CHARACTER 	DESCRIPTION 
      
	\			Marks the next character as a special character, a literal, a 
      			backreference, or an octal escape. For example, 'n' matches the character 
      			"n". '\n' matches a newline character. The sequence '\\' matches "\" and 
      			"\(" matches "(".
      			
	^			Matches the position at the beginning of the input string. If the RegExp 
      			object's Multiline property is set, ^ also matches the position following 
      			'\n' or '\r'.
      			
	$			Matches the position at the end of the input string. If the RegExp 
      			object's Multiline property is set, $ also matches the position preceding 
      			'\n' or '\r'.

	*			Matches the preceding character or subexpression zero or more times. For 
      			example, zo* matches "z" and "zoo". * is equivalent to {0,}.

	+			Matches the preceding character or subexpression one or more times. For 
      			example, 'zo+' matches "zo" and "zoo", but not "z". + is equivalent to 
      			{1,}.

	?			Matches the preceding character or subexpression zero or one time. For 
      			example, "do(es)?" matches the "do" in "do" or "does". ? is equivalent to 
      			{0,1}

	{n}			n is a nonnegative integer. Matches exactly n times. For example, 
      			'o{2}' does not match the 'o' in "Bob," but matches the two o's in "food".

	{n,}		n is a nonnegative integer. Matches at least n times. For example, 
      			'o{2,}' does not match the "o" in "Bob" and matches all the o's in 
      			"foooood". 'o{1,}' is equivalent to 'o+'. 'o{0,}' is equivalent to 'o*'.

	{n,m}		M and n are nonnegative integers, where n <= m. Matches at least n 
      			and at most m times. For example, "o{1,3}" matches the first three o's in 
      			"fooooood". 'o{0,1}' is equivalent to 'o?'. Note that you cannot put a 
      			space between the comma and the numbers.

	?			When this character immediately follows any of the other quantifiers (*, 
      			+, ?, {n}, {n,}, {n,m}), the matching pattern is non-greedy. A non-greedy 
      			pattern matches as little of the searched string as possible, whereas the 
      			default greedy pattern matches as much of the searched string as possible. 
      			For example, in the string "oooo", 'o+?' matches a single "o", while 'o+' 
      			matches all 'o's.

	.			Matches any single character except "\n". To match any character 
      			including the '\n', use a pattern such as '[\s\S]'.

	(pattern)	A subexpression that matches pattern and captures the match. The 
      			captured match can be retrieved from the resulting Matches collection 
      			using the $0???$9 properties. To match parentheses characters ( ), use '\(' 
      			or '\)'.

	(?:pattern)	A subexpression that matches pattern but does not capture the 
	      		match, that is, it is a non-capturing match that is not stored for 
   	   			possible later use. This is useful for combining parts of a pattern with 
   		   		the "or" character (|). For example, 'industr(?:y|ies) is a more 
      			economical expression than 'industry|industries'.

	(?=pattern)	A subexpression that performs a positive lookahead search, 
	      		which matches the string at any point where a string matching pattern 
    	  		begins. This is a non-capturing match, that is, the match is not captured 
      			for possible later use. For example 'Windows (?=95|98|NT|2000)' matches 
      			"Windows" in "Windows 2000" but not "Windows" in "Windows 3.1". Lookaheads 
     			do not consume characters, that is, after a match occurs, the search for 
      			the next match begins immediately following the last match, not after the 
      			characters that comprised the lookahead.

	(?!pattern)	A subexpression that performs a negative lookahead search, 
      			which matches the search string at any point where a string not matching 
      			pattern begins. This is a non-capturing match, that is, the match is not 
      			captured for possible later use. For example 'Windows (?!95|98|NT|2000)' 
      			matches "Windows" in "Windows 3.1" but does not match "Windows" in 
      			"Windows 2000". Lookaheads do not consume characters, that is, after a 
     			match occurs, the search for the next match begins immediately following 
      			the last match, not after the characters that comprised the lookahead.

	x|y			Matches either x or y. For example, 'z|food' matches "z" or "food". 
      			'(z|f)ood' matches "zood" or "food". 

   	[xyz]		A character set. Matches any one of the enclosed characters. For 
    	  		example, '[abc]' matches the 'a' in "plain". 

	[^xyz]		A negative character set. Matches any character not enclosed. For 
      			example, '[^abc]' matches the 'p' in "plain". 

	[a-z]		A range of characters. Matches any character in the specified range. 
      			For example, '[a-z]' matches any lowercase alphabetic character in the 
      			range 'a' through 'z'. 
      			
	[^a-z]		A negative range characters. Matches any character not in the 
      			specified range. For example, '[^a-z]' matches any character not in the 
      			range 'a' through 'z'. 

	\b			Matches a word boundary, that is, the position between a word and a 
      			space. For example, 'er\b' matches the 'er' in "never" but not the 'er' in 
      			"verb". 

	\B			Matches a nonword boundary. 'er\B' matches the 'er' in "verb" but not 
      			the 'er' in "never". 

	\cx			Matches the control character indicated by x. For example, \cM matches 
     			a Control-M or carriage return character. The value of x must be in the 
      			range of A-Z or a-z. If not, c is assumed to be a literal 'c' character. 

	\d			Matches a digit character. Equivalent to [0-9]. 

	\D			Matches a nondigit character. Equivalent to [^0-9]. 

	\f			Matches a form-feed character. Equivalent to \x0c and \cL.

	\n			Matches a newline character. Equivalent to \x0a and \cJ.

	\r			Matches a carriage return character. Equivalent to \x0d and \cM.

	\s			Matches any white space character including space, tab, form-feed, and 
      			so on. Equivalent to [ \f\n\r\t\v].

	\S			Matches any non-white space character. Equivalent to [^ \f\n\r\t\v]. 

	\t			Matches a tab character. Equivalent to \x09 and \cI.

	\v			Matches a vertical tab character. Equivalent to \x0b and \cK.

	\w			Matches any word character including underscore. Equivalent to 
      			'[A-Za-z0-9_]'. 

	\W			Matches any nonword character. Equivalent to '[^A-Za-z0-9_]'. 

	\xn			Matches n, where n is a hexadecimal escape value. Hexadecimal escape 
      			values must be exactly two digits long. For example, '\x41' matches "A". 
      			'\x041' is equivalent to '\x04' & "1". Allows ASCII codes to be used in 
      			regular expressions.

	\num		Matches num, where num is a positive integer. A reference back to 
      			captured matches. For example, '(.)\1' matches two consecutive identical 
      			characters. 

	\n			Identifies either an octal escape value or a backreference. If \n is 
      			preceded by at least n captured subexpressions, n is a backreference. 
      			Otherwise, n is an octal escape value if n is an octal digit (0-7).

	\nm			Identifies either an octal escape value or a backreference. If \nm is 
      			preceded by at least nm captured subexpressions, nm is a backreference. If 
      			\nm is preceded by at least n captures, n is a backreference followed by 
      			literal m. If neither of the preceding conditions exists, \nm matches 
      			octal escape value nm when n and m are octal digits (0-7).

	\nml		Matches octal escape value nml when n is an octal digit (0-3) and m 
      			and l are octal digits (0-7).

	\un			Matches n, where n is a Unicode character expressed as four hexadecimal 
      			digits. For example, \u00A9 matches the copyright symbol (??).
 
 */