# DBT Growrk Project Documentation

---

## Overview

This project was designed to showcase the development of an **ETL pipeline** using the **Medallion Architecture** inside **BigQuery**, orchestrated using **DBT**. The project simulates the typical daily data refresh pipeline, focusing on transforming raw data into structured insights for analysis. While the goal was to fully integrate the DBT workflow within **Airflow**, the orchestration wasn't fully completed due to time constraints.

### Objectives:
- Transform and load raw data (bronze) into refined datasets (gold) using **DBT**.
- Set up automated orchestration with **Airflow** for daily pipeline execution.
- Provide well-documented and easily auditable models for future development and automation.

### Key Highlights:
- **Data Transformation**: From raw data to meaningful insights.
- **Model Testing**: Ensuring data integrity with custom DBT tests.
- **Documentation**: Detailed schema YAML files to improve collaboration and support automation tools like **Gemini IA**.

---

## Data Preparation

Data preparation involved various steps to ensure data consistency and readiness for analysis:

### Key Steps Taken:
- **Handling Missing Data**: `COALESCE` used to replace `NULL` values and ensure data completeness.
- **Normalization**: Applied `REGEXP_REPLACE` to standardize string values by removing accents and special characters.
- **Grouping & Aggregation**: Used `GROUP BY` for data aggregation (e.g., name count per year).

---


### Model Development:
- **Common Table Expressions (CTEs)**: Simplified transformation logic and broken down complex queries for clarity and reuse.
- **Advanced SQL Techniques**: Applied functions like `ROW_NUMBER()`, `LAG()`, and `CAST()` for more efficient data processing and comparisons.

### BigQuery Considerations:
- Due to the absence of time-based fields (`created_at`, `updated_at`), incremental models were not used. Instead, **table models** were implemented to simplify the pipeline, considering the dataset size (under 10GB).

---

### Trend Analysis:
- **Name Popularity Trends**: Aggregated name counts by decade, analyzing trends in name popularity.
- **Cross-Model Comparison**: Validated aggregation results by comparing data between the **silver** and **gold** models.

---

### Best Practices:
- **Readability**: Clear, consistent naming conventions for models and tables, e.g., `gold__name_trends_eduardo`.
- **Modularity**: Queries broken into reusable CTEs to improve maintainability.
- **Consistency**: Best practices for handling `NULL` values, `GROUP BY`, and correct data types using `CAST()`.

Schema YAML files were also used to document models and tests on key attributes, ensuring transparency.

---

### Challenges:
- **Incremental Models**: Absence of `created_at` and `updated_at` fields made incremental processing infeasible.

### Solution:
- Opted for **table models** to handle the small dataset (under 10GB), simplifying the data pipeline while avoiding unnecessary complexity.

---

### Documentation & Clarity:
- All models and transformations are documented with clear explanations in the **schema YAML** files.
- **Test Explanations**: Row count and null tests ensure that transformations are correct and consistent.

### Data Observations:
- Employed the `LAG()` function to calculate year-over-year changes, enabling deeper analysis of name trends.

---

## 9. Best Practices

### DBT & BigQuery Best Practices:
- **Materializations**: Chose **table models** instead of incremental models for small datasets.
- **Testing**: Ensured data validity with **row count** and **non-null** tests.
- **Documentation**: Thorough documentation for models, tests, and transformations for future reference.
- **Efficient Transformation**: Used optimized SQL queries, clustering, and aggregation for efficient data processing in BigQuery.

---

## 10. Conclusion

This project demonstrates my ability to build a robust DBT pipeline using best practices inside BigQuery, ensuring that the pipeline is both efficient and maintainable. By focusing on clarity and simplicity, the pipeline is designed to be easily understood and extended for future projects.

With well-documented models and transformations, the project is ready for integration into automated workflows, providing clear, actionable insights on name trends over time.

---

### Additional Considerations

- Future improvements include the integration of **Airflow** to fully orchestrate the pipeline.
- **Gemini IA** can help automate model exploration and optimization, leveraging the detailed documentation for faster development cycles.

