package bts.cmpe.budget.dal.DAO.mysql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Vector;

import bts.cmpe.budget.dal.DAObase;
import bts.cmpe.budget.dal.Querier;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.dal.DAO.interfaces.ExpenseDAO;
import bts.cmpe.budget.exception.BudgetAlreadyDefined;
import bts.cmpe.budget.exception.NoSuchBudgetException;
import bts.cmpe.budget.exception.NotEnoughBudget;
import bts.cmpe.budget.exception.StdExpenseAlreadyDefined;
import bts.cmpe.budget.exception.WgrExpenseAlreadyDefined;
import bts.cmpe.budget.transfer.BudgetTO;
import bts.cmpe.budget.transfer.ExpenseBaseTO;
import bts.cmpe.budget.transfer.ExpenseStdTO;
import bts.cmpe.budget.transfer.ExpenseWgrTO;

/**
 * @author HSensoy
 *
 */
public class ExpenseDAOMySQL extends DAObase implements ExpenseDAO {

	/**
	 * 
	 */
	private static final int ZERO = 0;

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
	 * 
	 */
	private static final int EIGHT = 8;

	/**
	 * 
	 */
	private static final int NINE = 9;

	/**
	 * 
	 */
	private static final int TEN = 10;

	/**
	 * 
	 */
	private static final int ELEVEN = 11;

	/**
	 * 
	 */
	private static final int TWELVE = 12;

	/**
	 * 
	 */
	private static final int THIRTEEN = 13;

	/**
	 * 
	 */
	private static final int FOURTEEN = 14;

	/**
	 * 
	 */
	private static final int FIFTEEN = 15;

	/**
	 * 
	 */
	private static final int SIXTEEN = 16;

	/**
	 * 
	 */
	private static final int SEVENTEEN = 17;

	/**
	 * 
	 */
	private static final int EIGHTEEN = 18;

	/**
	 * 
	 */
	private static final int NINETEEN = 19;

	/**
	 * @param tr 	Transaction parameter connects actions of DAO object 
	 * 				to a transaction chain defined by the member of 
	 * 				Transaction object of type Connection.
	 */
	public ExpenseDAOMySQL(final Transaction tr) {
		super(tr);
	}

	/**
	 * @param b Budget object.
	 * @param startInv Starting inventory number.
	 * @param endInv Ending inventor number.
	 * @param sortCol Sort according to column number.
	 * @param isDesc Sort in asceding order.
	 * @return List of standard expenses.
	 * @throws NoStdExpenseFound No standard expenses found linked to budget.
	 * @throws NoSuchBudgetException No budget found with defined parameters. 
	 */
	public final Vector < ExpenseStdTO > getStdExpense(final BudgetTO b,
			final int startInv, final int endInv, final int sortCol,
			final boolean isDesc) throws 
			NoSuchBudgetException {

		PreparedStatement prep = null;
		Vector < ExpenseStdTO > expenseVect = null;
		ExpenseStdTO rec;
		ResultSet rs = null;

		String query = "SELECT exp_id_i, inventory_no_i, "
				+ "realization_amount_np13s2, towhom_v100,"
				+ "realization_id_i, realization_date_d, "
				+ "std_request_date_d, std_request_amount_np13s2, "
				+ "std_material_type_v250, std_unit_v100,"
				+ "std_eco_code_v9, stat_fk_i, " 
				+ "budget_id_i "
				+ "FROM CORE_EXPENSE " 
				+ "WHERE (inventory_no_i BETWEEN ? AND ?) AND budget_id_i = ? "
				+ "ORDER BY ?";

		if (isDesc) {
			query += " DESC";
		}

		try {
			BudgetTO bt = Querier.selectBudgetForUpdate(b.getInstCode(), b
					.getFuncCode(), b.getEcoCode(), super.getConn());

			prep = super.getConn().prepareStatement(query);

			prep.setInt(ONE, startInv);
			prep.setInt(TWO, endInv);
			prep.setInt(THREE, bt.getId());
			prep.setInt(FOUR, sortCol);

			rs = prep.executeQuery();

			expenseVect = new Vector();
			

			while (rs.next()) {
				rec = new ExpenseStdTO();
				
				rec.setId(rs.getInt(ONE));
				rec.setInventoryNo(rs.getInt(TWO));
				rec.setRealizationAmount(rs.getDouble(THREE));
				rec.setToWhom(rs.getString(FOUR));
				rec.setRealizationId(rs.getInt(FIVE));
				rec.setRealizationDate(rs.getDate(SIX));
				rec.setRequestDate(rs.getDate(SEVEN));
				rec.setRequestAmount(rs.getDouble(EIGHT));
				rec.setMaterialType(rs.getString(NINE));
				rec.setUnit(rs.getString(TEN));
				rec.setEcoCode(rs.getString(ELEVEN));
				rec.setStatus(rs.getInt(TWELVE));
				rec.setBudgetId(rs.getInt(THIRTEEN));

				expenseVect.addElement(rec);
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

		return expenseVect;
	}

	/**
	 * @param b Budget object.
	 * @param startInv Starting inventory number.
	 * @param endInv Ending inventor number.
	 * @param sortCol Sort according to column number.
	 * @param isAscending Sort in asceding order.
	 * @return List of standard expenses.
	 * @throws NoStdExpenseFound No standard expenses found linked to budget.
	 * @throws NoSuchBudgetException No budget found with defined parameters. 
	 */
	public final Vector < ExpenseWgrTO > getWgrExpense(final BudgetTO b,
			final int startInv, final int endInv, final int sortCol,
			final boolean isAscending) throws
			NoSuchBudgetException {

		PreparedStatement prep = null;
		Vector < ExpenseWgrTO > expenseVect = null;
		ExpenseWgrTO rec;
		ResultSet rs = null;

		String query = "SELECT exp_id_i, inventory_no_i, "
				+ "realization_amount_np13s2, towhom_v100,"
				+ "realization_id_i, realization_date_d, "
				+ "wgr_additional_1_np13s2, wgr_additional_2_np13s2, "
				+ "wgr_additional_3_np13s2, wgr_additional_4_np13s2, "
				+ "wgr_additional_5_np13s2, wgr_additional_6_np13s2, "
				+ "stat_fk_i, budget_id_i " 
				+ "FROM CORE_EXPENSE "
				+ "WHERE (inventory_no_i BETWEEN ? AND ?) "
				+ "AND budget_id_i = ? ORDER BY ? ";

		if (!isAscending) {
			query += "DESC";
		}

		try {
			BudgetTO bt = Querier.selectBudgetForUpdate(b.getInstCode(), b
					.getFuncCode(), b.getEcoCode(), super.getConn());

			prep = super.getConn().prepareStatement(query);

			prep.setInt(ONE, startInv);
			prep.setInt(TWO, endInv);
			prep.setInt(THREE, bt.getId());
			prep.setInt(FOUR, sortCol);

			rs = prep.executeQuery();

			expenseVect = new Vector();
			

			while (rs.next()) {
				rec = new ExpenseWgrTO();
				
				rec.setId(rs.getInt(ONE));
				rec.setInventoryNo(rs.getInt(TWO));
				rec.setRealizationAmount(rs.getDouble(THREE));
				rec.setToWhom(rs.getString(FOUR));
				rec.setRealizationId(rs.getInt(FIVE));
				rec.setRealizationDate(rs.getDate(SIX));
				rec.setAdditional(ZERO, rs.getDouble(SEVEN));
				rec.setAdditional(ONE, rs.getDouble(EIGHT));
				rec.setAdditional(TWO, rs.getDouble(NINE));
				rec.setAdditional(THREE, rs.getDouble(TEN));
				rec.setAdditional(FOUR, rs.getDouble(ELEVEN));
				rec.setAdditional(FIVE, rs.getDouble(TWELVE));
				rec.setStatus(rs.getInt(THIRTEEN));
				rec.setBudgetId(rs.getInt(FOURTEEN));

				expenseVect.addElement(rec);
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

		return expenseVect;
	}

	/**
	 * @param budget Budget Object.
	 * @param expense Expense Object.
	 * @throws NoSuchBudgetException No budget found.
	 * @throws StdExpenseAlreadyDefined Expense already defined.
	 * @throws NotEnoughBudget Not enough budget found.
	 */
	public final void addStdExpense(final BudgetTO budget,
			final ExpenseStdTO expense) throws NoSuchBudgetException,
			StdExpenseAlreadyDefined, NotEnoughBudget {

		PreparedStatement prep = null;
		BudgetTO bt;

		final String dmlBudget = "insert into CORE_EXPENSE values "
				+ "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		final String updateBudget = "UPDATE CORE_BUDGET "
				+ "SET net_budget_np13s2 = net_budget_np13s2 - ? "
				+ "WHERE budget_id_i = ?";

		try {
			bt = Querier.selectBudgetForUpdate(budget.getInstCode(), budget
					.getFuncCode(), budget.getEcoCode(), super.getConn());

			if (expense.getRealizationAmount() <= bt.getNetBudget()) {

				prep = super.getConn().prepareStatement(dmlBudget);

				prep.setNull(ONE, Types.INTEGER);
				prep.setInt(TWO, expense.getInventoryNo());
				prep.setDouble(THREE, expense.getRealizationAmount());
				prep.setString(FOUR, expense.getToWhom());
				prep.setInt(FIVE, expense.getRealizationId());
				prep.setDate(SIX, expense.getRealizationDate());
				prep.setDate(SEVEN, expense.getRequestDate());
				prep.setDouble(EIGHT, expense.getRequestAmount());
				prep.setString(NINE, expense.getMaterialType());
				prep.setString(TEN, expense.getUnit());
				prep.setString(ELEVEN, expense.getEcoCode());
				prep.setNull(TWELVE, Types.NUMERIC);
				prep.setNull(THIRTEEN, Types.NUMERIC);
				prep.setNull(FOURTEEN, Types.NUMERIC);
				prep.setNull(FIFTEEN, Types.NUMERIC);
				prep.setNull(SIXTEEN, Types.NUMERIC);
				prep.setNull(SEVENTEEN, Types.NUMERIC);
				prep.setInt(EIGHTEEN, ExpenseBaseTO.ACTIVE);
				prep.setInt(NINETEEN, bt.getId());

				prep.execute();

				prep = super.getConn().prepareStatement(updateBudget);

				prep.setDouble(ONE, expense.getRealizationAmount());
				prep.setInt(TWO, bt.getId());

				prep.execute();

			} else {
				throw new NotEnoughBudget(budget);
			}
		} catch (SQLException ex) {
			if (ex.getErrorCode() == BudgetAlreadyDefined.ERR_CODE) {
				throw new StdExpenseAlreadyDefined(budget);
			}
		} finally {
			try {
				prep.close();
			} catch (Exception e) {
				prep = null;
			}
		}
	}

	/**
	 * @param budget Budget object.
	 * @param expense Expense object.
	 * @throws NoSuchBudgetException No exception defined.
	 * @throws WgrExpenseAlreadyDefined No wager expense defined.
	 * @throws NotEnoughBudget Not eanough budget for transfer.
	 */
	public final void addWgrExpense(final BudgetTO budget,
			final ExpenseWgrTO expense) throws NoSuchBudgetException,
			WgrExpenseAlreadyDefined, NotEnoughBudget {

		PreparedStatement prep = null;
		BudgetTO bt;

		final String dmlBudget = "insert into CORE_EXPENSE values "
				+ "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		final String updateBudget = "UPDATE CORE_BUDGET "
				+ "SET net_budget_np13s2 = net_budget_np13s2 - ? "
				+ "WHERE budget_id_i = ?";

		try {

			bt = Querier.selectBudgetForUpdate(budget.getInstCode(), budget
					.getFuncCode(), budget.getEcoCode(), super.getConn());

			if (expense.getRealizationAmount() <= bt.getNetBudget()) {
				prep = super.getConn().prepareStatement(dmlBudget);

				prep.setNull(ONE, Types.INTEGER);
				prep.setInt(TWO, expense.getInventoryNo());
				prep.setDouble(THREE, expense.getRealizationAmount());
				prep.setString(FOUR, expense.getToWhom());
				prep.setInt(FIVE, expense.getRealizationId());
				prep.setDate(SIX, expense.getRealizationDate());

				prep.setNull(SEVEN, Types.DATE);
				prep.setNull(EIGHT, Types.NUMERIC);
				prep.setNull(NINE, Types.VARCHAR);
				prep.setNull(TEN, Types.VARCHAR);
				prep.setNull(ELEVEN, Types.VARCHAR);

				prep.setDouble(TWELVE, expense.getAdditional(ZERO));
				prep.setDouble(THIRTEEN, expense.getAdditional(ONE));
				prep.setDouble(FOURTEEN, expense.getAdditional(TWO));
				prep.setDouble(FIFTEEN, expense.getAdditional(THREE));
				prep.setDouble(SIXTEEN, expense.getAdditional(FOUR));
				prep.setDouble(SEVENTEEN, expense.getAdditional(FIVE));
				prep.setInt(EIGHTEEN, ExpenseBaseTO.ACTIVE);
				prep.setInt(NINETEEN, bt.getId());

				prep.execute();

				prep = super.getConn().prepareStatement(updateBudget);

				prep.setDouble(ONE, expense.getRealizationAmount());
				prep.setInt(TWO, bt.getId());

				prep.execute();
			} else {
				throw new NotEnoughBudget(budget);
			}
		} catch (SQLException ex) {
			if (ex.getErrorCode() == BudgetAlreadyDefined.ERR_CODE) {
				throw new WgrExpenseAlreadyDefined(budget);
			}
		} finally {
			try {
				prep.close();
			} catch (Exception e) {
				prep = null;
			}
		}
	}

	/**
	 * @param budget Budget obj.
	 * @param inventoryNo Defter Sira No
	 * @throws NoSuchBudgetException Budget not found.
	 * @throws NoExpenseFound Expense not found.
	 */
	public final void deleteExpenditure(final BudgetTO budget,
			final int inventoryNo) 
	throws NoSuchBudgetException {

		PreparedStatement prep = null;
		BudgetTO bt;
		ExpenseBaseTO exp = null;

		final String dmlBudget = "UPDATE CORE_EXPENSE SET stat_fk_i = ? "
				+ "WHERE budget_id_i = ? AND inventory_no_i = ?";

		final String updateBudget = "UPDATE CORE_BUDGET "
				+ "SET net_budget_np13s2 = net_budget_np13s2 + ? "
				+ "WHERE budget_id_i = ?";

		try {
			bt = Querier.selectBudgetForUpdate(budget.getInstCode(), budget
					.getFuncCode(), budget.getEcoCode(), super.getConn());

			prep = super.getConn().prepareStatement(dmlBudget);

			prep.setInt(ONE, ExpenseStdTO.DELETED);
			prep.setInt(TWO, bt.getId());
			prep.setInt(THREE, inventoryNo);

			prep.execute();

			exp = Querier.selectExpenseForUpdate(bt.getId(), inventoryNo, super
					.getConn());

			prep = super.getConn().prepareStatement(updateBudget);
			prep.setDouble(ONE, exp.getRealizationAmount());
			prep.setInt(TWO, bt.getId());

			prep.execute();

		} catch (SQLException ex) {
			prep = null;
		} finally {
			try {
				prep.close();
			} catch (Exception e) {
				prep = null;
			}
		}
	}

	/**
	 * @param bgt department.
	 * @return total expenditure done by this department
	 * @throws NoExpenseFound No expense found.
	 * @throws NoSuchDepartmentException if department doese not exist
	 */
	public final double getTotalExpenditure(final BudgetTO bgt)
			throws NoSuchBudgetException {

		PreparedStatement prep = null;
		ResultSet rs = null;

		double sum = 0.0;

		final String query = "SELECT SUM(realization_amount_np13s2) "
				+ "FROM CORE_EXPENSE "
				+ "WHERE stat_fk_i = 1 AND budget_id_i = ?";

		try {
			BudgetTO bt = Querier.selectBudgetForUpdate(bgt.getInstCode(), bgt
					.getFuncCode(), bgt.getEcoCode(), super.getConn());

			prep = super.getConn().prepareStatement(query);

			prep.setInt(ONE, bt.getId());

			rs = prep.executeQuery();

			if (rs.next()) {
				sum = rs.getDouble(1);
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

		return sum;
	}
}
