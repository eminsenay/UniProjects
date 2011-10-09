package bts.cmpe.budget.dal.DAO.mysql;

import java.util.Enumeration;
import java.util.Vector;

import bts.cmpe.budget.businessObj.CodeBusinessObj;
import bts.cmpe.budget.transfer.CodeTO;



public class TestDal {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		CodeBusinessObj buss = new CodeBusinessObj();
		
		try {
			Vector<CodeTO> vect = buss.getFuncCode();
			
			Enumeration<CodeTO> en = vect.elements();
			
			while(en.hasMoreElements()){
				System.out.println(en.nextElement().getName());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
