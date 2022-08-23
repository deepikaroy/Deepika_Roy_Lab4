create schema ecommerce;
create table if not exists ecommerce.Supplier
(
SUPP_ID int primary key, 
SUPP_NAME	varchar(50) NOT NULL,
SUPP_CITY	varchar(50) NOT NULL,
SUPP_PHONE	varchar(50) NOT NULL
);
select * from ecommerce.Product;
create table if not exists ecommerce.Customer
(
CUS_ID	INT primary key,
CUS_NAME	VARCHAR(20) NOT NULL,
CUS_PHONE	VARCHAR(10) NOT NULL,
CUS_CITY	VARCHAR(30) NOT NULL,
CUS_GENDER	CHAR
);

create table if not exists ecommerce.Category
(
CAT_ID	INT primary key,
CAT_NAME	VARCHAR(20) NOT NULL
);
create table if not exists ecommerce.Product
(
PRO_ID	INT primary key,
PRO_NAME	VARCHAR(20) NOT NULL DEFAULT "Dummy",
PRO_DESC	VARCHAR(60),
CAT_ID int not null,
foreign key(CAT_ID) references ecommerce.Category(CAT_ID)
);

create table if not exists ecommerce.Supplier_pricing
(
PRICING_ID	INT primary key,
PRO_ID	int not null,
SUPP_ID	int not null,
SUPP_PRICE int DEFAULT 0,
foreign key(PRO_ID) references ecommerce.Product(PRO_ID), 
foreign key(SUPP_ID) references ecommerce.Supplier(SUPP_ID)
);

create table if not exists ecommerce.Order
(
ORD_ID	INT primary key,
ORD_AMOUNT	INT NOT NULL,
ORD_DATE	DATE NOT NULL,
CUS_ID	INT not null,
PRICING_ID	INT not null,
foreign key(CUS_ID) references ecommerce.Customer(CUS_ID), 
foreign key(PRICING_ID) references ecommerce.Supplier_pricing(PRICING_ID)
);

create table if not exists ecommerce.Rating
(
RAT_ID	INT primary key,
ORD_ID	INT NOT NULL,
RAT_RATSTARS	INT NOT NULL,
foreign key(ORD_ID) references ecommerce.Order(ORD_ID)
);