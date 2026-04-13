-- Query 1: Category performance
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY category;
ORDER BY total_sales DESC;


-- Query 2: Sub-category profitability
SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY sub_category                         
ORDER BY total_profit ASC;    


-- Query 3: Discount vs. Profit
SELECT
    discount,
    ROUND(AVG(profit), 2) AS avg_profit,
    COUNT(*) AS num_orders
FROM orders
GROUP BY discount
ORDER BY discount;


-- Query 4: Customer Segment Analysis
SELECT
    segment,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS avg_profit_per_order,
    COUNT(*) AS order_count
FROM orders
GROUP BY segment
ORDER BY total_sales DESC;


-- Query 5: Shipping Mode Analysis
SELECT
    ship_mode,
    COUNT(*) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS avg_profit_per_order
FROM orders
GROUP BY ship_mode
ORDER BY total_sales DESC;


-- Query 6: State-level Performance
SELECT
    state,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY state
ORDER BY total_profit ASC
LIMIT 15;


-- Query 7: Discount bands using CASE WHEN
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount > 0 AND discount <= 0.2 THEN 'Low Discount'
        WHEN discount > 0.2 AND discount <= 0.4 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_band,
    COUNT(*) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS avg_profit
FROM orders
GROUP BY discount_band
ORDER BY total_profit DESC;


-- Query 8: CTE for loss-making sub-categories
WITH subcategory_profit AS (                   
    SELECT
        category,
        sub_category,
        ROUND(SUM(sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit
    FROM orders
    GROUP BY category, sub_category
)
SELECT
    category,
    sub_category,
    total_sales,
    total_profit
FROM subcategory_profit
WHERE total_profit < 0   
ORDER BY total_profit ASC;


-- Query 9: Window Function — Rank sub-categories within each category
SELECT
    category,
    sub_category,
    total_profit,
    RANK() OVER (                                  
        PARTITION BY category
        ORDER BY total_profit DESC
    ) AS profit_rank_within_category
FROM (
    SELECT
        category,
        sub_category,
        ROUND(SUM(profit), 2) AS total_profit
    FROM orders
    GROUP BY category, sub_category
) t
ORDER BY category, profit_rank_within_category;


-- Query 10: Percentage contribution of each category to total sales
SELECT
    category,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        100.0 * total_sales / SUM(total_sales) OVER (), 
        2
    ) AS pct_of_total_sales
FROM (
    SELECT
        category,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY category
) t
ORDER BY total_sales DESC;


-- Query 11: Top product in each category by sales using ROW_NUMBER()
SELECT
    category,
    sub_category,
    total_sales
FROM (
    SELECT
        category,
        sub_category,
        ROUND(SUM(sales), 2) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY SUM(sales) DESC
        ) AS rn
    FROM orders
    GROUP BY category, sub_category
) t
WHERE rn = 1
ORDER BY total_sales DESC;