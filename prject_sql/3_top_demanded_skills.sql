-- what are the most in-demand skills for data analyst?
-- -join job postings to innner join  table similar to query 2.
-- -Identify the top 5 indemand skills for data analyst
-- why? Retrives the top 5  in demand skills in job market 
--      provides insights into the most valuable skills for job seekers

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_skills
FROM
    job_postings_fact AS job_posting
INNER JOIN 
    skills_job_dim ON job_posting.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_posting.job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_skills DESC
LIMIT 10;