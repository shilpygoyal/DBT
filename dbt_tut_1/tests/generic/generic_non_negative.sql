{%test generic_non_negative(model,column_name)%}


select  
    *
FROM 
    {{model}}
where {{column_name}} < 0

{%endtest%}