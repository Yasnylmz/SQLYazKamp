### *// Online Alışveriş Platformu - Veri Tabanı Raporu //*



#### 1\. Modelleme Nedenleri



* ###### Gerçek bir e-ticaret platformunu modellemek için tablo yapısı oluşturuldu.
* ###### Tablolar: Musteri, Urun, Kategori, Satici, Siparis, Siparis\_Detay
* ###### İlişkiler ER diyagramında  ve 1..\* şeklinde  gösterildi.



#### 2\. Karşılaşılan Problemler



* ###### Sipariş ve sipariş detay silme sırasında foreign key hataları.
* ###### TRUNCATE kullanımı sırasında da dikkat edilmesi gerektiği görüldü:

&nbsp;   => Eğer tablo foreign key ile bağlıysa, doğrudan TRUNCATE çalıştırılamaz.

&nbsp;   => Bu nedenle önce bağlı tablolar silinmeli veya DELETE kullanılmalı.



#### 3\. Test Verileri



* ###### 5 müşteri, 5 kategori, 4 satıcı, 6 ürün, 2 sipariş, 3 sipariş detayı.
