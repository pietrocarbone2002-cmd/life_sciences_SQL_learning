/*
====================================================
SQL Exercise – QC / MSAT Industrial Context
====================================================

Context:
You are working in a GMP-regulated pharmaceutical environment.
Laboratory and manufacturing data is stored in a relational database.
Your role is NOT to model data, but to access, filter, and aggregate it
correctly for decision-making (QC trending, MSAT investigations, KPIs).

Assumptions:
- Data is read-only (no INSERT / UPDATE / DELETE).
- Only "approved" results are considered valid unless stated otherwise.
- Business logic matters more than syntactic shortcuts.
- Queries must be reproducible and auditable.

Data Model:
- batches(batch_id, product_code, campaign, manufacture_date)
- samples(sample_id, batch_id, sample_type, sample_time)
- results(result_id, sample_id, test_name, result_value, result_unit, result_status)

Exercise Goal:
Understand how to translate a business question into:
- correct table selection
- correct joins
- correct filtering
- correct aggregation level (grain)

Task:
1. Retrieve all approved assay results for product 'P001'
   within a defined time window.
2. Ensure results are ordered chronologically by sample time.
3. Explicitly select relevant columns (no SELECT *).
4. Make the query easy to review by another engineer.

Expected Output:
- One row per result
- Columns:
  - batch_id
  - sample_id
  - sample_time
  - test_name
  - result_value
  - result_unit

Notes:
- Think carefully about WHERE vs JOIN conditions.
- Be explicit about assumptions.
- Readability matters.
====================================================
*/

/*Part 1: SELECT and JOIN */

select r.result_value, r.result_id, s.sample_id, b.batch_id /* "Aliases (s. r. etc) are a best praxis */
from results r /* Allias is created after FROM. from r.results would be therefore incorrect */

join samples s on r.sample_id = s.sample_id
join batches b on s.batch_id = b.batch_id;  /* ";" only at the end of a statement */

/*Part 2: Filtering and Order chronologically */

where b.product_code = 'P001'    /* "" are not standard. '' are preferred! */
and r.result_status = 'approved'
and r.test_name = 'assay'
order by s.sample_time;

/* Part 3: Select relevant columns */

select b.batch_id, s.sample_id, s.sample_time, r.test_name, r.result_value, r.result_unit

/* Part 3 is a compensation to Part 1. An SQL File has only ONE select */