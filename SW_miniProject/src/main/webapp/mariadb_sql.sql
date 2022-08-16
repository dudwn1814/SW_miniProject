-- 재고 테이블  
create database inventory;
USE inventory;
create table inventory_management (
	p_id int(8) auto_increment primary key,
	p_name varchar(20) not null,
	p_price int(10) UNSIGNED not null,
	p_amount smallint(5) UNSIGNED not null
)

INSERT INTO inventory_management VALUES(null, '조명', 50000, 3);

-- 상품등록 테이블
create table product_registration (
	product_id int(8) auto_increment primary key,
	p_name varchar(20) not null,
	mtitle varchar(20) not null,
	mcontent varchar(100), 
	mregdate DATE
)