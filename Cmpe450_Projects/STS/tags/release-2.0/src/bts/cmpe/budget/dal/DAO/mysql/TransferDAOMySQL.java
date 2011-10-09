
package bts.cmpe.budget.dal.DAO.mysql;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Enumeration;
import java.util.Vector;

import bts.cmpe.budget.dal.DAObase;
import bts.cmpe.budget.dal.Querier;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.interfaces.TransferDAO;
import bts.cmpe.budget.exception.NoSuchBudgetException;
import bts.cmpe.budget.exception.NotEnoughBudget;
import bts.cmpe.budget.transfer.BudgetTO;
import bts.cmpe.budget.transfer.TransferTO;

/**
 * @author yanis
 *
 */
public class TransferDAOMySQL extends DAObase implements TransferDAO {

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
	private static final int FIVE = 5;

	/**
	 * 
	 */
	private static final int FOUR = 4;

	/**
	 * 
	 */
	private static final int SIX = 6;

	/**
	 * @param tr 	Trnsaction parameter connects actions of DAO object 
	 * 				to a transaction chain defined by the member of 
	 * 				Transaction object of type Connection.
	 */
	public TransferDAOMySQL(final Transaction tr) {
		super(tr);
	}

	/**
	 * @param budget the object that holds the information of current department
	 * @return all the transfers to/from this department. positive number 
	 * indicates the outgoing transfer, negative number indicates incoming 
	 * transfer.
	 * @throws NoTransferMade no transfer found.
	 * @throws NoSuchBudgetException user should be informed
	 */
	public final Vector < TransferTO > getAllTransfers(final BudgetTO budget)
			throws NoSuchBudgetException {
		PreparedStatement prep = null;
		BudgetTO bt;
		
		BudgetTO from;
		BudgetTO to;
		
		Vector < TransferTO > transferVect = null;
		ResultSet rs = null;

		final String query = "(SELECT appr_trans_id_i, appr_trans_date_d,"
				+ "-appr_trans_amount_np13s2, appr_transfer_desc_v250,"
				+ "to_budget_i, from_budget_i " + "FROM CORE_BUDGET_TRANSFER "
				+ "WHERE from_budget_i = ?) " + "UNION "
				+ "(SELECT appr_trans_id_i, appr_trans_date_d, "
				+ "appr_trans_amount_np13s2, appr_transfer_desc_v250, "
				+ "to_budget_i, from_budget_i " + "FROM CORE_BUDGET_TRANSFER "
				+ "WHERE to_budget_i = ?)";

		try {
			bt = Querier.selectBudgetForUpdate(budget.getInstCode(), budget
					.getFuncCode(), budget.getEcoCode(), super.getConn());

			prep = super.getConn().prepareStatement(query);

			prep.setInt(ONE, bt.getId());
			prep.setInt(TWO, bt.getId());

			rs = prep.executeQuery();

			transferVect = new Vector();

			while (rs.next()) {
				from = Querier.getBudgetbyId(rs.getInt(rs.getInt(SIX)),
						super.getConn());
				to = Querier.getBudgetbyId(rs.getInt(rs.getInt(FIVE)),
						super.getConn());
				
				transferVect.addElement(new TransferTO(rs.getInt(ONE), rs
						.getDate(TWO), rs.getDouble(THREE), rs.getString(FOUR),
						to, from));
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

		return transferVect;
	}

	/**
	 * @param bdgt sender
	 * @param quantity positive number indicates 'from' is sending, 
	 * negative number indicates 'to' is sending 
	 * @return true if budget is available, false o/w
	 * @throws NoSuchDepartmentException if one of any departments
	 * does not exist
	 */
	public final boolean isTranferAvailable(final BudgetTO bdgt,
			final double quantity) throws NoSuchBudgetException {

		PreparedStatement prep = null;
		boolean available = true;
		ResultSet rs = null;

		final String query = "SELECT net_budget_np13s2 FROM CORE_BUDGET "
				+ "WHERE budget_id_i = ?";

		try {
			BudgetTO bt = Querier.selectBudgetForUpdate(bdgt.getInstCode(),
					bdgt.getFuncCode(), bdgt.getEcoCode(), super.getConn());

			prep = super.getConn().prepareStatement(query);

			prep.setInt(ONE, bt.getId());

			rs = prep.executeQuery();

			if (rs.next()) {
				if (rs.getDouble(1) < quantity) {
					available = false;
				} else {
					available = true;
				}
			} else {
				throw new NoSuchBudgetException(bdgt);
			}
		} catch (SQLException ex) {
			ex.getSQLState();
		} finally {
			try {
				rs.close();
				prep.close();
			} catch (Exception e) {
				rs = null;
				prep = null;
			}
		}

		return available;
	}

	/**
	 * @param to receiver
	 * @param from sender
	 * @param quantity positive number indicates 'from' is sending, 
	 * negative number indicates 'to' is sending 
	 * @param description the description of the transfer.
	 * @throws NotEnoughBudget Budget not found.
	 * @throws NoSuchDepartmentException if one of any departments
	 * does not exist.
	 */
	public final void makeTransfer(final BudgetTO to, final BudgetTO from,
			final double quantity, final String description)
			throws NoSuchBudgetException, NotEnoughBudget {
		PreparedStatement prep = null;
		BudgetTO btFrom, btTo;

		final String moveMoneyFrom = "UPDATE CORE_BUDGET "
				+ "SET net_budget_np13s2 = net_budget_np13s2 - ? "
				+ "WHERE budget_id_i = ?";
		final String moveMoneyTo = "UPDATE CORE_BUDGET "
				+ "SET net_budget_np13s2 = net_budget_np13s2 + ? "
				+ "WHERE budget_id_i = ?";
		final String recordTransfer = "INSERT INTO CORE_BUDGET_TRANSFER "
				+ "VALUES (?, ?, ?, ?, ?, ?)";

		try {
			if (isTranferAvailable(from, quantity)) {
				btFrom = Querier.selectBudgetForUpdate(from.getInstCode(), from
						.getFuncCode(), from.getEcoCode(), super.getConn());

				prep = super.getConn().prepareStatement(moveMoneyFrom);

				prep.setDouble(ONE, quantity);
				prep.setInt(TWO, btFrom.getId());

				prep.execute();

				btTo = Querier.selectBudgetForUpdate(to.getInstCode(), to
						.getFuncCode(), to.getEcoCode(), super.getConn());

				prep = super.getConn().prepareStatement(moveMoneyTo);

				prep.setDouble(ONE, quantity);
				prep.setInt(TWO, btTo.getId());

				prep.execute();

				prep = super.getConn().prepareStatement(recordTransfer);

				prep.setNull(ONE, Types.INTEGER);
				prep.setDate(TWO, new Date(System.currentTimeMillis()));
				prep.setDouble(THREE, quantity);
				prep.setString(FOUR, description);
				prep.setInt(FIVE, btTo.getId());
				prep.setInt(SIX, btFrom.getId());

				prep.execute();

			} else {
				throw new NotEnoughBudget(from);
			}
		} catch (SQLException ex) {
			ex.getErrorCode();
		} finally {
			try {
				prep.close();
			} catch (SQLException e) {
				prep = null;
			}
		}
	}

	/**
	 * @param budget Budget
	 * @return transfer balance for the department
	 * @throws NoTransferMade No transfer.
	 * @throws NoSuchDepartmentException if department does not exist
	 */
	public final double getTransferTotal(final BudgetTO budget)
			throws NoSuchBudgetException {

		Vector < TransferTO > transVect;
		double sum = 0.0;

		transVect = getAllTransfers(budget);

		Enumeration en = transVect.elements();

		while (en.hasMoreElements()) {
			sum += ((TransferTO) en.nextElement()).getQuantity();
		}

		return sum;
	}
	
	/**
	 * @param budget budgetObject
	 * @return received budget total.
	 * @throws NoSuchBudgetException Budget not found.
	 */
	public final double getReceivedTransferTotal(final BudgetTO budget) 
	throws NoSuchBudgetException {
		Vector < TransferTO > transVect;
		TransferTO trTO;
		double sum = 0.0;

		transVect = getAllTransfers(budget);

		Enumeration en = transVect.elements();

		while (en.hasMoreElements()) {
			trTO = (TransferTO) en.nextElement();
			
			if(trTO.getQuantity() > 0) {
				sum += trTO.getQuantity();
			}
		}

		return sum;
	}
	
	/**
	 * @param budget budgetObject
	 * @return send budget total.
	 * @throws NoSuchBudgetException Budget not found.
	 */
	public final double getSendTransferTotal(final BudgetTO budget) 
	throws NoSuchBudgetException {
		Vector < TransferTO > transVect;
		TransferTO trTO;
		double sum = 0.0;

		transVect = getAllTransfers(budget);

		Enumeration en = transVect.elements();

		while (en.hasMoreElements()) {
			trTO = (TransferTO) en.nextElement();
			
			if(trTO.getQuantity() < 0) {
				sum += trTO.getQuantity();
			}
		}

		return sum * -1;
	}
}
