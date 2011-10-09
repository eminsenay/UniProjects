package bts.cmpe.budget.dal.DAO.mysql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import bts.cmpe.budget.dal.DAObase;
import bts.cmpe.budget.dal.Querier;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.interfaces.AppropriationDAO;
import bts.cmpe.budget.exception.MoreApprThanExpected;
import bts.cmpe.budget.exception.NoAdditionalApprDefined;
import bts.cmpe.budget.exception.NoApprDefined;
import bts.cmpe.budget.exception.NoPeriodicApprDefined;
import bts.cmpe.budget.exception.NoSuchBudgetException;
import bts.cmpe.budget.transfer.AppropriationTO;
import bts.cmpe.budget.transfer.BudgetTO;

/**
 * @author DAIciler
 * 
 */
public class AppropriationDAOMySQL extends DAObase implements AppropriationDAO {
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
	 * @param tr
	 *            Transaction parameter connects actions of DAO object to a
	 *            transaction chain defined by the member of Transaction object
	 *            of type Connection.
	 */
	public AppropriationDAOMySQL(final Transaction tr) {
		super(tr);
	}

	/**
	 * @param budget Budget transfer object.
	 * @return Appropriation period
	 * @throws NoSuchBudgetException Budget not found.
	 */
	public final int getPeriod(final BudgetTO budget)
			throws NoSuchBudgetException {
		BudgetTO bt = null;

		try {
			bt = Querier.selectBudgetForUpdate(budget.getInstCode(), budget
					.getFuncCode(), budget.getEcoCode(), super.getConn());
		} catch (SQLException e) {
			bt = null;
		}

		return bt.getNumMainAppr();
	}
	
	/**
	 * @param budget Budget to which appr will be added.
	 * @param appr Appropriation object instance
	 * @throws NoSuchBudgetException Budgetnotfound.
	 * @throws MoreApprThanExpected More
	 */
	public final void insertMainAppropriation(final BudgetTO budget, 
			final AppropriationTO appr)
			throws NoSuchBudgetException, MoreApprThanExpected {
		PreparedStatement prep = null;
		BudgetTO bt;
		ResultSet rs = null;

		int numTotalAppr = 0;

		final String dml = "INSERT INTO CORE_APPROPRIATION	"
				+ "VALUES(?, ?, ?, ?, ?, ?)";
		
		final String query = "SELECT COUNT(*) "
				+ "FROM CORE_APPROPRIATION "
				+ "WHERE budget_id_i = ? and appr_type_fk_i in (3,6) "
						+ "FOR UPDATE";
		
		final String update = "UPDATE CORE_BUDGET "
				+ "SET net_budget_np13s2 = net_budget_np13s2 + ? "
				+ "WHERE budget_id_i = ?";
		
		try {
			bt = Querier.selectBudgetForUpdate(budget.getInstCode(),
					budget.getFuncCode(), budget.getEcoCode(), super.getConn());
			
			prep = super.getConn().prepareStatement(query);
			
			prep.setInt(ONE, bt.getId());
			
			rs = prep.executeQuery();
			

			if (rs.next()) {
				numTotalAppr = rs.getInt(1);
				
			}
			
			prep.close();
			rs.close();

			if (numTotalAppr >= bt.getNumMainAppr()) {
				throw new MoreApprThanExpected(bt);
			} else {
				prep = super.getConn().prepareStatement(dml);
				
				prep.setString(ONE, null);
				prep.setInt(TWO, appr.getIndex());
				prep.setDouble(THREE, appr.getAmount());
				prep.setDate(FOUR, appr.getDate());
				prep.setInt(FIVE, appr.getType());
				prep.setInt(SIX, bt.getId());

				prep.execute();
				prep.close();
				
				prep = super.getConn().prepareStatement(update);
				
				prep.setDouble(ONE, appr.getAmount());
				prep.setInt(TWO, bt.getId());
				
				prep.execute();
			}
		} catch (SQLException e) {
			//TODO All SQLExceptions has to be logged using LOG4J
			e.getSQLState();
		} finally {
			try {
				prep.close();
				rs.close();
			} catch (SQLException e) {
				prep = null;
				rs = null;
			}
		}
	}
	
	/**
	 * @param budget Budget to which appr will be added.
	 * @param appr Appropriation object instance
	 * @throws NoSuchBudgetException Budget not found.
	 */
	public void insertAddAppropriation(final BudgetTO budget, 
			final AppropriationTO appr) 
	throws NoSuchBudgetException {
		// TODO Auto-generated method stub	
	}

	/**
	 * @param budget Budget transfer object.
	 * @return Vector of all appropriations
	 * @throws NoSuchBudgetException Budget not found.
	 * @throws NoApprDefined Appr not found.
	 */
	public final Vector < AppropriationTO > 
	getAllAppropriations(final BudgetTO budget)
			throws NoSuchBudgetException, NoApprDefined {
		BudgetTO bt;
		Vector < AppropriationTO > apprVect = null;

		try {
			bt = Querier.selectBudgetForUpdate(budget.getInstCode(), budget
					.getFuncCode(), budget.getEcoCode(), super.getConn());
			
			apprVect = Querier.selectAppropriationForUpdate(bt.getId(), super
					.getConn());
		} catch (SQLException e) {
			bt = null;
		}

		return apprVect;
	}


	/**
	 * TODO To be discussed.
	 * 
	 * @param apprOld a
	 * @param apprNew b
	 * @throws NoApprDefined c
	 * @throws SQLException d
	 */
	public final void updateAppropriation(final AppropriationTO apprOld,
			final AppropriationTO apprNew) throws NoApprDefined, SQLException {
	}

	/**
	 * @param budget Budget to be queried.
	 * @return Sum(main_appr)
	 * @throws NoSuchBudgetException Budget not found.
	 * @throws NoPeriodicApprDefined Appr of the following type can't be found.
	 */
	public final double getPeriodicAppropriationTotal(final BudgetTO budget)
			throws NoSuchBudgetException, NoPeriodicApprDefined {

		PreparedStatement prep = null;
		double quantity = 0.0;

		final String query = "SELECT SUM(appr_amount_np13s2) "
				+ "FROM CORE_APPROPRIATION "
				+ "WHERE budget_id_i = ? and appr_type_fk_i IN (3,6)";

		BudgetTO bt;
		try {
			bt = Querier.selectBudgetForUpdate(budget.getInstCode(),
					budget.getFuncCode(), budget.getEcoCode(), super.getConn());
			
			prep = super.getConn().prepareStatement(query);

			prep.setInt(1, bt.getId());

			ResultSet rs = prep.executeQuery();

			if (rs.next()) {
				quantity = rs.getInt(1);
			} else {
				throw new NoPeriodicApprDefined(bt);
			}
		} catch (SQLException e) {
			bt = null;
		}
		return quantity;
	}


	/**
	 * @param budget Budget to be queried.
	 * @return Sum(main_appr)
	 * @throws NoSuchBudgetException Budget not found.
	 * @throws NoAdditionalApprDefined Appr of the 
	 * following type can't be found.
	 */
	public final double getAdditionalAppropriationTotal(final BudgetTO budget)
			throws NoSuchBudgetException, NoAdditionalApprDefined {

		PreparedStatement prep = null;
		double quantity = 0.0;

		final String query = "SELECT SUM(appr_amount_np13s2) "
				+ "FROM CORE_APPROPRIATION "
				+ "WHERE budget_id_i = ? and appr_type_fk_i = 1";

		BudgetTO bt;
		try {
			bt = Querier.selectBudgetForUpdate(budget.getInstCode(),
					budget.getFuncCode(), budget.getEcoCode(), super.getConn());
			
			prep = super.getConn().prepareStatement(query);

			prep.setInt(1, bt.getId());

			ResultSet rs = prep.executeQuery();

			if (rs.next()) {
				quantity = rs.getInt(1);
			} else {
				throw new NoAdditionalApprDefined(bt);
			}
		} catch (SQLException e) {
			bt = null;
		}

		return quantity;
	}
}
