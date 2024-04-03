--1. Soru: Veri tabanýný oluþturma
CREATE DATABASE foy3db ON PRIMARY
(
NAME= foy3_data,
FILENAME = 'C:\foy3db\foy3data.mfd',
SIZE = 8MB,
MAXSIZE = unlimited,
FILEGROWTH = 15%
)
LOG ON
(
NAME= foy3_log,
FILENAME = 'C:\foy3db\foy3log.ldf',
SIZE = 8MB,
MAXSIZE = unlimited,
FILEGROWTH = 15%
)

--1. Soru: Tablolarý Oluþturma
CREATE TABLE birimler
(
birim_id INT PRIMARY KEY,
birim_adi CHAR(25) NOT NULL
)

CREATE TABLE calisanlar
(
calisan_id INT PRIMARY KEY,
ad CHAR(25),
soyad CHAR(25),
maas INT,
katýlmaTarihi DATETIME,
calisan_birim_id INT NOT NULL,
FOREIGN KEY (calisan_birim_id) REFERENCES birimler(birim_id)
)

CREATE TABLE ikramiye
(
ikramiye_calisan_id INT NOT NULL,
FOREIGN KEY (ikramiye_calisan_id) REFERENCES calisanlar(calisan_id),
ikramiye_ucret INT,
ikramiye_tarih DATETIME
)

CREATE TABLE unvan
(
unvan_calisan_id INT NOT NULL,
FOREIGN KEY (unvan_calisan_id) REFERENCES calisanlar(calisan_id),
unvan_calisan CHAR(25),
unvan_tarih DATETIME
)

--2. Soru: Tablolara verileri ekleme
INSERT INTO birimler (birim_id, birim_adi) VALUES (1, 'Yazýlým')
INSERT INTO birimler (birim_id, birim_adi) VALUES (2, 'Donaným')
INSERT INTO birimler (birim_id, birim_adi) VALUES (3, 'Güvenlik')

INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katýlmaTarihi, calisan_birim_id) VALUES (1, 'Ýsmail', 'Ýþeri', 100000, '20140220 00:00:00 AM', 1)
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katýlmaTarihi, calisan_birim_id) VALUES (2, 'Hami', 'Satýlmýþ', 80000, '20140611 00:00:00 AM', 1)
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katýlmaTarihi, calisan_birim_id) VALUES (3, 'Durmuþ', 'Þahin', 300000, '20140220 00:00:00 AM', 2)
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katýlmaTarihi, calisan_birim_id) VALUES (4, 'Kaðan', 'Yazar', 500000, '20140220 00:00:00 AM', 3)
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katýlmaTarihi, calisan_birim_id) VALUES (5, 'Meryem', 'Soysaldý', 500000, '20140611 00:00:00 AM', 3)
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katýlmaTarihi, calisan_birim_id) VALUES (6, 'Duygu', 'Akþehir', 200000, '20140611 00:00:00 AM', 2)
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katýlmaTarihi, calisan_birim_id) VALUES (7, 'Kübra', 'Seyhan', 75000, '20140120 00:00:00 AM', 1)
INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katýlmaTarihi, calisan_birim_id) VALUES (8, 'Gülcan', 'Yýldýz', 90000, '20140411 00:00:00 AM', 3)

INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (1, 5000, '20160220 00:00:00 AM')
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (2, 3000, '20160611 00:00:00 AM')
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (3, 4000, '20160220 00:00:00 AM')
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (1, 4500, '20160220 00:00:00 AM')
INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES (2, 3500, '20160611 00:00:00 AM')

INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (1, 'Yönetici', '20160220 00:00:00 AM')
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (2, 'Personel', '20160611 00:00:00 AM')
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (8, 'Personel', '20160611 00:00:00 AM')
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (5, 'Müdür', '20160611 00:00:00 AM')
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (4, 'Yönetici Yardýmcýsý', '20160611 00:00:00 AM')
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (7, 'Personel', '20160611 00:00:00 AM')
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (6, 'Takým Lideri', '20160611 00:00:00 AM')
INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES (3, 'Takým Lideri', '20160611 00:00:00 AM')

--2. Soru: Tablolara eklenen verileri sýrasýyla gösterme
SELECT * FROM birimler
SELECT * FROM calisanlar
SELECT * FROM ikramiye
SELECT * FROM unvan

--3. Soru: Yazýlým veya Donaným birimlerinde çalýþanlarýn ad, soyad ve maaþ bilgilerini listeleyen sorgu
SELECT ad, soyad, maas FROM calisanlar WHERE calisan_birim_id = 1 OR calisan_birim_id = 2

--4. Soru: Maaþý en yüksek olan çalýþanlarýn ad, soyad ve maaþ bilgilerini listeleyen sorgu
SELECT ad, soyad, maas FROM calisanlar WHERE maas = (SELECT MAX(maas) FROM calisanlar)

--5. Soru: Birimlerde kaç adet çalýþan olduðunu ve birimlerin isimlerini listeleyen sorgu
SELECT b.birim_adi, COUNT(c.calisan_id) AS calisan_sayisi
FROM birimler b
LEFT JOIN calisanlar c ON b.birim_id = c.calisan_birim_id
GROUP BY b.birim_adi

--6. Soru: Birden fazla çalýþana ait olan ünvanlarýn isimlerini ve çalýþan sayýsýný listeleyen sorgu
SELECT u.unvan_calisan AS unvan, COUNT(u.unvan_calisan_id) AS calisan_sayisi
FROM unvan u
GROUP BY u.unvan_calisan
HAVING COUNT(u.unvan_calisan_id) > 1

--7. Soru: Maaþ 50000 ile 100000 arasýnda deðiþen çalýþanlarýn ad, soyad ve maaþ bilgilerini listeleyen sorgu
SELECT ad, soyad, maas FROM calisanlar WHERE maas BETWEEN 50000 AND 100000

--8. Soru: Ýkramiye hakkýna sahip olan çalýþanlara ait ad, soyad, birim ve ünvan ve ikramiye ücreti bilgilerini listeleyen sorgu
SELECT c.ad, c.soyad, b.birim_adi AS birim, u.unvan_calisan AS unvan, i.ikramiye_ucret
FROM calisanlar c
INNER JOIN birimler b ON c.calisan_birim_id = b.birim_id
INNER JOIN unvan u ON c.calisan_id = u.unvan_calisan_id
INNER JOIN ikramiye i ON c.calisan_id = i.ikramiye_calisan_id

--9. Soru: Ünvaný Yönetici veya Müdür olan çalýþanlarýn ad, soyad ve ünvanlarýný listeleyen sorgu
SELECT c.ad, c.soyad, u.unvan_calisan AS unvan
FROM calisanlar c
INNER JOIN unvan u ON c.calisan_id = u.unvan_calisan_id
WHERE u.unvan_calisan IN ('Yönetici', 'Müdür')

--10. Soru: Her birimde en yüksek maaþý alan çalýþanlarýn ad, soyad ve maaþ bilgilerini listeleyen sorgu
SELECT c.ad, c.soyad, c.maas
FROM calisanlar c
JOIN (
    SELECT calisan_birim_id, MAX(maas) AS max_maas
    FROM calisanlar
    GROUP BY calisan_birim_id
) AS max_maas2 ON c.calisan_birim_id = max_maas2.calisan_birim_id AND c.maas = max_maas2.max_maas

