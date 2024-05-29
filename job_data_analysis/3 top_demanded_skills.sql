/* What are the most in-demand skills for data analyst*/

select skills, count(skills_job_dim.job_id) as demand
FROM job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where job_title_short = 'Data Analyst'
group by skills
order by demand desc
limit 5