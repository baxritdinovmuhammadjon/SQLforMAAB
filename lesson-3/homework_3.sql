create database product
create table products (productId int primary key, productname varchar(50), price decimal(10, 2))

insert into products ( productId, productname, price)
values
(1, 'Laptop', 1299.00),
(2, 'Phone',  999.99),
(3, 'Mouse',  49.99);

select*from products

alter table products
add constraint uq_productname unique (productname);
select*from products where price>50