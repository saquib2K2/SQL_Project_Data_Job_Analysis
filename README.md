
# Introduction
Focusing on data-related roles, this project dives deep into job postings data to answer key questions using SQL. From 💰 top-paying jobs to 🔥 in-demand skills and 📍 remote work trends, each query uncovers meaningful insights into where opportunity meets demand in the data industry.

🔍 SQL queries? Check them out here: add link 


## Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born out of a desire to pinpoint top-paying roles and the most in-demand skills. Using SQL to analyze job postings, it aims to streamline the job search process and uncover where high demand meets high reward.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?









## Tools I Used

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
## The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

**1. What are the top-paying data analyst jobs?** 
```
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
```
Here’s the breakdown of the top paying jobs in 2023:

* **Wide Salary Range:** The top 10 remote data analyst roles offer salaries ranging from $184,000 to $650,000, highlighting the high earning potential in the analytics field.

* **Diverse Employers:** High-paying roles are offered by a mix of companies including Mantys, Meta, AT&T, Pinterest, and SmartAsset, showing that both startups and tech giants invest heavily in data talent.

* **Job Title Variety:** Titles range from Data Analyst to Director of Analytics and Principal Data Analyst, reflecting different levels of responsibility and specialization within the analytics domain.

* **Remote Work Flexibility:** All listed roles are remote and full-time, indicating a strong shift toward location-independent data roles across industries.

* **Consistent Hiring Throughout the Year:** Job postings are spread from January to December 2023, suggesting steady demand for data professionals without seasonal drops.

Add chart

Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results

**2.What skills are required for these top-paying jobs?**
```
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
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

* SQL is leading with a bold count of 8.
* Python follows closely with a bold count of 7.
* Tableau is also highly sought after, with a bold count of 6. Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.

Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results


**3.In-Demand Skills for Data Analysts**
```
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
```
Here's the breakdown of the most demanded skills for data analysts in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Here's a breakdown of the results for top paying skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I Learned
* **🔍 Advanced Querying Skills:** Gained hands-on experience writing complex SQL queries, effectively using JOINs and Common Table Expressions (WITH clauses) for better readability and modular logic.

* **📈 Data Aggregation & Summarization:** Strengthened my ability to group and summarize data using functions like COUNT(), AVG(), and GROUP BY to extract meaningful insights.

* **🧠 Real-World Analytical Thinking:** Improved my problem-solving capabilities by translating business questions into optimized, insight-driven SQL queries.

 # Conclusion
**🔍 Key Insights**
* Remote Roles with High Salaries: Remote data analyst positions offer lucrative opportunities, with top roles paying as much as $650,000, indicating strong earning potential.

* Essential Skill – SQL: A consistent trend among high-paying jobs is the requirement for advanced SQL skills, reinforcing its value in the field.

* Most Frequently Sought Skill: SQL also appears most often in job listings, showing its critical role in data analysis careers.

* Niche Skills Yield Higher Pay: Tools like SVN and Solidity, while less common, command higher average salaries—suggesting that rare expertise is well rewarded.

* Strategic Skill Focus: Combining demand and earning potential, SQL stands out as a strategic skill for analysts aiming to boost their marketability and compensation.

# Final Reflection
This project deepened my understanding of SQL and provided a clearer picture of the data analyst job landscape. By identifying which skills correlate with higher salaries and demand, I can better focus my efforts on continuous improvement. For aspiring data analysts, staying aligned with industry trends and upskilling in high-impact areas is key to standing out in today’s competitive market.