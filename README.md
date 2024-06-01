This project contains below mentioned 5 sections:
- Introduction
- Background
- Tools used
- Analysis
- Conclusion

# Introduction

📊 **Data Analyst Roles Exploration Project**

This project focuses on exploring Data Analyst roles, with an emphasis on identifying the top-paying jobs, in-demand skills, and optimal skills where high salary meets high demand. Through a series of SQL queries, we analyze job postings to uncover valuable insights into the current job market for Data Analysts. The SQL queries used in this project help to illuminate the intersection of high-paying roles and the most sought-after skills in the field.

🔍 **Key Objectives**:
- Identify top-paying jobs for Data Analysts
- Discover the most in-demand skills
- Find the optimal skills where high salary meets high demand
- Checking the demands of data analyst jobs in each month

🔗 **Check the SQL queries here**: [📂 Job Data Analysis](/job_data_analysis/)



# Background

🗺️ **Navigating the Data Analyst Job Market**

This project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others' work to find optimal jobs. By navigating the data analyst job market, we aim to provide valuable insights that can assist in career planning and development.

📊 **Data Source**: The data hails from [lukebarousse.com/sql](https://lukebarousse.com/sql). It is packed with insights on job titles, salaries, locations, skills, and more.

### Analyzed Questions
These are the questions that I answered through the queries:

1. 📊 **What are the top-paying data analyst jobs?**
2. 🛠️ **What skills are required for these jobs?**
3. 💼 **What are the most in-demand skills for data analysts?**
4. 💰 **Which skills correlate with higher salaries?**
5. 💡 **What are the most optimal skills that combine high salary and demand?**

# Tools Used
- **SQL**: Executed SQL queries to analyze the dataset.
- **PostgreSQL**: Managed the database where the dataset was stored.
- **Visual Studio Code**: Wrote and edited SQL queries and project files.
- **Git and GitHub**: Version control system used to track changes in project files and hosted the project repository and facilitated collaboration and sharing.

# Analysis

1. **What are the top-paying data analyst jobs?**

```sql
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
```

📊 **Key Insights**:
- **Wide Salary Range**: Top-paying data analyst jobs range from $184,000 to $650,000 per year, indicating significant variability based on role and company.

- **Diverse Employers**: High salaries are offered by a variety of companies across industries:
  * Tech: Meta, Pinterest Job Advertisements, Motional
  * Telecom: AT&T
  * Finance: SmartAsset
  * Healthcare: Uclahealthcareers
  * Inclusion and IT: Inclusively, Get It Recruit - Information Technology
- **Job Title Varieties**
High-paying roles include traditional data analysts, senior positions like Directors and Principal Analysts, and specialized roles such as Marketing Analysts and AV Performance Analysts.


![Top Paying Data Analyst Jobs and Average Salary](assets\Gemini_Chart_Image_45ioil45ioil45io.png)
*Bar chart visualizing the salary for the top 10 data analyst jobs, Gemini Ai generated this chart using my sql query results*


2. **What skills are required for these jobs?**
```sql
with top_paying_jobs as (
    select job_id, name as company_name, job_title,     salary_year_avg
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
```

📊 **Key Insights**:

- **Skill Demand Across High-Paying Jobs**: 
The data indicates that certain skills are consistently in high demand for well-paying roles:

  * *SQL and Python*: These programming languages appear frequently a cross multiple job listings, highlighting their importance in data-related roles.
  * *Data Visualization Tools*: Tableau and Excel are common, suggesting a need for strong data presentation capabilities.
  * *Cloud and Big Data Platforms*: Skills in Azure, AWS, Databricks, and Snowflake are valued, reflecting the trend towards cloud computing and big data analytics.

 - **Diversity of Tools and Technologies**: 
The job listings reflect a diverse range of tools and technologies that employers are seeking:

   * *Broad Skill Set*: High-paying jobs often require a mix of programming languages, data tools, and cloud platforms, suggesting that versatility and a broad skill set are highly valued.
   * *Emerging Technologies*: The inclusion of tools like PySpark, Jupyter, and Pandas indicates a demand for skills in handling large datasets and performing advanced analytics.
   * *Traditional Tools*: Despite the emphasis on new technologies, traditional tools like Excel and PowerPoint remain relevant, showing that foundational skills are still necessary alongside modern tech competencies.

![Top Paying Data Analyst Jobs-skills](.job_data_analysis\assets\Gemini_Chart_Image_e5y49ne5y49ne5y4.png)

*Bar chart visualizing the skills associated with the top paying data analyst jobs, Gemini Ai generated this chart using my sql query results*

3. **What are the most in-demand skills for Data analyst?**
```sql
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

group by skills
order by demand_skills desc
limit 10;
```

📊 **Key Insights**:

The most in-demand skills for data analysts, irrespective of salary, include SQL, Excel, Python, and Tableau, with SQL being the most sought-after skill, followed by Excel, Python, and Tableau, indicating a strong emphasis on data management, analysis, and visualization capabilities.


![Most in-demand skills](job_data_analysis\assets\Code_Generated_Image.png)


*Bar chart visualizing the most in-demand skills for data analyst jobs, Gemini Ai generated this chart using my sql query results*


4. **what are the top paying skills for Data analyst role?**

```sql
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
```

📊 **Key Insights**:

* **High Demand for Emerging and Specialized Technologies**: Skills in new and advanced tools like PySpark, Bitbucket, and DataRobot command the highest salaries, indicating a premium on cutting-edge technology expertise.

* **Value of Data Science and Machine Learning Proficiency**: Competence in data science and machine learning tools such as Jupyter, Pandas, NumPy, and Scikit-learn is highly valued, reflecting the industry's focus on data-driven decision-making and predictive modeling.

* **Importance of Cloud and Collaboration Tools**: Expertise in cloud platforms like GCP and Databricks, as well as collaboration and CI/CD tools like Gitlab and Jenkins, is well-compensated, highlighting the shift towards scalable cloud solutions and integrated, agile workflows.

| Skill          | Average Salary ($) |
|----------------|--------------------|
| pyspark        | 208,173            |
| bitbucket      | 189,155            |
| watson         | 160,515            |
| couchbase      | 160,515            |
| datarobot      | 155,486            |
| gitlab         | 154,500            |
| swift          | 153,750            |
| jupyter        | 152,777            |
| pandas         | 151,821            |
| golang         | 145,000            |


5. **What are top optimal skills for Data Analyst Roles?**

```sql
select
    skills_dim.skill_id,
    skills_dim.skills, 
    type,
    count(skills_job_dim.job_id) as demand,
    avg(salary_year_avg) as avg_salary
FROM job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id 
    where 
        job_title_short = 'Data Analyst'
        and salary_year_avg is not null
        AND job_location = 'Anywhere'
group by skills_dim.skill_id
HAVING count(skills_job_dim.job_id)>5
order by 
    avg_salary DESC,
    demand DESC    
```

📊 **Key Insights**:

* **High-Demand Libraries**: Libraries like Pandas and Databricks are essential for data manipulation and analysis, as evidenced by their strong demand (9 and 10, respectively). Despite the relatively low demand compared to other skills, they command high average salaries, indicating their critical role in data analytics projects.

* **Cloud Technologies**: Azure and AWS are prominent cloud platforms extensively used for data storage, processing, and analysis. With significant demand (34 for Azure and 32 for AWS), professionals proficient in these platforms can expect lucrative salaries, reflecting the high value placed on cloud expertise in the data analytics field.

* **Programming Skills**: Python and R continue to dominate the programming landscape in data analytics. Python, with its versatility and extensive library support, boasts a staggering demand of 236 and an average salary exceeding $100,000. R, known for its statistical capabilities, also enjoys substantial demand (148) and offers competitive salaries.

* **Analyst Tools**: Excel and Tableau are indispensable tools for data visualization and analysis. Excel's widespread use across industries is reflected in its high demand (256) and respectable average salary. Similarly, Tableau, known for its intuitive visualizations, commands a high average salary, indicating its significance in the analytics toolkit.

* **Specialized Tools**: Power BI and Looker are specialized tools tailored for business intelligence and analytics. Despite a lower demand compared to broader skills like Python and Excel, these tools offer competitive salaries, highlighting the increasing demand for professionals skilled in leveraging specialized analytics platforms to derive insights.

| Skill         | Type           | Demand | Average Salary   |
| ------------- | -------------- | ------ | ---------------- |
| Pandas        | Libraries      | 9      | $151,821         |
| Databricks    | Cloud          | 10     | $141,907         |
| Go            | Programming    | 27     | $115,320         |
| Confluence    | Async          | 11     | $114,210         |
| Hadoop        | Libraries      | 22     | $113,193         |
| Snowflake     | Cloud          | 37     | $112,948         |
| Azure         | Cloud          | 34     | $111,225         |
| BigQuery      | Cloud          | 13     | $109,654         |
| AWS           | Cloud          | 32     | $108,317         |
| Java          | Programming    | 17     | $106,906         |
| SSIS          | Analyst Tools  | 12     | $106,683         |
| Jira          | Async          | 20     | $104,918         |
| Oracle        | Cloud          | 37     | $104,534         |
| DAX           | Analyst Tools  | 10     | $104,500         |
| Looker        | Analyst Tools  | 49     | $103,795         |
| SAP           | Analyst Tools  | 8      | $102,920         |
| NoSQL         | Programming    | 13     | $101,414         |
| Python        | Programming    | 236    | $101,397         |
| R             | Programming    | 148    | $100,499         |
| Redshift      | Cloud          | 16     | $99,936          |

6. **What are the demands of data analyst jobs in each month**

```sql
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
```

📊 **Key Insights**:

* **Seasonal Fluctuations**: There appears to be some seasonal variability in the number of job postings. Months like January, June, and July show higher job postings, possibly due to new fiscal periods or hiring cycles.

* **Salary Variation**: While the number of job postings fluctuates, the average salary also shows some variations. For instance, February and August have relatively higher average salaries compared to other months, indicating potential periods of higher demand or competition for skilled analysts.

* **Stable Demand**: Despite fluctuations, there's a consistent demand throughout the year, with most months having job postings ranging from 32 to 65. This suggests that data analyst roles remain in demand across different seasons and business cycles.

* **End-of-Year Patterns**: Towards the end of the year, from October to December, there's a slight dip in both the number of job postings and average salaries. This might be attributed to factors like budget constraints or companies focusing on closing out the year rather than hiring.

* **Potential Correlation**: While not explicitly stated, there might be a correlation between the number of job postings and average salaries. Months with higher demand, like January and June, might coincide with higher salaries as companies compete for top talent.


![Month wise demand and average salary](job_data_analysis\assets\Screenshot.jpg)
*Bar chart visualizing the demand and line chart visualize the average salary for data analyst jobs in each month, Chatgpt helps me in generating this chart*


# Conclusion

Understanding Data Analyst Job Trends and Optimal Skills

* ***Data Analyst Job Trends***:

The demand for data analyst jobs fluctuates throughout the year, with notable peaks in February, June, and July, while it tends to decrease towards the end of the year.
Average salaries for data analyst positions also vary, showing a general trend of fluctuations but with some months experiencing higher averages than others.

* ***Optimal Skills Analysis***:

The analysis of optimal skills reveals a mix of programming languages, cloud platforms, libraries, and analyst tools.
Python, SQL, R, and JavaScript are among the top programming languages in demand, with Python leading both in demand and average salary.
Cloud platforms like Databricks, Snowflake, Azure, AWS, and BigQuery are highly sought after, indicating the growing importance of cloud computing in data analysis.
Analyst tools such as Tableau, Power BI, Looker, and Excel remain crucial for data visualization and analysis, with Tableau leading in demand and average salary.

* ***Insights***:

Professionals seeking to enter or advance in the data analyst field should prioritize acquiring skills in Python, SQL, and cloud platforms like Databricks and Snowflake.

Additionally, proficiency in popular analyst tools like Tableau and Power BI can significantly enhance job prospects and earning potential.
Continuous learning and staying updated with emerging technologies and tools are essential to remain competitive in the dynamic field of data analysis.
