package global;

/**istek fisinin parcalarini tutmak icn coding1 bll tarafindan yazildi.
 * Bilmiyorsan elleme bu classi kullaniliyor cünkü .
 * */
public class IstekParca {

	public String urun=null;	
	public String aciklama=null;//eklenen item
	public String miktar=null;
	public String birim=null;//her itemin birim fiyati
	public String birimFiyati=null;//her itemin birim fiyati
	public double tutari=0;
	public String urunNo=null;
	
	
	public double setTutari(){		
		try{
			double miktarInt=Double.parseDouble(miktar);
			double birimFiyatInt=Double.parseDouble(birimFiyati);
			
			tutari=miktarInt*birimFiyatInt;
			return tutari;
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	
	
	
}
