use  ecommerce;
/*	Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.*/
Select count(c.cus_gender) as No_Of_Customers, c.cus_gender as Gender 
from `order` o join Customer c on o.cus_id = c.cus_id
where o.ord_amount >= 3000 group by c.cus_gender;
select count(t2.cus_gender) as NoOfCustomers, t2.cus_gender as Gender 
from (select t1.cus_id, t1.cus_gender, t1.cus_name 
	  from (select  c.cus_id, c.cus_gender, c.cus_name 
			from `order` o 
            join customer c on o.cus_id = c.cus_id where o.ord_amount >=3000)  as t1 
			group by t1.cus_id
	) as t2 
group by t2.cus_gender;

/*Display all the orders along with product name ordered by a customer having Customer_Id=2*/
select p.pro_name, o.* 
from `order` o 
join customer c on o.cus_id = c.cus_id
join supplier_pricing sp on sp.pricing_id = o.pricing_id
join product p on p.pro_id = sp.pro_id
where c.cus_id = 2 ;

/*Display the Supplier details who can supply more than one product.*/
select  s.* from supplier s 
join supplier_pricing sp on sp.supp_id = s.supp_id
group by sp.supp_id having count(sp.pro_id) > 1;

/*Find the least expensive product from each category and print the table with category id, name, product name and price of the product*/
select  c.cat_id, c.cat_name, p.pro_name as LeastExpensiveProductName, min(sp.supp_price) as LeastExpensivePrice  from product p 
join category c on c.cat_id = p.cat_id
join supplier_pricing sp on sp.pro_id = p.pro_id
group by c.cat_id;

/*Display the Id and Name of the Product ordered after “2021-10-05”.*/
select p.pro_id, p.pro_name, o.ord_date from `order` o 
join supplier_pricing sp on sp.pricing_id = o.pricing_id
join product p on p.pro_id = sp.pro_id
where o.ord_date > '2021-10-05';

/*Display customer name and gender whose names start or end with character 'A'.*/
select * from customer where cus_name like 'A%' or cus_name like '%A' ;

/*Create a stored procedure to display supplier id, name, rating and Type_of_Service. 
For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, 
If rating >2 print “Average Service” else print “Poor Service”.
*/
DELIMITER &&
CREATE PROCEDURE proc()
BEGIN
	SELECT s.supp_id, s.supp_name, r.rat_ratstars, 
	CASE
		WHEN r.rat_ratstars =5  THEN "Excellent Service"
		WHEN r.rat_ratstars >4  THEN "Good Service"
		WHEN r.rat_ratstars >2  THEN "Average Service"
		ELSE "Poor Service"
	END as Type_of_Service
	FROM supplier s 
	JOIN supplier_pricing sp on s.supp_id = sp.supp_id
	JOIN `order` o on o.pricing_id = sp.pricing_id
	JOIN rating r on o.ord_id = r.ord_id;
END  &&

CALL PROC();
