/* what are the top paying skills for Data analyst role*/

select 
    skills, 
    round(avg(job_postings_fact.salary_year_avg),0) as avg_salary
FROM 
    job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where 
    job_title_short = 'Data Analyst' 
    and salary_year_avg is not null 
    AND job_location = 'Anywhere'
group by skills
order by avg_salary desc
limit 30