--We want the skills associated with the highest paying jobs

with top_paying_jobs as (
    select job_id, name as company_name, job_title, salary_year_avg
    from job_postings_fact
    left join company_dim on company_dim.company_id = job_postings_fact.company_id
    where 
        job_title_short = 'Data Analyst' AND
        salary_year_avg is not null AND
        job_location = 'Anywhere'
    order by salary_year_avg desc
    limit 10
)
select 
    top_paying_jobs.*, skills
from 
    top_paying_jobs
inner join skills_job_dim on skills_job_dim.job_id = top_paying_jobs.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id;

-- to generate table of top 15 highest paid job skills

with skills_count as(
    with top_paying_jobs as (
        select job_id, name, job_title, salary_year_avg
        from job_postings_fact
        left join company_dim on company_dim.company_id = job_postings_fact.company_id
        where 
            job_title_short = 'Data Analyst' AND
            salary_year_avg is not null AND
            job_location = 'Anywhere'
        order by salary_year_avg desc
        limit 10
    )
select 
    top_paying_jobs.*, skills
from 
    top_paying_jobs
inner join skills_job_dim on skills_job_dim.job_id = top_paying_jobs.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id)

select skills, count(Skills) as count
from skills_count
group by skills
order by count desc
limit 10;

