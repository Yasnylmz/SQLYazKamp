---------------------------------------------------------------------------------
-- MUSTERI -- 
CREATE TABLE Musteri (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(50) NOT NULL,
    soyad NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    sehir NVARCHAR(50),
    kayit_tarihi DATETIME DEFAULT GETDATE()
);

-- KATEGORI --
CREATE TABLE Kategori (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(100) NOT NULL
);

-- SATICI TABLOSU --
CREATE TABLE Satici (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(100) NOT NULL,
    adres NVARCHAR(255)
);

-- URUN TABLOSU --
CREATE TABLE Urun (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(150) NOT NULL,
    fiyat DECIMAL(10,2) NOT NULL,
    stok INT NOT NULL DEFAULT 0,
    kategori_id INT NOT NULL,
    satici_id INT NOT NULL,
    CONSTRAINT FK_Urun_Kategori FOREIGN KEY (kategori_id) REFERENCES Kategori(id),
    CONSTRAINT FK_Urun_Satici FOREIGN KEY (satici_id) REFERENCES Satici(id)
);

-- SIPARIS TABLOSU --
CREATE TABLE Siparis (
    id INT IDENTITY(1,1) PRIMARY KEY,
    musteri_id INT NOT NULL,
    tarih DATETIME DEFAULT GETDATE(),
    toplam_tutar DECIMAL(12,2) DEFAULT 0,
    odeme_turu NVARCHAR(50),
    CONSTRAINT FK_Siparis_Musteri FOREIGN KEY (musteri_id) REFERENCES Musteri(id)
);

-- SIPARIS_DETAY TABLOSU --
CREATE TABLE Siparis_Detay (
    id INT IDENTITY(1,1) PRIMARY KEY,
    siparis_id INT NOT NULL,
    urun_id INT NOT NULL,
    adet INT NOT NULL,
    fiyat DECIMAL(10,2) NOT NULL, -- sipariş anındaki birim fiyat
    CONSTRAINT FK_SD_Siparis FOREIGN KEY (siparis_id) REFERENCES Siparis(id),
    CONSTRAINT FK_SD_Urun FOREIGN KEY (urun_id) REFERENCES Urun(id)
);

---------------------------------------------------------------------------------

-- Kategoriler --
INSERT INTO Kategori (ad) VALUES
('Elektronik'), ('Giyim'), ('Ev & Yaşam'), ('Kitap'), ('Spor');

-- Satıcılar --
INSERT INTO Satici (ad, adres) VALUES
('ABC Teknoloji','İstanbul, Kadıköy'),
('ModaShop','Ankara, Çankaya'),
('EvRenk','İzmir, Konak'),
('KitapDükkan','Adana, Yüreğir');

-- Müşteriler --
INSERT INTO Musteri (ad, soyad, email, sehir, kayit_tarihi) VALUES
('Ahmet','Yılmaz','ahmet@example.com','İstanbul','2024-09-01'),
('Ayşe','Kara','ayse@example.com','Ankara','2024-10-15'),
('Mehmet','Demir','mehmet@example.com','İzmir','2025-01-20'),
('Elif','Ak','elif@example.com','Adana','2025-03-10'),
('Can','Öztürk','can@example.com','İstanbul','2025-05-05');

-- Ürünler --
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Kablosuz Kulaklık', 499.90, 50, 1, 1),
('Kot Pantolon', 249.90, 120, 2, 2),
('Mutfak Robotu', 899.00, 20, 3, 3),
('Roman - Aşkın İzleri', 69.90, 200, 4, 4),
('Dik Bisiklet', 1599.00, 10, 5, 3),
('Telefon Kılıfı', 39.90, 300, 1, 1);

-- Basit siparişler (önce siparis, sonra detay) --
INSERT INTO Siparis (musteri_id, tarih, odeme_turu) VALUES (1, '2025-09-01', 'Kredi Kartı');
INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat) VALUES (1, 1, 1, 499.90);
INSERT INTO Siparis (musteri_id, tarih, odeme_turu) VALUES (2, '2025-09-05', 'Kapıda Ödeme');
INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat) VALUES (2, 2, 2, 249.90);
INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat) VALUES (2, 6, 3, 39.90);
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- // Update Delete //

-- Urun Fiyatı Güncelleme
UPDATE Urun
SET fiyat = 599.90
WHERE ad = 'Kablosuz Kulaklık';

-- Stok güncelle (ürün id=1 için stok azalt)
UPDATE Urun SET stok = stok - 1 WHERE id = 1 AND stok >= 1;

-- Tüm sipariş detaylarını sil (dikkat)
-- TRUNCATE TABLE Siparis_Detay; -- FK varsa önce FK'yi kaldır veya DELETE kullan
DELETE FROM Siparis_Detay WHERE siparis_id = 2;

-- Bir müşteriyi sil
DELETE FROM Musteri WHERE id = 5;
---------------------------------------------------------------------------------


