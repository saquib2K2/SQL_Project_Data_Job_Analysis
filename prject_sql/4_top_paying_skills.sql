-- query:- what are the top skills based on salary
-- - look at the avg salary associated with each skill of data analyst job
-- -Focuses on roles with specified salaries, regardless of job_location
-- -Why? It reveles how different skills impact salaries level for data analyst and 
--      help Identify the most financially rewarding skills to acquire or improve

SELECT 
   
   ROUND(AVG(salary_year_avg), 0)AS avg_salary,
   skills_dim.skills
FROM job_postings_fact AS job_posting
INNER JOIN
    skills_job_dim ON job_posting.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL  AND
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25

