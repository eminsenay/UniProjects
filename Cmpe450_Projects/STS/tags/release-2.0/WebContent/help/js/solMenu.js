<!--
var sistemeGiris = 10;
var onayBekleyen = 20;
var guvenlik = 30;
var dekanliklar = 40;
var bolumler = 50;
var destek = 60;
var ihale = 70;
var butce = 90;

d = new dTree('d');
d.config.target = '_self';
	d.add(0,-1,'','');
	d.add(1, 0,'Ba�lang��','index.html');

	d.add(sistemeGiris, 0,'Sisteme Giri�');
	d.add(sistemeGiris+1, sistemeGiris,'Sisteme Giri�', 'sisteme_giris.html');
	d.add(sistemeGiris+2, sistemeGiris,'Hatal� Giri�', 'sisteme_giris_hatali_giris.html');
	d.add(sistemeGiris+3, sistemeGiris, "D.�mza Appleti G�venlik Uyar�s�","sisteme_giris_digital_imza_uyarisi.html");

	d.add(onayBekleyen, 0,'Onay Bekleyen �stekler');
	d.add(onayBekleyen+1, onayBekleyen,'Onay Bekleyen �stekler', 'onay_bekleyen_istekler.html');
	d.add(onayBekleyen+2, onayBekleyen,'Detay G�r. (Do�rudan Al�m)', 'onay_bekleyen_istekler_detay_gotuntuleme_dogrudan_alim.html');
	d.add(onayBekleyen+3, onayBekleyen,'Detay G�r. (Sat�n Al�m)', 'onay_bekleyen_istekler_detay_gotuntuleme_satin_alim.html');
	

	d.add(guvenlik, 0,'G�venlik');
	d.add(guvenlik+1, guvenlik,'�zel �mza Anahtar�n� Y�kleme','guvenlik_ozel_imza_anahtarini_yukleme.html');	

	d.add(dekanliklar, 0,'Dekanl�klar');
	d.add(dekanliklar+1, dekanliklar,'Dekan Sayfas�', 'dekanliklar_dekan_sayfasi.html');	
	d.add(dekanliklar+2, dekanliklar,'Dekanl�k Sekreteri Sayfas�', 'dekanliklar_dekanlik_sekreteri_sayfasi.html');	
	
	d.add(bolumler, 0,'B�l�mler');
	d.add(bolumler+1, bolumler,'B�l�m Ba�kan� Sayfas�', 'bolumler_bolum_baskani_sayfasi.html');	
	d.add(bolumler+2, bolumler,'B�l�m Sekreteri Sayfas�', 'bolumler_bolum_sekreteri_sayfasi.html');	
	
	d.add(destek, 0,'Destek Birimi');
	d.add(destek+1, destek,'Destek Birimi Sayfas�', 'destek_birimi_sayfasi.html');	
	d.add(destek+2, destek,'Destek Birimi M�d�r� Sayfas�', 'destek_birimi_muduru_sayfasi.html');	
	
	d.add(ihale, 0,'�haleler');
	d.add(ihale+1, ihale,'�hale Rapor Ekran�', 'ihale_rapor_ekrani.html');	
	d.add(ihale+2, ihale,'�hale Teklif Detay G�r.');	
	d.add(ihale+3, ihale+2,'�hale Teklif Detay G�r.', 'ihale_teklif_detay_goruntuleme.html');	
	d.add(ihale+4, ihale+2,'�hale Detay', 'ihale_detay.html');	
	d.add(ihale+5, ihale,'�hale Y�netimi');	
	d.add(ihale+6, ihale+5,'�hale Y�netimi', 'ihale_yonetimi.html');	
	d.add(ihale+7, ihale+5,'�hale Olu�turma', 'ihale_olusturma.html');	
	d.add(ihale+8, ihale+5,'A��lm�� �halelerin Y�netimi', 'ihale_acilmis_ihalelerin_yonetimi.html');	
	d.add(ihale+9, ihale+5,'Teklif Al�nacak �hl. Y�n.', 'ihale_teklif_alinanacak_ihalelerin_yonetimi.html');	
	d.add(ihale+10, ihale+5,'Yeni Teklif Haz�rlama', 'ihale_yeni_teklif_hazirlama.html');	
	d.add(ihale+11, ihale+5,'Teklifi G�rme, G�ncelleme', 'ihale_verilen_teklifi_gorme_ve_guncelleme.html');	
	d.add(ihale+12, ihale+5,'Sonu�lanm�� �halelerin Y�n.', 'ihale_sonuclanmis_ihalelerin_yonetimi.html');	
	d.add(ihale+13, ihale+5,'�hale Detay� G�r�nt�leme', 'ihale_ihale_detayi_goruntuleme.html');	

	d.add(butce, 0,'B�t�e');
	d.add(butce+1, butce,'B�t�e Anasayfa', 'butce_anasayfa.html');	
	d.add(butce+2, butce,'Detay G�r�nt�leme', 'butce_detay_goruntuleme.html');	
	d.add(butce+3, butce,'B�t�e Ba�kan� Kullan�c�s�');	
	d.add(butce+4, butce+3,'B�t�e Ba�kan� Sayfas�', 'butce_baskani_sayfasi.html');	
	d.add(butce+5, butce+3,'Detay G�r�nt�leme', 'butce_baskani_detay_goruntuleme.html');	
	d.add(butce+6, butce,'Kurumsal Kod Y�netimi');	
	d.add(butce+7, butce+6,'Kurumsal Kod Y�netimi', 'butce_kurumsal_kod_yonetimi.html');	
	d.add(butce+8, butce+6,'Yeni Kurum. Kod Atanmas�', 'butce_yeni_kurumsal_kod_atanmasi.html');	
	d.add(butce+9, butce,'B�t�e Kod Y�netimi');	
	d.add(butce+10, butce+9,'B�t�e Kod Y�netimi', 'butce_kod_yonetimi.html');	
	d.add(butce+11, butce+9,'Yeni B�t�e Tipi Tan�mlama', 'butce_yeni_butce_tipi_tanimlama.html');	
	d.add(butce+12, butce+9,'Yeni B�t�e Da��l�m� Giri�i', 'butce_yeni_butce_dagilimi_girisi.html');	
	d.add(butce+13, butce,'B�t�e Da��l�m� Y�netimi', 'butce_dagilimi_yonetimi.html');	
	d.add(butce+14, butce,'Birimlere B�t�e Atanmas�', 'butce_birimlere_butce_atanmasi.html');	

document.write(d);
 
//myString = new String("Dijital �mza Applet'i G�venlik Uyar�s�");
//slicer=myString.slice(0,12)

// -->