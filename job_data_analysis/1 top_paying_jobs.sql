/*what are the top paying Data analyst jobs*/

select 
    job_id, 
    name as company_name,  
    job_title, 
    salary_year_avg,
    job_schedule_type, 
    posted_date
from job_postings_fact
left join company_dim on company_dim.company_id = job_postings_fact.company_id
where 
    job_title_short = 'Data Analyst' AND
    salary_year_avg is not null AND
    job_location = 'Anywhere'
order by salary_year_avg desc
limit 10

