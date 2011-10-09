package sts.stockFollowUp;

import global.DB;

import com.mysql.jdbc.ResultSet;

/**Stock Approval class is a part of the package StockFollowUp. There are two
 *methods in this class which are view pending and approve. The first method
 *is view pending. It displays the list of the items that are not approved, yet.
 *These are the items that are kept in pending items table of the database.
 *This method takes no input parameter. The second method is approve.
 *This method takes StockID as the parameter and removes the corresponding
 *item from the pending items table and adds it to the main table
 * */
public class StockApproval {
	/**@
	 * Tum pending durumunda olan ürünlerin resultsetýný donderiyor
	 * datalarý BEKLEYEN_URUNLER  tablosundan alýyor
	 * @return A ResultSet data type.
	 */
	public final ResultSet listPendingItems() {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP(
					"ListPendingItems_sp").getResult();
			db.closeConnection();
			return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} // listPendingItems Sonu

	/**@
	 * Onay durumunda(ürününün gelmesi ve onay)
	 * stockID li ürünü pending tablosundan çikarip
	 * ana tabloya koyacak
	 * @param stockID int
	 * @param faturaNo String
	 * @param urunNo String
	 * @param talepEdenBirim String
	 * @return A boolean data type.
	 */
	public final boolean setPendingToStock(
			final int stockID, final String faturaNo,
			final String urunNo, final String talepEdenBirim) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("Set_PendingToStock_sp",
					new Object [] {stockID, faturaNo, urunNo, talepEdenBirim});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	} // setPendingToStock Sonu

	/**@
	 * This method inserts removed items into the
	 * GENEL_DEPO_CIKIS table according to the given parameters.
	 * It also sets date as the current date.
	 * @param depName String.
	 * @param urunAdi String.
	 * @param amount int.
	 * @param birimFiyat float.
	 * @param rafNo String.
	 * @return A Boolean data type.
	 */
	/*public final boolean depoCikisGDC(
final String depName, final String urunAdi,
final int amount, final float birimFiyat, final String rafNo) {
try {
DB db = new DB(true);
db.beginTransaction();
db.executeSP("DepoCikisGDC_sp",
new Object [] {depName, urunAdi, amount, birimFiyat, rafNo});
db.commitTransaction();
db.closeConnection();
return true;
} catch (Exception e) {
e.printStackTrace();
return false;
} //end depoCikisGDC
}
	 */
	/**@
	 * This method inserts removed items into the
	 * GENEL_DEPO_CIKIS table according to the given parameters.
	 * It also sets date as the current date.
	 * @param urunNo String.
	 * @param amount int.
	 * @param rafNo String.
	 * @param aciklama String.
	 * @return A Boolean data type.
	 */
	public final boolean depoCikisGDC(
			final String urunNo,
			final int amount,
			final String rafNo, final String aciklama) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("DepoCikisGDC_sp",
					new Object [] {urunNo, 
					amount, rafNo, aciklama});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} 
	} //end depoCikisGDC
		/**@
		 * This method inserts removed items into the
		 * GENEL_DEPO_CIKIS table according to the given parameters.
		 * It also sets date as the current date.
		 * @param urunNo String.
		 * @param amount int.
		 * @param rafNo String.
		 * @param aciklama String.
		 * @param grupNo String
		 * @return A Boolean data type.
		 */
		public final boolean depoCikisGDCtoBDG(
				final String grupNo,
				final String urunNo, final int amount,
				final String rafNo, final String aciklama) {
			try {
				DB db = new DB(true);
				db.beginTransaction();
				db.executeSP("DepoCikisGDCtoBDG_sp",
						new Object [] {grupNo, 
						urunNo, amount, rafNo, aciklama});
				db.commitTransaction();
				db.closeConnection();
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			} 
		} //end depoCikisGDCtoBDG
	/**@
	 * This method inserts necessary data into BIRIM_DEPO_CIKIS table
	 * @param depNo String.
	 * @param urunNo String.
	 * @param amount int.
	 * @param aciklama String.
	 * @return A Boolean data type.
	 */
	public final boolean depoCikisDDC(
			final String depNo,
			final String urunNo, final int amount,
			final String aciklama) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("DepoCikisDDC_sp",
			new Object [] { depNo, urunNo, amount, aciklama});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} //end depoCikisDDC
	}
	/**@
	 * This method inserts necessary data into BIRIM_DEPO_CIKIS table
	 * @param depNo String.
	 * @param urunNo String.
	 * @param amount int.
	 * @param aciklama String.
	 * @return A Boolean data type.
	 */
	public final boolean depoGirisDDC(
			final String depNo,
			final String urunNo, final int amount,
			final String aciklama) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("DepoGirisDDC_sp",
			new Object [] {depNo, urunNo, amount, aciklama});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} //end depoCikisDDC
	}
} //class sonu
