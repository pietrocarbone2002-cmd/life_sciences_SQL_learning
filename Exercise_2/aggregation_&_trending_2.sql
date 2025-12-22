/*
====================================================
SQL Exercise – QC / MSAT Industrial Context
Aggregation & Trending – Part 2: Campaign-Level Trending
====================================================

Context:
You are working in an MSAT / Process Analytics role.
Batch-level statistics have already been derived from approved assay
results.

In this step, trending is extended beyond simple batch-to-batch
comparison by explicitly introducing a business-relevant segmentation:
manufacturing campaigns.

Campaign-based trending is commonly used in MSAT to:
- detect process shifts between campaigns
- assess process consistency over time
- support CPV and continued verification activities

Task:
1. Select approved assay results and join all required contextual tables.
2. Aggregate results to batch level.
3. Extend the aggregation by campaign.
4. Calculate batch-level statistics per campaign:
   - number of results
   - average result value
   - minimum result value
   - maximum result value
5. Define a batch-level time reference suitable for trending.
6. Order the results chronologically within each campaign.

Expected Output:
- One row per batch per campaign
- Columns:
  - campaign
  - batch_id
  - batch_time_reference
  - n_results
  - avg_result_value
  - min_result_value
  - max_result_value

Notes:
- Campaign must be treated as an explicit analytical dimension.
- Aggregation grain must be clearly justified.
- The output should allow comparison:
  - within a campaign
  - across campaigns
====================================================
*/

select b.batch_id, 
count(r.result_value) as n_results,     
avg(r.result_value) as avg_result_value,
min(r.result_value) as min_result_value, 
max(r.result_value) as max_result_value 
from results r

join samples s on r.sample_id = s.sample_id
join batches b on s.batch_id = b.batch_id

where r.result_status = 'approved'
group by b.batch_id;
