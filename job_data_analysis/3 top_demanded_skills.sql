/* What are the most in-demand skills for Data analyst*/

select 
    skills, 
    count(skills_job_dim.job_id) as demand_skills
FROM 
    job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where 
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    and salary_year_avg is not null
group by skills
order by demand_skills desc
limit 10;