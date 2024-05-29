with skills_demand as (
    select 
        skills_dim.skill_id,
        skills, 
        count(skills_job_dim.job_id) as demand
    FROM job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id 
    where 
        job_title_short = 'Data Analyst' 
        and salary_year_avg is not null
    group by skills_dim.skill_id
),

average_salary as (
    select 
        skills_dim.skill_id, 
        skills,
        avg(salary_year_avg) as avg_salary
    FROM job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id 
    where 
        job_title_short = 'Data Analyst' 
        and salary_year_avg is not null
    group by skills_dim.skill_id
)

select skills_demand.skill_id,
    skills_demand.skills,
    demand,
    avg_salary
from skills_demand
inner join average_salary on skills_demand.skill_id=average_salary.skill_id