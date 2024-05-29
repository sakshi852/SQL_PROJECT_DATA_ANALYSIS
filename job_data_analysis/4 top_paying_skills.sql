/* what are the top paying skills for data analyst role*/

select skills, 
    round(avg(job_postings_fact.salary_year_avg),0) as salary
FROM job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where job_title_short = 'Data Analyst' and salary_year_avg is not null
group by skills
order by salary desc
limit 25

/* Insights
-Dominance of Development Tools: High-paying skills like SVN, Solidity, and Golang suggest a strong demand for data analysts proficient in software development and version control tools.
-Rising Importance of AI and ML: Skills related to machine learning frameworks and tools, such as MXNet, Keras, PyTorch, and TensorFlow, feature prominently, reflecting the growing importance of AI and ML in data analytics.
-Cloud and DevOps Tools: The presence of skills like Terraform, VMware, and Ansible among high-paying jobs indicates that knowledge of cloud infrastructure and DevOps practices is increasingly valuable for data analysts.*/