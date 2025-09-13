create table books(

book_id int identity(1,1) primary key,  -- identity olarak tanımladığımız için 1'den başlar ve 1,1 artar
title varchar(255) not null,
author varchar(255) not null,
genre varchar(55),
price decimal(10,2) check(price>0),
stock int,check(stock>=0),
published_year int check (published_year between 1900 and 2025),
added_at date
)

insert into books(title,author,genre,price,stock,published_year,added_at)
values
(N'Kayıp Zamanın İzinde', 'M. Proust', 'roman', 129.90, 25, 1913, '2025-08-20'),
(N'Simyacı', 'P. Coelho', 'roman', 89.50, 40, 1988, '2025-08-21'),
(N'Sapiens', 'Y. N. Harari', 'tarih', 159.00, 18, 2011, '2025-08-25'),
(N'İnce Memed', 'Y. Kemal', 'roman', 99.90, 12, 1955, '2025-08-22'),
(N'Körlük', 'J. Saramago', 'roman', 119.00, 7, 1995, '2025-08-28'),
(N'Dune', 'F. Herbert', 'bilim', 149.00, 30, 1965, '2025-09-01'),
(N'Hayvan Çiftliği', 'G. Orwell', 'roman', 79.90, 55, 1945, '2025-08-23'),
(N'1984', 'G. Orwell', 'roman', 99.00, 35, 1949, '2025-08-24'),
(N'Nutuk', 'M. K. Atatürk', 'tarih', 139.00, 20, 1927, '2025-08-27'),
(N'Küçük Prens', 'A. de Saint-Exupéry', 'çocuk', 69.90, 80, 1943, '2025-08-26'),
(N'Başlangıç', 'D. Brown', 'roman', 109.00, 22, 2017, '2025-09-02'),
(N'Atomik Alışkanlıklar', 'J. Clear', 'kişisel gelişim', 129.00, 28, 2018, '2025-09-03'),
(N'Zamanın Kısa Tarihi', 'S. Hawking', 'bilim', 119.50, 16, 1988, '2025-08-29'),
(N'Şeker Portakalı', 'J. M. de Vasconcelos', 'roman', 84.90, 45, 1968, '2025-08-30'),
(N'Bir İdam Mahkûmunun Son Günü', 'V. Hugo', 'roman', 74.90, 26, 1939, '2025-08-31');

-- 1. Tüm kitapların title, author, price alanlarını fiyatı artan şekilde sıralayarak listeleyin.

select title,author,price  from books order by price asc;

-- 2.Türü 'roman' olan kitapları A→Z title sırasıyla gösterin.

select title,genre from books where genre='roman' order by title asc;

-- 3.Fiyatı 80 ile 120 (dahil) arasındaki kitapları listeleyin (BETWEEN).

select title,price from books where price between 80 and 120;

-- 4.Stok adedi 20’den az olan kitapları bulun (title, stock_qty).

select  title,stock from books where stock<20;

-- 5.title içinde 'zaman' geçen kitapları LIKE ile filtreleyin (büyük/küçük harf durumunu not edin).

select title from books where title like '%zaman%';

-- 6.genre değeri 'roman' veya 'bilim' olanları IN ile listeleyin.

select title,genre from books where genre in ('roman','bilim');

-- 7.published_year değeri 2000 ve sonrası olan kitapları, en yeni yıldan eskiye doğru sıralayın.

select title,published_year from books where published_year>2000 order by published_year desc;

-- 8.Son 10 gün içinde eklenen kitapları bulun (added_at tarihine göre).

select title,added_at from books where added_at >= dateadd(day,-10,GETDATE()); -- (türünü,ne kadar azalacağını,hangi günden)

-- 9.En pahalı 5 kitabı price azalan sırada listeleyin (LIMIT 5).

select top 5 title,price from books order by price desc;   -- Limit postgres ve mysql için geçerli mssql'de top kullanılıyor.

-- 10.Stok adedi 30 ile 60 arasında olan kitapları price artan şekilde sıralayın.

select title,stock from books where stock between 30 and 60 order by price asc;


