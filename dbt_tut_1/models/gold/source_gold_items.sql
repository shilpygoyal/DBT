WITH dedup_query as 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY id ORDER BY updateDate DESC) as dedup
FROM 
    {{source('source','items')}}
)
SELECT 
    id,item_name,category,updateDate
FROM
    dedup_query
where 
    dedup = 1
