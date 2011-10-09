/*
Created		03.06.2006
Modified		04.06.2006
Project		
Model		
Company		
Author		
Version		
Database		mySQL 5 
*/




Create table customer (
	username Varchar(20) NOT NULL,
	password Varchar(20) NOT NULL,
	name Varchar(20) NOT NULL,
	email Varchar(20) NOT NULL,
	telephone Char(10) NOT NULL,
	address Varchar(70) NOT NULL,
	UNIQUE (email),
 Primary Key (username)
) ENGINE = InnoDB;

Create table DVD (
	dvd_id Int UNSIGNED NOT NULL AUTO_INCREMENT,
	type Tinyint UNSIGNED NOT NULL,
	title Varchar(20) NOT NULL,
	country Varchar(20) NOT NULL,
	year Year(4) NOT NULL,
	duration Time NOT NULL,
	imagefile Varchar(30),
	quantity Int UNSIGNED NOT NULL,
	producer Varchar(20) NOT NULL,
	price Int UNSIGNED,
	singer Varchar(20),
	main_actors Varchar(100),
	music Varchar(20),
	director Varchar(20),
	scenarist Varchar(20),
 Primary Key (dvd_id),
 Index titleindex (title),
 Index singerindex (singer)
) ENGINE = InnoDB;

Create table administrator (
	username Varchar(20) NOT NULL,
	password Varchar(20),
	email Varchar(20),
 Primary Key (username)
) ENGINE = InnoDB;

Create table orders (
	order_id Int UNSIGNED NOT NULL AUTO_INCREMENT,
	username Varchar(20) NOT NULL,
	dvd_id Int UNSIGNED NOT NULL,
	quantity Int UNSIGNED NOT NULL,
	status Tinyint UNSIGNED NOT NULL,
	order_date Date NOT NULL,
	ship_date Date,
 Primary Key (order_id,username,dvd_id),
 Index userindex (username),
 Foreign Key (username) references customer (username) on delete  restrict on update cascade,
 Foreign Key (dvd_id) references DVD (dvd_id) on delete  restrict on update cascade
) ENGINE = InnoDB;
























CREATE VIEW 
musicDVD(dvd_id, title, country, year,
	duration, imagefile, quantity, producer,
	singer, price, type)
AS
SELECT
dvd_id, title, country, year,duration,
	imagefile, quantity, producer, singer, 
	price, type
FROM DVD
WHERE
type = 0;
CREATE VIEW 
filmDVD(dvd_id, title, country, year,
	duration, imagefile, quantity, producer,
	main_actors, music, director, scenarist,
	price, type)
AS
SELECT dvd_id, title, country, year,
	duration, imagefile, quantity, producer,
	main_actors, music, director, scenarist,
	price, type
FROM DVD
WHERE
type = 1;



/* Users permissions */





