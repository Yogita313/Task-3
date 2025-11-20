USE ecommerce;
SELECT * FROM shipping_data;
#Explore the data
-- Preview
SELECT * FROM shipping_data LIMIT 10;

-- Count total rows
SELECT COUNT(*) FROM shipping_data;

-- Check distinct values
SELECT DISTINCT Mode_of_Shipment FROM shipping_data;
SELECT DISTINCT Product_importance FROM shipping_data;
SELECT DISTINCT Class FROM shipping_data;

#Analyze class distribution
-- How many records per class
SELECT Class, COUNT(*) AS total
FROM shipping_data
GROUP BY Class;

#Aggregation by shipment mode
-- Average discount and weight by shipment mode
SELECT Mode_of_Shipment,
       AVG(Discount_offered) AS avg_discount,
       AVG(Weight_in_gms) AS avg_weight
FROM shipping_data
GROUP BY Mode_of_Shipment;
# subquery Example
-- Top 3 warehouse blocks by average customer rating
SELECT Warehouse_block, avg_rating
FROM (
    SELECT Warehouse_block, AVG(Customer_rating) AS avg_rating
    FROM shipping_data
    GROUP BY Warehouse_block
) AS sub
ORDER BY avg_rating DESC
LIMIT 3;
#Join Example
SELECT s.Product_importance, p.product_name, s.Weight_in_gms
FROM shipping_data s
INNER JOIN product_info p ON s.product_id = p.product_id;

#Create a View
DROP VIEW IF EXISTS shipment_summary;

CREATE VIEW shipment_summary AS
SELECT Mode_of_Shipment AS shipment_mode,
       COUNT(*) AS total_shipments,
       AVG(Discount_offered) AS avg_discount,
       AVG(Weight_in_gms) AS avg_weight
FROM shipping_data
GROUP BY Mode_of_Shipment;

# Optimize with Indexes
CREATE INDEX idx_mode ON shipping_data(Mode_of_Shipment);
CREATE INDEX idx_class ON shipping_data(Class);