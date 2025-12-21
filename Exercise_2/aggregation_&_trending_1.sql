/*
====================================================
SQL Exercise – QC / MSAT Industrial Context
Part 2: Batch-Level Aggregation & Trending Preparation
====================================================

Context:
You are working in an MSAT / Process Analytics role in a GMP-regulated
pharmaceutical environment.
Laboratory assay results are stored at result-level granularity,
but business decisions are typically made at batch-level.

Your task is to prepare a clean, batch-level dataset that can be used
for trending, process capability analysis, and downstream analytics
(e.g. Python, BI tools).

Assumptions:
- Data is read-only.
- Only approved results are considered valid.
- Assay results are numeric and comparable within the same unit.
- One batch can have multiple samples and multiple assay results.
- Business logic must be explicit and reviewable.

Data Model:
- batches(batch_id, product_code, campaign, manufacture_date)
- samples(sample_id, batch_id, sample_type, sample_time)
- results(result_id, sample_id, test_name, result_value, result_unit, result_status)

Task:
1. Retrieve approved assay results for product 'P001'.
2. Aggregate results to batch-level.
3. For each batch, calculate:
   - number of assay results
   - average assay value
   - minimum assay value
   - maximum assay value
4. Ensure the aggregation grain is exactly one row per batch.
5. Make the query readable, explicit, and suitable for MSAT review.

Expected Output:
- One row per batch
- Columns:
  - batch_id
  - n_results
  - avg_result_value
  - min_result_value
  - max_result_value

Notes:
- Think carefully about aggregation grain.
- Be explicit about GROUP BY logic.
- Avoid accidental duplication caused by joins.
- This query should be suitable as input for trending or control charts.
- This exercise builds on the data model and database created in Exercise_1.
====================================================
*/

select b.batch_id, 
count(r.result_value) as n_results,       /* Every key figure needs an explicit name */
avg(r.result_value) as avg_result_value,
min(r.result_value) as min_result_value, 
max(r.result_value) as max_result_value 
from results r

join samples s on r.sample_id = s.sample_id
join batches b on s.batch_id = b.batch_id

where r.result_status = 'approved'
group by b.batch_id; /* tells SQL to collapse all approved result rows belonging to the same batch into one batch-level row, 
                        and to compute the aggregate statistics per batch instead of per result */
