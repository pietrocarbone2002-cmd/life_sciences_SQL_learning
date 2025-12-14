create table batches(
    batch_id text PRIMARY KEY, 
    product_code text, 
    campaign text, 
    manufacture_date timestamp  
);

create table samples(
    sample_id integer PRIMARY KEY, 
    batch_id text, 
    sample_type text, 
    sample_time timestamp
);

create table results(
    result_id text PRIMARY KEY, 
    sample_id integer, 
    test_name text, 
    result_value float, 
    result_unit text, 
    result_status text
);