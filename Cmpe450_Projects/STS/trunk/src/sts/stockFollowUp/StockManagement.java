package sts.stockFollowUp;
import global.DB;
import java.util.ArrayList;
import com.mysql.jdbc.ResultSet;
/**Stock Management Class is for managing the current stock data in our
 *system. The methods belonging to this class are used for viewing the infor-
 *mation of the items in stock, removing items from the stock (e.g when we use
 *paper for photocopying, these must be removed from the stock), and setting
 *limits for the minimum amount that an item must be existent in the stock.
 * */
public class StockManagement {
	/**@
	 * tum urunlerin listesini bir string arrayinde donderiyor
	 * stockID li �r�n� pending tablosundan �ikarip
	 * ana tabloya koyacak
	 * @return A ArrayList data type.
	 */
	public final ArrayList getUrunNames() {
		DB db = new DB(true);
		try {
			ResultSet rs = (ResultSet) db.executeSP(
					"GetAllUrunAdi_sp").getResult();
			ArrayList arrList = new ArrayList();
			while (rs.next()) {
				arrList.add(rs.getString("UrunAdi"));
			}
			db.closeConnection();
			return arrList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} //getUrunNames Sonu

	/**@
	 * tum departmanlarin listesini bir string arrayinde donderiyor.
	 * @return A ArrayList data type.
	 */
	public final ArrayList getDepNames() {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP(
					"GetAllBirimAdi_sp").getResult();
			ArrayList arrList = new ArrayList();
			while (rs.next()) {
				arrList.add(rs.getString("BirimAdi"));
			}
			db.closeConnection();
			return arrList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} //getDepNames sonu
	
	/**@
	 * tum departmanlarin grup numaralarini ve isimlerini 
	 * bir string arrayinde donduruyor.
	 * @return A ArrayList data type.
	 */
	public final ArrayList getGroupNoAndGroupNames() {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP(
					"GetAllGrupNoVeGrupAdi_sp").getResult();
			ArrayList arrList = new ArrayList();
			while (rs.next()) {
				arrList.add(rs.getString("GrupNo"));
				arrList.add(rs.getString("GrupAdi"));
			}
			db.closeConnection();
			return arrList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} //getGroupNoAndDepNames sonu
	
	
	
	/**@
	 * tum departmanlarin grup numaralarini ve isimlerini 
	 * bir string arrayinde donduruyor.
	 * @return A ArrayList data type.
	 */
	public final ArrayList getGroupNoAndDepNames() {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP(
					"GetAllGrupNoVeBirimAdi_sp").getResult();
			ArrayList arrList = new ArrayList();
			while (rs.next()) {
				arrList.add(rs.getString("GrupNo"));
				arrList.add(rs.getString("BirimAdi"));
			}
			db.closeConnection();
			return arrList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} //getGroupNoAndDepNames sonu
	/**@
	 * dekanin altindaki tum departmanlarin 
	 * listesini bir string arrayinde donderiyor.
	 * @param grupNo String.
	 * @return A ArrayList data type.
	 */
	public final ArrayList getDepForDekan(final String grupNo) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP(
					"GetDepForDekan_sp", new Object [] {grupNo}).getResult(); 
			ArrayList arrList = new ArrayList();
			while (rs.next()) {
				arrList.add(rs.getString("GrupAdi"));
				arrList.add(rs.getString("GrupNo"));
			}
			db.closeConnection();
			return arrList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} //getDepNamesForDekan sonu
	/**@
	 * This method returns resultset
	 * @return A ResultSet data type.
	 */
	public final ResultSet getDepartments() {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP(
					"GetDepartments_sp").getResult();
			db.closeConnection();
			return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**@
	 * This method returns resultset
	 * @return A ResultSet data type.
	 */
	public final ResultSet getUnits() {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP("GetUnits_sp").getResult();
			db.closeConnection();
			return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**@
	 * birimler i�in alt limit atar
	 * @param depNo String.
	 * @param itemNo String.
	 * @param limit int.
	 * @return A ArrayList data type.
	 */
	public final boolean addADLimit(final String depNo,
			final String itemNo, final int limit) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("SetAdLimit_sp",
					new Object [] {depNo, itemNo, limit});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	} //addADLimit Sonu

	
	/**@
	 * Herhangi bir birimin altlimitini d�nderiyor
	 * @param depNO String.
	 * @param itemNO String.
	 * @return A ArrayList data type.
	 */
	public final int getADLimit(final String depNO, final String itemNO) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP("GetAdLimit_sp",
					new Object[]{depNO, itemNO}).getResult();
			int altLimit;
			if (rs.next()) {
				altLimit = rs.getInt("AltLimit");
				db.closeConnection();
				return altLimit;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	} //getADLimit sonu
	/**@
	 * Genel Depo i�in alt limit atar
	 * @param limit int.
	 * @param itemNo String.
	 * @return A ArrayList data type.
	 */
	public final boolean addGDLimit(final String itemNo, final int limit) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("SetGdLimit_sp", new Object [] {itemNo, limit});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	} //addGDLimit Sonu

	/**@
	 * Genel depodan herhangi �r�n i�in altlimitini d�nderiyor
	 * @param itemCode String.
	 * @return A ArrayList data type.
	 */
	public final int getGDLimit(final String itemCode) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP("GetGdLimit_sp",
					new Object[]{itemCode}).getResult();
			int altLimit;
			if (rs.next()) {
				altLimit = rs.getInt("AltLimit");
				db.closeConnection();
				return altLimit;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	} //getGDLimit sonu

	/**@
	 * �r�n�n nosunu d�nderir
	 * @param itemName String.
	 * @return A ArrayList data type.
	 */
	public final String getUrunNo(final String itemName) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP("GetUrunNo_sp",
new Object[]{itemName}).getResult();
			
			String urunNo;
			if (rs.next()) {
				urunNo = rs.getString("UrunNo");
				db.closeConnection();
				return urunNo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} //getUrunNo sonu

	/**@
	 * �r�n�n adini d�nderir
	 * @param itemNo String.
	 * @return A String.
	 */
	public final String getUrunAdi(final String itemNo) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP("GetUrunName_sp",
					new Object[]{itemNo}).getResult();
			String urunAdi;
			if (rs.next()) {
				urunAdi = rs.getString("UrunAdi");
				db.closeConnection();
				return urunAdi;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} //getUrunAdi sonu

	/**@
	 * Birimin  nosunu d�nderir
	 * @param depName String.
	 * @return A ArrayList data type.
	 */
	public final String getBirimNo(final String depName) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP("GetBirimNo_sp",
					new Object[]{depName}).getResult();
			String depNo;
			if (rs.next()) {
				depNo = rs.getString("BirimNo");
				db.closeConnection();
				return depNo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} //getBirimNo sonu

	/**@
	 * Akedemik birimler i�in departman adi(String),
	 * String UrunNo ve miktari(int)
	 * parametre olarak al�r.
	 * miktar kadar stoktan d�ser
	 * @param depNo String.
	 * @param urunNo String.
	 * @param amount int.
	 * @return A ArrayList data type.
	 */
	public final boolean spendADStock(final String depNo,
			final String urunNo, final int amount) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("SpendStock_sp",
					new Object [] {depNo, urunNo, amount});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	} //spendADStock sonu

	
	/**@
	 * This method returns the existing
	 * amount of the item in the general depot.
	 * @param urunNO String.
	 * @return A ArrayList data type.
	 */
	public final int getGDKalan(final String urunNO) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP("GetGdKalan_sp",
					new Object[]{urunNO}).getResult();
			int kalan;
			if (rs.next()) {
				kalan = rs.getInt("Mevcut");
				db.closeConnection();
				return kalan;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	} //getGDKalan sonu
	
	/**@
	 * This method returns the existing amount of the item
	 * in the departmental depot
	 * amount of the item in the general depot.
	 * @param urunID String.
	 * @param depID String.
	 * @return A ArrayList data type.
	 */
	public final int getADKalan(final String depID, final String urunID) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP("GetBdKalan_sp",
					new Object[]{depID, urunID}).getResult();
			int kalan;
			if (rs.next()) {
				kalan = rs.getInt("Mevcut");
				db.closeConnection();
				return kalan;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	} //getADKalan sonu
	/**@
	 * This method descreases the amount of items stored in the general depot
	 * according to the usage-Urun No ya gore
	 * @param urunNo String.
	 * @param amount int.
	 * @return A boolean data type.
	 */
	public final boolean spendStockGDC(final String urunNo, final int amount) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("SpendStockGDC_sp",
					new Object [] {urunNo, amount});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	} //spendStockGDC sonu

	/**@
	 * This method descreases the amount of items stored in the general depot
	 * according to the usage-Urun ismine g�re
	 * @param urunNo String.
	 * @param amount int.
	 * @return A boolean data type.
	 */
	public final boolean spendStockGDC2(
			final String urunNo, final int amount) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("SpendStockGDC_sp",
					new Object [] {urunNo, amount});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	} //spendStockGDC2 sonu
	/**@
	 * This method adds to BD stock
	 * Increases amount
	 * @param grupNo String.
	 * @param urunNo String.
	 * @param amount int.
	 * @return A boolean data type.
	 */
	public final boolean addStockBD(
			final String grupNo, final String urunNo,
			final int amount) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("AddStockBD_sp",
					new Object [] {grupNo, urunNo, amount});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	} //spendStockGDC2 sonu
	/**@
	 * This method takes department id and returns department name
	 * @param departmentID String.
	 * @return A String data type.
	 */
	public final String getBirimIsmi(final String departmentID) {
		try {
			DB db = new DB(true);
			/*ResultSet rs = (ResultSet) db.executeSP("GetBirimName_sp",
new Object[]{departmentID}).getResult();*/
			ResultSet rs = (ResultSet) db.executeQuery(
					"SELECT GrupAdi FROM GRUP WHERE GrupNo = '" 
					+ departmentID + "'");
			String depName;
			if (rs.next()) {
				depName = rs.getString("GrupAdi");
				db.closeConnection();
				return depName;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	/**@
	*  This method returns ArrayList
	* @param grupNo String.
	* @param urunNo String.
	* @param arrFrom String.
	* @param arrTo String.
	* @param depFrom String.
	* @param depTo String.
	* @return A ResultSet data type.
	*/
	public final ArrayList getAkademikDepoSorgu(final String grupNo,
	final String urunNo, final String arrFrom, final String arrTo,
	final String depFrom, final String depTo) {
	try {
	ArrayList returnVal = new ArrayList();
	DB db = new DB(true);

	ResultSet rs = (ResultSet) db.executeSP(
			"AkademikDepoSorgusuKontrol_sp", new Object [] {
					grupNo, urunNo, arrFrom, arrTo, depFrom, depTo}).
					getResult();
	while (rs.next()) {
		String uIsmi = rs.getString("UrunIsmi");
		int miktar1 = rs.getInt("AlinanMiktar");
		int miktar2 = rs.getInt("KullanilanMiktar");
		String fatTarihi = rs.getString("FaturaTarihi");
		String harTarihi = rs.getString("CikisTarihi");
		System.out.println(uIsmi);
		returnVal.add(uIsmi);
		returnVal.add(new Integer(miktar1));
		returnVal.add(new Integer(miktar2));
		returnVal.add(fatTarihi);
		returnVal.add(harTarihi);
	}
	db.closeConnection();
	return returnVal;
	} catch (Exception e) {
	e.printStackTrace();
	}
	return null;
	}
	/**@
	*  This method returns ArrayList
	* @param urunNo String.
	* @param arrFrom String.
	* @param arrTo String.
	* @return A ResultSet data type.
	*/
	public final ArrayList getGDGirisSorgusu(
	final String urunNo, final String arrTo, final String arrFrom) {
	try {
	ArrayList returnVal = new ArrayList();
	DB db = new DB(true);

	ResultSet rs = (ResultSet) db.executeSP(
			"GDGirisSorgusu_sp", new Object [] {
					urunNo, arrTo, arrFrom}).
					getResult();
	while (rs.next()) {
		String uIsmi = rs.getString("UrunIsmi");
		String alimTarihi = rs.getString("AlimTarihi");
		int alimMiktari = rs.getInt("AlimMiktari");
		returnVal.add(uIsmi);
		returnVal.add(alimTarihi);
		returnVal.add(new Integer(alimMiktari));
	}
	db.closeConnection();
	return returnVal;
	} catch (Exception e) {
	e.printStackTrace();
	}
	return null;
	}
	/**@
	*  This method returns ArrayList
	* @param urunNo String.
	* @param grupNo String.
	* @param depFrom String.
	* @param depTo String.
	* @return A ResultSet data type.
	*/
	public final ArrayList getGDHarcamaSorgusu(
	final String urunNo, final String grupNo, final String depTo,
	final String depFrom) {
	try {
	ArrayList returnVal = new ArrayList();
	DB db = new DB(true);

	ResultSet rs = (ResultSet) db.executeSP(
			"GDHarcamaSorgusu_sp", new Object [] {
					urunNo, grupNo, depTo, depFrom}).
					getResult();
	while (rs.next()) {
		String uIsmi = rs.getString("UrunIsmi");
		String birimIsmi = rs.getString("BirimAdi");
		String harcamaTarihi = rs.getString("HarcamaTarihi");
		int harcamaMiktari = rs.getInt("HArcamaMiktari");
		returnVal.add(uIsmi);
		returnVal.add(birimIsmi);
		returnVal.add(harcamaTarihi);
		returnVal.add(new Integer(harcamaMiktari));
	}
	db.closeConnection();
	return returnVal;
	} catch (Exception e) {
	e.printStackTrace();
	}
	return null;
	}
	/**@
	*  This method returns ArrayList
	* @param urunNo String.
	* @param grupNo String.
	* @param arrFrom String.
	* @param arrTo String.
	* @return A ResultSet data type.
	*/
	public final ArrayList getBDGirisSorgusu(
			final String grupNo, final String urunNo,
			final String arrFrom, final String arrTo) {
	try {
	ArrayList returnVal = new ArrayList();
	DB db = new DB(true);

	ResultSet rs = (ResultSet) db.executeSP(
			"BDGirisSorgusu_sp", new Object [] {
					grupNo, urunNo, arrFrom, arrTo}).
					getResult();
	while (rs.next()) {
		String uIsmi = rs.getString("UrunIsmi");
		String alimTarihi = rs.getString("AlimTarihi");
		int alimMiktari = rs.getInt("AlinanMiktar");
		returnVal.add(uIsmi);
		returnVal.add(alimTarihi);
		returnVal.add(new Integer(alimMiktari));
	}
	db.closeConnection();
	return returnVal;
	} catch (Exception e) {
	e.printStackTrace();
	}
	return null;
	}
	/**@
	*  This method returns ArrayList
	* @param grupNo String.
	* @param urunNo String.
	* @param depFrom String.
	* @param depTo String.
	* @return A ResultSet data type.
	*/
	public final ArrayList getBDHarcamaSorgusu(
			final String grupNo, final String urunNo,
			final String depFrom, final String depTo) {
	try {
	ArrayList returnVal = new ArrayList();
	DB db = new DB(true);

	ResultSet rs = (ResultSet) db.executeSP(
			"BDHarcamaSorgusu_sp", new Object [] {
					grupNo, urunNo, depFrom, depTo}).
					getResult();
	while (rs.next()) {
		String uIsmi = rs.getString("UrunIsmi");
		String harcamaTarihi = rs.getString("HarcamaTarihi");
		int harcamaMiktari = rs.getInt("HarcananMiktar");
		returnVal.add(uIsmi);
		returnVal.add(harcamaTarihi);
		returnVal.add(new Integer(harcamaMiktari));
	}
	db.closeConnection();
	return returnVal;
	} catch (Exception e) {
	e.printStackTrace();
	}
	return null;
	}
	/**@
	*  This method returns resultset
	* @param groupNo String.
	* @param urunNo String.
	* @param arrFrom String.
	* @param arrTo String.
	* @param depFrom String.
	* @param depTo String.
	* @return A ArrayList data type.
	*/
	public final ArrayList getGenelDepoSorgu(final String groupNo,
	final String urunNo, final String arrFrom, final String arrTo,
	final String depFrom, final String depTo) {
	try {
	ArrayList returnVal = new ArrayList();
	DB db = new DB(true);
	ResultSet rs = (ResultSet) db.executeSP(
			"GenelDepoSorgusuKontrol_sp", new Object [] {
			groupNo, urunNo, arrFrom, arrTo, depFrom, depTo}).getResult();

	while (rs.next()) {
		String uIsmi = rs.getString("UrunIsmi");
		String bIsmi = rs.getString("BirimIsmi");
		int miktar1 = rs.getInt("AlinanMiktar");
		int miktar2 = rs.getInt("KullanilanMiktar");
		String fTarihi = rs.getString("FaturaTarihi");
		String cTarihi = rs.getString("CikisTarihi");
		returnVal.add(uIsmi);
		returnVal.add(bIsmi);
		returnVal.add(new Integer(miktar1));
		returnVal.add(new Integer(miktar2));
		returnVal.add(fTarihi);
		returnVal.add(cTarihi);
	}
	db.closeConnection();
	return returnVal;
	} catch (Exception e) {
	e.printStackTrace();
	}
	return null;
	}
	 // Class Sonu

	/**@
	 * This method returns resultset
	 * @param depName String.
	 * @return ArrayList
	 */
	public final ArrayList getADexistingItemNames(final String depName) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP("GetADexistingItemNames_sp",
					new Object [] {depName}).getResult();
			ArrayList arrList = new ArrayList();
			while (rs.next()) {
				arrList.add(rs.getString("UrunAdi"));
			}
			db.closeConnection();
			return arrList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**@
	 * This method returns resultset
	 * @return ArrayList
	 */
	public final ArrayList getGDexistingItemNames() {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP(
			"GetGDexistingItemNames_sp").getResult();
			ArrayList arrList = new ArrayList();
			while (rs.next()) {
				arrList.add(rs.getString("UrunAdi"));
			}
			db.closeConnection();
			return arrList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**@
	 * This method returns resultset
	 * @param id String
	 * @return A ResultSet data type.
	 */
	public final ResultSet getExistingItemNamesAndIDs(
			final String id) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP(
					"GetExistingItemNamesAndIDs_sp",
					new Object [] {id}).getResult();
			db.closeConnection();
			return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**@
	 * This method returns resultset
	 * @param quantity int.
	 * @param toUnitID String
	 * @param urunNo String
	 */
	public final void addTransactionAmount(final String toUnitID,
			final String urunNo, final int quantity) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP(
					"AddTransactionAmount_sp", new Object [] {
							toUnitID, urunNo, quantity}).getResult();
			db.commitTransaction();
			db.closeConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**@
	 * This method returns resultset
	 * @param quantity int.
	 * @param toUnitID String
	 * @param urunNo String
	 */
	public final void subtractTransactionAmount(final String toUnitID,
			final String urunNo, final int quantity) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP(
					"SubtractTransactionAmount_sp", new Object [] {
							toUnitID, urunNo, quantity}).getResult();
			db.commitTransaction();
			db.closeConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**@
	 * Birim depolarina urun ekler.
	 * @param depID String.
	 * @param itemID String.
	 * @param amount int.
	 * @param depoGirisNO String.
	 * @return boolean data type.
	 */
	public final boolean depoGirisDDC(final String depID,
			final String itemID, final int amount, 
			final String depoGirisNO) {
		try {
			DB db = new DB(true);
			db.beginTransaction();
			db.executeSP("DepoGirisDDC_sp",
					new Object [] {depID, itemID, amount, depoGirisNO});
			db.commitTransaction();
			db.closeConnection();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	} //addADLimit Sonu
	
	/**@
	 * urunNo lari dondurur.
	 * @return ArrayList < String > 
	 */
	public final ArrayList < String > getUrunIDs() {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) 
				db.executeSP("GetAllUrunNo_sp").getResult();
			ArrayList result = new ArrayList();
			while (rs.next()) {
				result.add(rs.getString("UrunNo"));
			}
			db.closeConnection();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} //getUrunIDs sonu
	
	/**@
	 * grupnosunu d�nderir
	 * @param birimAdi String.
	 * @return A String data type.
	 */
	public final String getGroupNoByBirimIsmi(final String birimAdi) {
		try {
			DB db = new DB(true);
			ResultSet rs = (ResultSet) db.executeSP("GetGroupNoByBirimIsmi_sp",
new Object[]{birimAdi}).getResult();
			String grupNo;
			if (rs.next()) {
				grupNo = rs.getString("GrupNo");
				db.closeConnection();
				return grupNo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} //getGroupNoByBirimIsmi sonu
} // Class Sonu
