package bts.cmpe.budget.dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import bts.cmpe.budget.exception.NoApprDefined;
import bts.cmpe.budget.exception.NoSuchBudgetException;
import bts.cmpe.budget.transfer.AppropriationTO;
import bts.cmpe.budget.transfer.BudgetTO;
import bts.cmpe.budget.transfer.ExpenseBaseTO;
import bts.cmpe.budget.transfer.ExpenseStdTO;

/**
 * @author HSensoy
 * 
 */
public final class Querier {
	/**
	 * 
	 */
	static final int PARAM_ONE = 1;

	/**
	 * 
	 */
	static final int PARAM_TWO = 2;

	/**
	 * 
	 */
	static final int PARAM_THREE = 3;

	/**
	 * 
	 */
	static final int PARAM_FOUR = 4;

	/**
	 * 
	 */
	static final int PARAM_FIVE = 5;

	/**
	 * 
	 */
	static final int PARAM_SIX = 6;

	/**
	 * 
	 */
	static final int PARAM_SEVEN = 7;

	/**
	 * 
	 */
	static final int PARAM_EIGHT = 8;

	/**
	 * 
	 */
	static final int PARAM_NINE = 9;

	/**
	 * 
	 */
	static final int PARAM_TEN = 10;

	/**
	 * 
	 */
	static final int PARAM_ELEVEN = 11;

	/**
	 * 
	 */
	static final int PARAM_TWELVE = 12;

	/**
	 * 
	 */
	static final int PARAM_THIRTEEN = 13;

	/**
	 * 
	 */
	private Querier() {
	}

	/**
	 * @param inst Institutional Code
	 * @param func Functional Code
	 * @param eco Economy Code
	 * @param conn Connection obj
	 * @return Budget instance defined by instCode, funcCode, ecoCode
	 * @throws SQLException	DB related exceptions
	 * @throws NoSuchBudgetException In case that no matching budget exists 
	 *in database.
	 */
	public static BudgetTO selectBudgetForUpdate(final String inst,
			final String func, final String eco, final Connection conn)
			throws SQLException, NoSuchBudgetException {

		final String query = "SELECT budget_id_i, budget_type_i, "
				+ "net_budget_np13s2, num_main_appr_i, "
				+ "inst_code_v11, func_code_v9, eco_code_v4 "
				+ "FROM CORE_BUDGET WHERE inst_code_v11 = ? and "
				+ "func_code_v9 = ? and eco_code_v4 = ? FOR UPDATE";

		PreparedStatement prep;
		ResultSet rs;
		BudgetTO bt = null;

		prep = conn.prepareStatement(query);

		prep.setString(PARAM_ONE, inst);
		prep.setString(PARAM_TWO, func);
		prep.setString(PARAM_THREE, eco);

		rs = prep.executeQuery();

		if (rs.next()) {
			bt = new BudgetTO(rs.getInt(PARAM_ONE), rs.getInt(PARAM_TWO), rs
					.getDouble(PARAM_THREE), rs.getInt(PARAM_FOUR), rs
					.getString(PARAM_FIVE), rs.getString(PARAM_SIX), rs
					.getString(PARAM_SEVEN));
		} else {
			throw new NoSuchBudgetException(new BudgetTO(inst, func, eco));
		}

		return bt;
	}

	/**
	 * @param budgetId Primary key of a row in core_budget table.
	 * @param conn Connection obj
	 * @return Vector of appropriations given to a budget.
	 * @throws SQLException	DB related exceptions
	 * @throws NoApprDefined In case that no appropriation exists for the budget
	 */
	@SuppressWarnings("unchecked")
	public static Vector < AppropriationTO > selectAppropriationForUpdate(
			final int budgetId, final Connection conn) throws SQLException,
			NoApprDefined {

		final String query = "SELECT appr_id_i, appr_index_i, "
				+ "appr_amount_np13s2, appr_date_d, "
				+ "appr_type_fk_i, budget_id_i " + "FROM CORE_APPROPRIATION "
				+ "WHERE budget_id_i = ? FOR UPDATE";

		PreparedStatement prep;
		ResultSet rs;
		Vector < AppropriationTO > apprVect = new Vector();

		prep = conn.prepareStatement(query);

		prep.setInt(PARAM_ONE, budgetId);

		rs = prep.executeQuery();

		while (rs.next()) {
			apprVect.add(new AppropriationTO(rs.getInt(PARAM_ONE), rs
					.getInt(PARAM_TWO), rs.getDouble(PARAM_THREE), rs
					.getDate(PARAM_FOUR), rs.getInt(PARAM_FIVE), rs
					.getInt(PARAM_SIX)));
		}

		if (apprVect.size() == 0) {
			throw new NoApprDefined(new BudgetTO(budgetId, 0, 0.0, 0, null,
					null, null));
		}

		return apprVect;
	}

	/**
	 * @param budgetId Primary key of a row being a 
	 * std expense budget in core_budget table.
	 * @param conn Connection obj
	 * @return Vector of standards expenses made from a budget.
	 * @throws SQLException	DB related exceptions
	 */
	@SuppressWarnings("unchecked")
	public static Vector < ExpenseStdTO > selectStdExpenseForUpdate(
			final int budgetId, final Connection conn) throws SQLException {

		final String query = "SELECT exp_id_i, inventory_no_i, "
				+ "realization_amount_np13s2, towhom_v100, "
				+ "realization_id_i, realization_date_d, "
				+ "std_request_date_d, std_request_amount_np13s2, "
				+ "std_material_type_v250, std_unit_v100, "
				+ "std_eco_code_v9, stat_fk_i, budget_id_i "
				+ "FROM CORE_EXPENSE " + "WHERE budget_id_i = ? FOR UPDATE";

		PreparedStatement prep;
		ResultSet rs;
		Vector < ExpenseStdTO > expenseVect = new Vector();

		prep = conn.prepareStatement(query);

		prep.setInt(PARAM_ONE, budgetId);

		rs = prep.executeQuery();

		ExpenseStdTO stdExp = new ExpenseStdTO();

		while (rs.next()) {
			stdExp.setId(rs.getInt(PARAM_ONE));
			stdExp.setInventoryNo(rs.getInt(PARAM_TWO));
			stdExp.setRealizationAmount(rs.getDouble(PARAM_THREE));
			stdExp.setToWhom(rs.getString(PARAM_FOUR));
			stdExp.setRealizationId(rs.getInt(PARAM_FIVE));
			stdExp.setRealizationDate(rs.getDate(PARAM_SIX));
			stdExp.setRequestDate(rs.getDate(PARAM_SEVEN));
			stdExp.setRequestAmount(rs.getDouble(PARAM_EIGHT));
			stdExp.setMaterialType(rs.getString(PARAM_NINE));
			stdExp.setUnit(rs.getString(PARAM_TEN));
			stdExp.setEcoCode(rs.getString(PARAM_ELEVEN));
			stdExp.setStatus(rs.getInt(PARAM_TWELVE));
			stdExp.setBudgetId(rs.getInt(PARAM_THIRTEEN));

			expenseVect.add(stdExp);
		}

		return expenseVect;
	}

	/**
	 * @param id Budget ID.
	 * @param inventoryNo Defter Sira no.
	 * @param conn Connection obj.
	 * @return Base Expense Object.
	 * @throws SQLException Database Exception.
	 */
	public static ExpenseBaseTO selectExpenseForUpdate(final int id,
			final int inventoryNo, final Connection conn) throws SQLException {

		final String query = "SELECT inventory_no_i,"
				+ "realization_amount_np13s2,towhom_v100,"
				+ "realization_id_i,realization_date_d,"
				+ "stat_fk_i,budget_id_i	" + "FROM CORE_EXPENSE "
				+ "WHERE inventory_no_i = ? AND budget_id_i = ? FOR UPDATE";

		PreparedStatement prep;
		ResultSet rs;
		ExpenseBaseTO exp = new ExpenseBaseTO();

		prep = conn.prepareStatement(query);

		prep.setInt(PARAM_ONE, inventoryNo);
		prep.setInt(PARAM_TWO, id);

		rs = prep.executeQuery();

		if (rs.next()) {
			exp.setInventoryNo(rs.getInt(PARAM_ONE));
			exp.setRealizationAmount(rs.getDouble(PARAM_TWO));
			exp.setToWhom(rs.getString(PARAM_THREE));
			exp.setRealizationId(rs.getInt(PARAM_FOUR));
			exp.setRealizationDate(rs.getDate(PARAM_FIVE));
			exp.setStatus(rs.getInt(PARAM_SIX));
			exp.setBudgetId(rs.getInt(PARAM_SEVEN));
		}

		return exp;
	}

	/**
	 * @param budgetId primary key for budget.
	 * @param conn connection object.
	 * @return BudgetTO object.
	 * @throws NoSuchBudgetException no budget found. 
	 * @throws SQLException DB Exception.
	 */
	public static BudgetTO getBudgetbyId(final int budgetId,
			final Connection conn) throws NoSuchBudgetException, SQLException {
		final String query = "SELECT budget_id_i, budget_type_i, "
				+ "net_budget_np13s2, num_main_appr_i, "
				+ "inst_code_v11, func_code_v9, eco_code_v4 "
				+ "FROM CORE_BUDGET WHERE budget_id_i = ?";

		PreparedStatement prep;
		ResultSet rs;
		BudgetTO bt = null;

		prep = conn.prepareStatement(query);

		prep.setInt(PARAM_ONE, budgetId);

		rs = prep.executeQuery();

		if (rs.next()) {
			bt = new BudgetTO(rs.getInt(PARAM_ONE), rs.getInt(PARAM_TWO), rs
					.getDouble(PARAM_THREE), rs.getInt(PARAM_FOUR), rs
					.getString(PARAM_FIVE), rs.getString(PARAM_SIX), rs
					.getString(PARAM_SEVEN));
		} else {
			throw new NoSuchBudgetException(new BudgetTO(budgetId));
		}

		return bt;
	}

}
