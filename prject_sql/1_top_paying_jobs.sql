-- What are the top paying data analyst-jobs?
-- -Identify the  top 10 highest-paying data Analyst roles that are available remotely.
-- -Focuses on job postings with specified salaries (remove null)
-- -why? Hilight the top paying opportunities for Data Analyst, offering insights into employment opportunities


SELECT
    job_id,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    job_posted_date,
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