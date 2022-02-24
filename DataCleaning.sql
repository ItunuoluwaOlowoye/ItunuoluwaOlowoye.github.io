--Transact-SQL
--This dataset contains details about a furniture store
SELECT  
    *
FROM 
    PortfolioProject..furniture_store_transactions


--We want to see the products sold by the store
SELECT
    product, product_code
FROM 
    PortfolioProject..furniture_store_transactions
--The above query returns duplicates because the product information has been listed multiple times for different transactions



--The code below will return only distinct product information
--Product codes or ids are unique identifiers. It is best practice to use them to call out distinct values
SELECT 
    DISTINCT product_code, product
FROM 
    PortfolioProject..furniture_store_transactions



--Now, we can count how many distinct products that the furniture store sells
SELECT 
    COUNT(DISTINCT product_code) AS number_of_products_sold
FROM 
    PortfolioProject..furniture_store_transactions



--The purchase price tells us how much of a product has been sold.
--We want to see the highest selling product.
--To do this, we add an ORDER BY clause and DESC to view in descending order.
SELECT 
    product_code, purchase_price
FROM 
    PortfolioProject..furniture_store_transactions
ORDER BY 
    purchase_price DESC 
--The datatype for purchase price was formatted incorrectly. 
--It was listed as a string instead of a float (decimal) and will affect data analysis.



--We can clean this data by using the CAST function to convert the datatype.
--Another thing to do is to notify the data owner and ensure that the data is cleaned and converted from its source.
SELECT 
    CAST (purchase_price AS FLOAT) AS clean_purchase_price,
    product_code
FROM 
    PortfolioProject..furniture_store_transactions
ORDER BY 
    clean_purchase_price DESC 
--Now, the purchase price can be used for analysis


--We want to look at purchases that occured during the December sales
SELECT 
    date, CAST(purchase_price AS FLOAT) AS clean_purchase_price
FROM
    PortfolioProject..furniture_store_transactions
WHERE
    date between '2020-12-01' and '2020-12-31'
--The above code runs correctly and we can see that sales was effective towards the end of the month than at the beginning or middle.


--However, the date was formatted as date and time
--This can again be converted for ease of reading.
SELECT 
    CAST(date AS date) AS new_date, 
    CAST(purchase_price AS FLOAT) AS clean_purchase_price
FROM 
    PortfolioProject..furniture_store_transactions
WHERE 
    date BETWEEN '2020-12-01' AND '2020-12-31'



--The owner wants to know which couch colours are most popular so that they can restock those colours
--However, the different colours still have the same product code
--CONCAT can be used to join the product code and product colour together as one string
--Then, analysis can be done for each colour of couch
SELECT
    product_color,
    COUNT(CONCAT(product_code, product_color)) AS number_sold
FROM 
    PortfolioProject..furniture_store_transactions
WHERE
    product='couch'
GROUP BY 
    product_color
ORDER BY 
    number_sold DESC 
--Grey couches are the most popular and the store can order more of those.



--Finally, we want to get the list of names for all products that were sold
SELECT 
    product
FROM
     PortfolioProject..furniture_store_transactions



--There are two null values
--If names are absent, unique IDs ought to be present
--The COALESCE function can be used to call the product code if product names are not available.
--It saves time when making calculations while keeping the math correct.
SELECT
    DISTINCT (COALESCE(product,product_code)) AS product_info
FROM
    PortfolioProject..furniture_store_transactions