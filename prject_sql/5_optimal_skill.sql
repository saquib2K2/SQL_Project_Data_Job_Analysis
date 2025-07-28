-- what are the most optimal skills to learn (aka its high demand and high-paying skills)
-- -Identify skils in high demand and associated with high avg salaries for data analyst role 
-- -concentrate on remote positions with specified salaries 
-- -why? target skills that offers job security (high demand) and financial benifits (high salaries)
--      offering strategic insights for career development in data analysis 



SELECT  
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg),0) AS avg_salaries
FROM job_postings_fact AS job_posting
INNER JOIN
    skills_job_dim ON skills_job_dim.job_id = job_posting.job_id
INNER JOIN
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE AND
    job_title_short = 'Data Analyst'
GROUP BY 
    skills_dim.skill_id
HAVING
   COUNT(skills_job_dim.job_id) > 10
ORDER BY
     avg_salaries DESC,
    demand_count DESC
LIMIT 25;






