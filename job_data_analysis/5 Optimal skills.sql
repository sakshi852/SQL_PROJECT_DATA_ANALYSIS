/* What are top optimal skills*/

select
    skills_dim.skill_id,
    skills_dim.skills, 
    count(skills_job_dim.job_id) as demand,
    avg(salary_year_avg) as avg_salary
FROM job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id 
    where 
        job_title_short = 'Data Analyst'
        and salary_year_avg is not null
group by skills_dim.skill_id
HAVING count(skills_job_dim.job_id)>10
order by 
    avg_salary DESC,
    demand DESC    
limit 25;
