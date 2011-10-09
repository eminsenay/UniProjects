/*
 * Request.java
 *
 * Created on October 28, 2005, 2:24 PM
 * 
 */

package global;

import java.sql.ResultSet;
import java.util.Date;

/**
 * Istek fisinin bilgilerini tutan class. 
 * <p> Asil gorevi bilgi tutmak oldugu icin genelde sadece
 *  get/set tarzi fonksiyonlari vardir. </p> 
 * Yeni bir istek yapildiginda olusturulur ve kullanilir.
 * <p>
 * <h4>
 * Istek fisinde bir suru field icin tek tek get/set yaz?nca cok karisik oldu class
 * bu nedenle genel kisimlari turkcelestirdim (orjinalindeki ile ayni isimler) ve public yapt?m.
 *</h4>
 * @author omer
 * @version 1.0.0
 */
public class Request {
    
    private long requestID=0;  
    /**The department that this request is currently in.*/    
    private long departmentID=0;    
    
    /** The page that this request is now waiting to be approved*/
    private long nextPositionID;
    
    private Date enteredToGroup=null;

        
    //////////////////////////////////////////////////////////////////////
    // Fields for the requested object
    //////////////////////////////////////////////////////////////////////
    public Date tarih=null;
    public String kurumsal=null; //97.08.02.04  (sample value)
    public String fonksiyonel=null; //09.4.1.00 (sample value)
    public String finansal=null; //2 (sample value)
    public String ekonomik = null; //06.1.2.01 (sample value)
    
    /**How many of this items.*/
    public int miktar = 0;
    public String birim = null;
    /**Comment about the request*/
    public String aciklama = null;
    /** Estimated unit cost in YTL */
    public double tahminiBirimFiyati = 0.0;
    /** Estimated total cost in YTL */
    public double tahminiTutari = 0.0;
    
    //////////////////////////////////////////////////////////////////////
    // Fields for the requested object
    //////////////////////////////////////////////////////////////////////
        
    // Fields for he who has requested
    public String ihtiyaciTalepEden_adiSoyadi=null;
    public String ihtiyaciTalepEden_gorevUnvani=null;   
    // Fields for he who has requested
    
    // Departmant chief 
    public String ilgiliUniteAmiri_adiSoyadi=null;
    public String ilgiliUniteAmiri_gorevUnvani=null;   
    // Departmant chief 

    // Butcede tahsilati vardir
    public Date butcedeTahsilatiVardir_tarih=null;
    public String butcedeTahsilatiVardir_siraNo=null;
    public String butcedeTahsilatiVardir_baglanan=null;
    // Butcede tahsilati vardir
    
    // Approvall
    public String uygundur_adiSoyadi=null;
    public String uygundur_gorevUnvani=null;
    // Approvall
    
    
    /** Creates a new instance of Request */
    public Request(long requestID,long departmentID,long nextPositionID)
    {
        this.requestID=requestID;
        this.departmentID=departmentID;
        this.nextPositionID=nextPositionID;
    }
    public long getNextPositionID() {
        return nextPositionID;
    }

    public Date getEnteredToGroup() {
        return enteredToGroup;
    }

    public long getDepartmentID() {
        return departmentID;
    }

    public long getRequestID() {
        return requestID;
    }

    public void setEnteredToGroup(Date enteredToGroup) {
        this.enteredToGroup = enteredToGroup;
    }

    public void setDepartmentID(long departmentID) {
        this.departmentID = departmentID;
    }

    public void setNextPositionID(long nextPositionID) {
        this.nextPositionID = nextPositionID;
    }

    public void setRequestID(long requestID) {
        this.requestID = requestID;
    }    
    
    /**
     * parses and fills all the fields of this class using
     * the returned resultset from db queries .
     * <p>Database erisimi yapmaz sadece verilen record u parcalar
     */
    public void readFromDatabase(ResultSet result)
    {
    //will be done soon
        try{
            if( result.next() ){

                this.aciklama   = result.getString( "aciklama" );
                this.birim      = result.getString( "birim" );
                this.butcedeTahsilatiVardir_baglanan = result.getString( "butcedeTahsilatiVardir_baglanan" );
                this.butcedeTahsilatiVardir_siraNo = result.getString( "butcedeTahsilatiVardir_siraNo" );
                this.butcedeTahsilatiVardir_tarih = result.getDate("butcedeTahsilatiVardir_tarih" );
                this.ekonomik = result.getString( "ekonomik" );
                this.enteredToGroup = result.getDate( "enteredToGroup" );
                this.finansal = result.getString( "finansal" );
                this.fonksiyonel = result.getString( "fonksiyonel" );
                this.nextPositionID = result.getLong( "PositionID" );
                this.ihtiyaciTalepEden_adiSoyadi = result.getString( "ihtiyaciTalepEden_adiSoyadi" );
                this.ihtiyaciTalepEden_gorevUnvani = result.getString( "ihtiyaciTalepEden_gorevUnvani" );
                this.ilgiliUniteAmiri_adiSoyadi = result.getString( "ilgiliUniteAmiri_adiSoyadi" );
                this.kurumsal = result.getString( "kurumsal" );
                this.miktar = result.getInt( "miktar" );                
                this.requestID = result.getLong("requestID");
                this.tahminiBirimFiyati = result.getLong("tahminiBirimFiyati");
                this.tahminiTutari = result.getLong("tahminiTutari");
                this.tarih = result.getDate("tarih");
                this.uygundur_adiSoyadi = result.getString("uygundur_adiSoyadi");
                this.uygundur_gorevUnvani = result.getString("uygundur_gorevUnvani");
                
            }
        }
        catch( java.sql.SQLException E){
        
           E.printStackTrace();
        }
    }
    /**
     * Write the whole request to the database as it should be stored.
     * 
     */
    public void writeToDatabase()
    {
    //will be done soon    
    }
    
}
