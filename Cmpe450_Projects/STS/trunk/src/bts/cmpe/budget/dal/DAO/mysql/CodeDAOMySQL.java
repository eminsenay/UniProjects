package bts.cmpe.budget.dal.DAO.mysql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import bts.cmpe.budget.dal.DAObase;
import bts.cmpe.budget.dal.Transaction;
import bts.cmpe.budget.transfer.CodeTO;

/**
 * @author Memil
 * 
 */
public class CodeDAOMySQL extends DAObase {

	/**
	 * @param tr Transaction
	 */
	public CodeDAOMySQL(final Transaction tr) {
		super(tr);
	}

	/**
	 * @return InstitutionalCode Vector
	 * @throws SQLException DB Exception
	 */
	@SuppressWarnings("unchecked")
	public final Vector < CodeTO > getInstCodes() throws SQLException {

		ResultSet rs;

		final String query = "select Aciklama,"
				+ "KurumsalKod from KURUMSAL where statu = '1'";
		
		Vector codeVect = new Vector();

		PreparedStatement prep;

		prep = super.getConn().prepareStatement(query);

		rs = prep.executeQuery();

		while (rs.next()) {
			codeVect.add(new CodeTO(rs.getString("Aciklama"), rs
					.getString("KurumsalKod"), CodeTO.INST));
		}
		
		return codeVect;
	}

	/**
	 * @return EconomyCode Vector
	 * @throws SQLException Exception
	 */
	@SuppressWarnings("unchecked")
	public final Vector < CodeTO > getEcoCodes() throws SQLException {
		ResultSet rs;

		final String query = "select AnaKalemAdi, "
				+ "AnaKalemKodu from ANA_KALEM where statu = '1'";
		
		Vector codeVect = new Vector();

		PreparedStatement prep;

		prep = super.getConn().prepareStatement(query);

		rs = prep.executeQuery();

		while (rs.next()) {
			codeVect.add(new CodeTO(rs.getString("AnaKalemAdi"), rs
					.getString("AnaKalemKodu"), CodeTO.ECO));
		}
		
		return codeVect;
	}

	/**
	 * @return FuncCode Vector
	 * @throws SQLException SQLExcetion
	 */
	@SuppressWarnings("unchecked")
	public final  Vector < CodeTO > getFuncCodes() throws SQLException {
		ResultSet rs;

		final String query = "select FonksiyonelAdi,"
				+ "FonksiyonelKodu from FONKSIYONEL where statu = '1'";
		
		Vector codeVect = new Vector();

		PreparedStatement prep;

		prep = super.getConn().prepareStatement(query);

		rs = prep.executeQuery();

		while (rs.next()) {
			codeVect.add(new CodeTO(rs.getString("FonksiyonelAdi"), rs
					.getString("FonksiyonelKodu"), CodeTO.FUNC));
		}
		
		return codeVect;
	}
}
