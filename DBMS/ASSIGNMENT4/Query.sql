/* Part-1(1) */

DROP FUNCTION IF EXISTS get_number_of_orders;
DELIMITER $$
CREATE FUNCTION get_number_of_orders(input_month INT,input_year INT)
    RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE number_of_orders INT;
    
    SELECT COUNT(order_id) INTO number_of_orders 
    FROM orders 
    WHERE MONTH(order_date) IN(input_month)  AND YEAR(order_date) IN(input_year);
    
    RETURN(number_of_orders);
END$$
DELIMITER ;

SELECT get_number_of_orders(8,2019);

   
   
/* Part-1(2) */

DROP FUNCTION IF EXISTS most_ordered_month;
DELIMITER $$
CREATE FUNCTION  most_ordered_month(input_year INT)
    RETURNS VARCHAR(10)
    DETERMINISTIC
BEGIN
    DECLARE best_month VARCHAR(9);
    SELECT MONTHNAME(order_date) INTO best_month
    FROM orders 
    WHERE YEAR(order_date) IN(input_year)
    GROUP BY MONTH(order_date)
    ORDER BY COUNT(order_id) DESC
    LIMIT 1;
    RETURN(best_month);
END $$

DELIMITER ;
SELECT most_ordered_month(2019);


   
/* Part-2(1) */
DROP PROCEDURE IF EXISTS get_average_sale;
DELIMITER $$
CREATE PROCEDURE get_average_sale(input_month INT, input_year INT)
BEGIN
    SELECT 
    product.product_id ,
    product.product_name,
    SUM(orderedproducts.quantity)
    FROM
    product
        INNER JOIN
    orderedproducts ON product.product_id = orderedproducts.product_id
        INNER JOIN
    orders ON orderedproducts.order_id = orders.order_id
    WHERE
    MONTH(orders.order_date) = input_month AND YEAR(orders.order_date) = input_year
GROUP BY product.product_id;
END$$
DELIMITER ;
CALL get_average_sale(8,2019);

/* Part-2(2) */
DROP PROCEDURE IF EXISTS get_order_detail;
DELIMITER $$
CREATE PROCEDURE get_order_detail(start_date DATE, end_date DATE)
BEGIN
    IF start_date>end_date THEN 
        SET start_date=(end_date-Interval day(end_date) DAY)+INTERVAL 1 DAY;
    END IF;
    SELECT orderedProducts.order_id , 
    orderedProducts.product_id ,
    status.status ,
    orders.order_date 
    FROM orderedProducts INNER JOIN status ON orderedProducts.order_id = status.order_id AND orderedProducts.product_id = status.product_id
    LEFT JOIN orders ON orderedProducts.order_id = orders.order_id
    WHERE orders.order_date >= start_date AND orders.order_date <= end_date
    ORDER BY (order_id);
END$$
DELIMITER ;

CALL get_order_detail('2018-07-06',CURDATE());

/* Part-3*/
ALTER TABLE product ADD INDEX product (product_id);
ALTER TABLE category ADD INDEX category (category_id);
ALTER TABLE orders ADD INDEX orderedDate (order_date);
