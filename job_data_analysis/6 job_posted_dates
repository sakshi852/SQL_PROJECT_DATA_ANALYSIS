/*What are the demands of data analyst jobs in each month*/


select 
    TO_CHAR(job_posted_date, 'Mon') AS Month,
    count (job_id) as jobs_posted,
    round(avg(job_postings_fact.salary_year_avg),0) as avg_salary
from job_postings_fact
where 
    (extract (year from job_posted_date)) =2023
    and job_title_short = 'Data Analyst' 
    and salary_year_avg is not null 
    AND job_location = 'Anywhere'
group by extract(month from job_posted_date),Month
order by extract(month from job_posted_date)
