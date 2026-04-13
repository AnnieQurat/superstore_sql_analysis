# SQL Retail Sales & Profitability Analysis
This project analyzes retail sales data using SQL to identify key drivers of revenue and profitability.

The analysis focuses on category performance, discount impact, customer segments, shipping modes, and regional trends. It demonstrates practical SQL skills used in real-world data analysis.

---

## Tools Used

- SQL (SQLite)
- Python (for data loading only)
- Pandas
- Jupyter Notebook

---

## SQL Concepts Demonstrated

- Aggregations (SUM, AVG, COUNT)
- GROUP BY and ORDER BY
- CASE WHEN
- Common Table Expressions (CTEs)
- Window Functions (RANK, ROW_NUMBER, percentage contribution)

---

## Business Questions

- Which product categories and sub-categories drive the most profit?
- How do discounts impact profitability?
- Which customer segments contribute the most value?
- How do shipping modes affect efficiency?
- Which regions and states underperform?

---

## Key Findings

- Technology is the strongest category in both sales and profitability  
- Several sub-categories (e.g., Tables, Bookcases, Supplies) generate negative profit  
- Higher discount levels are strongly associated with lower profitability  
- The Consumer segment contributes the highest total sales and profit  
- Standard shipping dominates volume, while other shipping modes can offer higher profit per order  
- Geographic performance varies, with some states generating losses despite sales  

---

## Project Structure

```
sql-retail-sales-analysis/
│
├── README.md
├── queries.sql
├── superstore_sql_analysis.ipynb
└── data/
└── SampleSuperstore.csv
```

---

## Files

- **superstore_sql_analysis.ipynb** → Full analysis with explanations and results  
- **queries.sql** → Clean SQL queries used in the project  

---

## Conclusion

This analysis shows that profitability is driven more by discount strategy and product mix than by revenue alone.

Controlling aggressive discounting and focusing on high-performing sub-categories could significantly improve business outcomes.

---

## Notes

- SQL queries were executed using SQLite within Jupyter Notebook  
- Python was used only to load and structure the dataset  
