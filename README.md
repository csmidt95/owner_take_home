## Project overview
This repository contains pieces of a dbt project that implements a standard Medallion architecture to model restaurant SEO data. It is designed to answer fundamental questions about clicks, impressions, ctr, and search position with respect to Branded and Unbranded searches.

## Medallion layers

### Bronze — Raw ingestion
- Ingests source tables with minimal transformation, organized by source system

### Silver — Standardized, conformed models
- Unpacks JSON data and arrays
- Applies business logic to identify Branded vs Unbranded search results
  - To accomplish this, I combined various fuzzy name matching techniques, including the Jarowinkler Similarity and Edit Distance
  - To improve upon my work, I would do deeper research on which thresholds from the `JAROWINKLER_SIMILARITY` function and `EDITDISTANCE` yield the optimal true positive/false positive rates in terms of Branded/Unbranded classification

### Gold — Business-ready marts
- Curates models used directly for analytics, reporting, and downstream products.
- Optimized for consumption (clear grain, pragmatic denormalization where helpful, materialized as a table in production runs).

## Analysis folder
- The `analysis/` directory contains queries that can be used to answer the main problem questions regarding Branded vs Unbranded impressions, clicks, ctr, and position


## Handling SCD Table
For restaurants that change their cuisine types over time, I'd want to audit how it typically changes and get a sense from the data consumer how they'd want to handle this. But from what I've done in the past, I could:
1. Take a snapshot of the `bronze_app_db_restaurant_cuisines` table so I had the time boundaries of when a restaurant was associated to their respective cuisine(s)
2. Based on the desired date grain, I'd create a gold table that joins the snapshotted Cuisine SCD model to the `silver_fct_restaurant_search_metrics` model. For instance, if this was a report based on the Month End data, I would use the last state of Cuisine at the end of each month.


