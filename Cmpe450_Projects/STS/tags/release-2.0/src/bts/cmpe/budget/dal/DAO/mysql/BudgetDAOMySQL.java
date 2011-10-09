/**
 * 
 */
package bts.cmpe.budget.dal.DAO.mysql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Vector;

import bts.cmpe.budget.dal.DAObase;
import bts.cmpe.budget.dal.Querier;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.interfaces.BudgetDAO;
import bts.cmpe.budget.exception.BudgetAlreadyDefined;
import bts.cmpe.budget.exception.NoSuchBudgetException;
import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author Koca Kahin
 * 
 */
public class BudgetDAOMySQL extends DAObase implements BudgetDAO {

	/**
	 * 
	 */
	private static final int ONE = 1;

	/**
	 * 
	 */
	private static final int TWO = 2;

	/**
	 * 
	 */
	private static final int THREE = 3;

	/**
	 * 
	 */
	private static final int FOUR = 4;

	/**
	 * 
	 */
	private static final int FIVE = 5;

	/**
	 * 
	 */
	private static final int SIX = 6;

	/**
	 * 
	 */
	private static final int SEVEN = 7;

	/**
	 * @param tr
	 *            Transaction parameter connects actions of DAO object to a
	 *            transaction chain defined by the member of Transaction object
	 *            of type Connection.
	 */
	public BudgetDAOMySQL(final Transaction tr) {
		super(tr);
	}
	
	/**
	 * @param bgdt B
	 * @return Budget instance
	 * @throws NoSuchBudgetException No budget found.
	 */
	public final BudgetTO getBudgetDetail(final BudgetTO bgdt) 
	throws NoSuchBudgetException {
		BudgetTO bt = null;
		try {
			bt = Querier.selectBudgetForUpdate(bgdt.getInstCode(), 
					bgdt.getFuncCode(), 
					bgdt.getEcoCode(), 
					super.getConn());
		} catch (SQLException e) {
			e.getErrorCode();
		}
		
		return bt;
	}

	/**
	 * After call to this function type of expenditures for current department
	 * is set.
	 * 
	 * @param budget
	 *            department
	 * @return all economic sub parts
	 * @throws NoSuchDepartmentException
	 *             if department does not exist.
	 */
	public final Vector < BudgetTO > getEconomicCodes(final BudgetTO budget)
			throws NoSuchBudgetException {

		PreparedStatement prep = null;
		Vector < BudgetTO > budgetVect = null;
		ResultSet rs = null;
		
		final String query = "SELECT budget_id_i, budget_type_i, "
				+ "net_budget_np13s2, num_main_appr_i, "
				+ "inst_code_v11, func_code_v9,"
				+ "eco_code_v4 FROM CORE_BUDGET "
				+ "WHERE inst_code_v11 = ? and func_code_v9 = ? "
				+ "ORDER BY eco_code_v4 FOR UPDATE";

		try {
			prep = super.getConn().
			prepareStatement(query);
			
			prep.setString(ONE, budget.getInstCode());
			prep.setString(TWO, budget.getFuncCode());
						
			rs = prep.executeQuery();

			budgetVect = new Vector();
			
			while (rs.next()) {
				budgetVect.addElement(new BudgetTO(rs.getInt(ONE),
						rs.getInt(TWO), rs.getDouble(THREE), 
						rs.getInt(FOUR), rs.getString(FIVE), 
						rs.getString(SIX), rs.getString(SEVEN)));
			}
			
			if (budgetVect.size() == 0) {
				throw new NoSuchBudgetException(budget);
			}
			
		} catch (SQLException ex) {
			ex.getSQLState();
		} finally {
			try {
				rs.close();
				prep.close();
			} catch (SQLException e) {
				rs = null;
				prep = null;
			}
		}

		return budgetVect;
	}

	/**
	 * @param budget
	 *            new budget item.
	 * @throws BudgetAlreadyDefined  Don't allow duplicate entry.
	 */
	public final void insertBudget(final BudgetTO budget) 
	throws BudgetAlreadyDefined {
		PreparedStatement prep = null;

		// final String dmlInst = "INSERT INTO ref_institutional VALUES (?,?)";
		// final String dmlFunc = "INSERT INTO ref_functional VALUES (?,?)";
		// final String dmlEco = "INSERT INTO ref_economic VALUES (?,?)";
		final String dmlBudget = "INSERT INTO CORE_BUDGET "
				+ "VALUES (?,?,?,?,?,?,?)";

		try {
			/**
			 * prep = super.getConn().prepareStatement(dmlInst);
			 * prep.setString(1, budget.getInstCode()); prep.setNull(2,
			 * Types.VARCHAR);
			 * 
			 * prep.execute(); prep.close();
			 * 
			 * prep = super.getConn().prepareStatement(dmlFunc);
			 * prep.setString(1, budget.getFuncCode()); prep.setNull(2,
			 * Types.VARCHAR);
			 * 
			 * prep.execute(); prep.close();
			 * 
			 * prep = super.getConn().prepareStatement(dmlEco);
			 * prep.setString(1, budget.getEcoCode()); prep.setNull(2,
			 * Types.VARCHAR);
			 * 
			 * prep.execute(); prep.close();
			 */

			prep = super.getConn().prepareStatement(dmlBudget);

			prep.setNull(ONE, Types.INTEGER);
			prep.setInt(TWO, budget.getType());
			prep.setDouble(THREE, 0.0);
			prep.setInt(FOUR, budget.getNumMainAppr());
			prep.setString(FIVE, budget.getFuncCode());
			prep.setString(SIX, budget.getEcoCode());
			prep.setString(SEVEN, budget.getInstCode());

			prep.execute();
		} catch (SQLException ex) {
			if (ex.getErrorCode() == BudgetAlreadyDefined.ERR_CODE) {
				throw new BudgetAlreadyDefined(budget);
			}
		} finally {
			try {
				prep.close();
			} catch (SQLException e) {
				prep = null;
			}
		}
	}

	/**
	 * Depreceated...
	 * 
	 * @param old
	 *            budget to update
	 * @param newB
	 *            final state of budget
	 * @throws NoSuchBudgetException budget does not exist.
	 */
	public final void updateBudget(final BudgetTO old, final BudgetTO newB)
			throws NoSuchBudgetException {
		
		final String dml = "UPDATE core_budget SET budget_type_i = ?, "
			+ "num_main_appr_i = ? "
			+ "WHERE budget_id_i = ?";
		
		PreparedStatement prep = null;
		BudgetTO oldB;
		
		try {
			oldB = Querier.selectBudgetForUpdate(old.getInstCode(), old
					.getFuncCode(), old.getEcoCode(), super.getConn());
			
			prep = super.getConn().prepareStatement(dml);

			prep.setInt(ONE, newB.getType());
			prep.setDouble(TWO, newB.getNetBudget());
			prep.setInt(THREE, newB.getNumMainAppr());
			prep.setInt(FOUR, oldB.getId());

			prep.execute();
		} catch (SQLException e) {
			prep = null;
		} finally {
			try {
				prep.close();
			} catch (SQLException e) {
				prep = null;
			}
		}
	}
	/***********************************************************************/
}

