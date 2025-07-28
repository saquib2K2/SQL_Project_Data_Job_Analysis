-- what are the skills required for  top paying data analyst role ?
-- -use this top 10 highest-paying Data Analyst  jobs from first query 
-- - Add the specific  skills  required  for  these roles 
-- - Why? It provides a detailed look at which high paying jobs demand certainn skills,
--  helping job seekers understand  which skills to develop that align with top salaries 


WITH top_paying_jobs AS (
SELECT
    job_id,
    name AS company_name,
    job_title,
    salary_year_avg
FROM job_postings_fact AS job_posting
LEFT JOIN 
    company_dim ON job_posting.company_id = company_dim.company_id
WHERE
    job_posting.job_location = 'Anywhere' AND
    job_posting.job_title_short = 'Data Analyst' AND
    job_posting.salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills_job_dim.skill_id,
    skills
FROM top_paying_jobs
INNER JOIN 
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC