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
	d.add(1, 0,'Baþlangýç','index.html');

	d.add(sistemeGiris, 0,'Sisteme Giriþ');
	d.add(sistemeGiris+1, sistemeGiris,'Sisteme Giriþ', 'sisteme_giris.html');
	d.add(sistemeGiris+2, sistemeGiris,'Hatalý Giriþ', 'sisteme_giris_hatali_giris.html');
	d.add(sistemeGiris+3, sistemeGiris, "D.Ýmza Appleti Güvenlik Uyarýsý","sisteme_giris_digital_imza_uyarisi.html");

	d.add(onayBekleyen, 0,'Onay Bekleyen Ýstekler');
	d.add(onayBekleyen+1, onayBekleyen,'Onay Bekleyen Ýstekler', 'onay_bekleyen_istekler.html');
	d.add(onayBekleyen+2, onayBekleyen,'Detay Gör. (Doðrudan Alým)', 'onay_bekleyen_istekler_detay_gotuntuleme_dogrudan_alim.html');
	d.add(onayBekleyen+3, onayBekleyen,'Detay Gör. (Satýn Alým)', 'onay_bekleyen_istekler_detay_gotuntuleme_satin_alim.html');
	

	d.add(guvenlik, 0,'Güvenlik');
	d.add(guvenlik+1, guvenlik,'Özel Ýmza Anahtarýný Yükleme','guvenlik_ozel_imza_anahtarini_yukleme.html');	

	d.add(dekanliklar, 0,'Dekanlýklar');
	d.add(dekanliklar+1, dekanliklar,'Dekan Sayfasý', 'dekanliklar_dekan_sayfasi.html');	
	d.add(dekanliklar+2, dekanliklar,'Dekanlýk Sekreteri Sayfasý', 'dekanliklar_dekanlik_sekreteri_sayfasi.html');	
	
	d.add(bolumler, 0,'Bölümler');
	d.add(bolumler+1, bolumler,'Bölüm Baþkaný Sayfasý', 'bolumler_bolum_baskani_sayfasi.html');	
	d.add(bolumler+2, bolumler,'Bölüm Sekreteri Sayfasý', 'bolumler_bolum_sekreteri_sayfasi.html');	
	
	d.add(destek, 0,'Destek Birimi');
	d.add(destek+1, destek,'Destek Birimi Sayfasý', 'destek_birimi_sayfasi.html');	
	d.add(destek+2, destek,'Destek Birimi Müdürü Sayfasý', 'destek_birimi_muduru_sayfasi.html');	
	
	d.add(ihale, 0,'Ýhaleler');
	d.add(ihale+1, ihale,'Ýhale Rapor Ekraný', 'ihale_rapor_ekrani.html');	
	d.add(ihale+2, ihale,'Ýhale Teklif Detay Gör.');	
	d.add(ihale+3, ihale+2,'Ýhale Teklif Detay Gör.', 'ihale_teklif_detay_goruntuleme.html');	
	d.add(ihale+4, ihale+2,'Ýhale Detay', 'ihale_detay.html');	
	d.add(ihale+5, ihale,'Ýhale Yönetimi');	
	d.add(ihale+6, ihale+5,'Ýhale Yönetimi', 'ihale_yonetimi.html');	
	d.add(ihale+7, ihale+5,'Ýhale Oluþturma', 'ihale_olusturma.html');	
	d.add(ihale+8, ihale+5,'Açýlmýþ Ýhalelerin Yönetimi', 'ihale_acilmis_ihalelerin_yonetimi.html');	
	d.add(ihale+9, ihale+5,'Teklif Alýnacak Ýhl. Yön.', 'ihale_teklif_alinanacak_ihalelerin_yonetimi.html');	
	d.add(ihale+10, ihale+5,'Yeni Teklif Hazýrlama', 'ihale_yeni_teklif_hazirlama.html');	
	d.add(ihale+11, ihale+5,'Teklifi Görme, Güncelleme', 'ihale_verilen_teklifi_gorme_ve_guncelleme.html');	
	d.add(ihale+12, ihale+5,'Sonuçlanmýþ Ýhalelerin Yön.', 'ihale_sonuclanmis_ihalelerin_yonetimi.html');	
	d.add(ihale+13, ihale+5,'Ýhale Detayý Görüntüleme', 'ihale_ihale_detayi_goruntuleme.html');	

	d.add(butce, 0,'Bütçe');
	d.add(butce+1, butce,'Bütçe Anasayfa', 'butce_anasayfa.html');	
	d.add(butce+2, butce,'Detay Görüntüleme', 'butce_detay_goruntuleme.html');	
	d.add(butce+3, butce,'Bütçe Baþkaný Kullanýcýsý');	
	d.add(butce+4, butce+3,'Bütçe Baþkaný Sayfasý', 'butce_baskani_sayfasi.html');	
	d.add(butce+5, butce+3,'Detay Görüntüleme', 'butce_baskani_detay_goruntuleme.html');	
	d.add(butce+6, butce,'Kurumsal Kod Yönetimi');	
	d.add(butce+7, butce+6,'Kurumsal Kod Yönetimi', 'butce_kurumsal_kod_yonetimi.html');	
	d.add(butce+8, butce+6,'Yeni Kurum. Kod Atanmasý', 'butce_yeni_kurumsal_kod_atanmasi.html');	
	d.add(butce+9, butce,'Bütçe Kod Yönetimi');	
	d.add(butce+10, butce+9,'Bütçe Kod Yönetimi', 'butce_kod_yonetimi.html');	
	d.add(butce+11, butce+9,'Yeni Bütçe Tipi Tanýmlama', 'butce_yeni_butce_tipi_tanimlama.html');	
	d.add(butce+12, butce+9,'Yeni Bütçe Daðýlýmý Giriþi', 'butce_yeni_butce_dagilimi_girisi.html');	
	d.add(butce+13, butce,'Bütçe Daðýlýmý Yönetimi', 'butce_dagilimi_yonetimi.html');	
	d.add(butce+14, butce,'Birimlere Bütçe Atanmasý', 'butce_birimlere_butce_atanmasi.html');	

document.write(d);
 
//myString = new String("Dijital Ýmza Applet'i Güvenlik Uyarýsý");
//slicer=myString.slice(0,12)

// -->