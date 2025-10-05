-- TEMEL SORGULAR --

-- En çok sipariş veren 5 müşteri (sipariş sayısına göre)
SELECT m.id, m.ad, m.soyad, COUNT(s.id) AS siparis_sayisi
FROM Musteri m
LEFT JOIN Siparis s ON m.id = s.musteri_id
GROUP BY m.id, m.ad, m.soyad
ORDER BY siparis_sayisi DESC


-- En çok satılan ürünler (toplam adet)
SELECT u.id, u.ad, SUM(sd.adet) AS toplam_adet_satis
FROM Urun u
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY u.id, u.ad
ORDER BY toplam_adet_satis DESC;

-- En yüksek cirosu olan satıcılar (satış toplamına göre)
SELECT s.id, s.ad, SUM(sd.adet * sd.fiyat) AS toplam_ciro
FROM Satici s
JOIN Urun u ON u.satici_id = s.id
JOIN Siparis_Detay sd ON sd.urun_id = u.id
GROUP BY s.id, s.ad
ORDER BY toplam_ciro DESC;

---------------------------------------------------------------------------------


-- Şehirlere göre müşteri sayısı
SELECT sehir, COUNT(*) AS musteri_sayisi
FROM Musteri
GROUP BY sehir;

-- Kategori bazlı toplam satışlar (cari fiyat * adet)
SELECT k.id, k.ad, SUM(sd.adet * sd.fiyat) AS kategori_satis_tutar
FROM Kategori k
JOIN Urun u ON u.kategori_id = k.id
JOIN Siparis_Detay sd ON sd.urun_id = u.id
GROUP BY k.id, k.ad;

-- Aylara göre sipariş sayısı
SELECT YEAR(tarih) AS yil, MONTH(tarih) AS ay, COUNT(*) AS siparis_sayisi
FROM Siparis
GROUP BY YEAR(tarih), MONTH(tarih)
ORDER BY yil, ay;

---------------------------------------------------------------------------------
-- JOIN’ler & Özel Durumlar --

-- Siparişlerde müşteri bilgisi + ürün bilgisi + satıcı bilgisi (bir sipariş için)
SELECT s.id AS siparis_id, s.tarih, m.ad + ' ' + m.soyad AS musteri,
       u.ad AS urun, sd.adet, sd.fiyat, sat.ad AS satici
FROM Siparis s
JOIN Musteri m ON s.musteri_id = m.id
JOIN Siparis_Detay sd ON sd.siparis_id = s.id
JOIN Urun u ON u.id = sd.urun_id
JOIN Satici sat ON sat.id = u.satici_id
ORDER BY s.id;

-- Hiç satılmamış ürünler
SELECT u.id, u.ad, u.stok
FROM Urun u
LEFT JOIN Siparis_Detay sd ON u.id = sd.urun_id
WHERE sd.id IS NULL;

-- Hiç sipariş vermemiş müşteriler
SELECT m.id, m.ad, m.soyad
FROM Musteri m
LEFT JOIN Siparis s ON m.id = s.musteri_id
WHERE s.id is NULL;



---------------------------------------------------------------------------------
-- İleri Seviye (Opsiyonel) --

-- En çok kazanç sağlayan ilk 3 kategori
SELECT TOP 3 k.id, k.ad, SUM(sd.adet * sd.fiyat) AS gelir
FROM Kategori k
JOIN Urun u ON u.kategori_id = k.id
JOIN Siparis_Detay sd ON sd.urun_id = u.id
GROUP BY k.id, k.ad
ORDER BY gelir DESC;

-- Ortalama sipariş tutarını geçen siparişleri bul
;WITH SiparisToplam AS (
    SELECT id, toplam_tutar FROM Siparis
)
SELECT s.id, s.musteri_id, s.toplam_tutar
FROM Siparis s
WHERE s.toplam_tutar > (SELECT AVG(toplam_tutar) FROM Siparis);

-- En az bir kez elektronik ürün (Kategori = 'Elektronik') satın alan müşteriler
SELECT  m.id, m.ad, m.soyad
FROM Musteri m
JOIN Siparis s ON s.musteri_id = m.id
JOIN Siparis_Detay sd ON sd.siparis_id = s.id
JOIN Urun u ON u.id = sd.urun_id
JOIN Kategori k ON k.id = u.kategori_id
WHERE k.ad = 'Elektronik';

-------------------------------------------