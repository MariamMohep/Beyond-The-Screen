
--------------------Topic 1 — Social Media Usage & Habits--------------------
--1. Average daily social media usage by age group
SELECT 
    p.age_group,
    AVG(m.avg_daily_sm_hours) AS avg_daily_social_media_hours
FROM Participant p
JOIN Fact_User_Metrics m
    ON p.participant_id = m.participant_id
GROUP BY p.age_group
ORDER BY avg_daily_social_media_hours DESC;


--2. Which social media platform is the most preferred?
SELECT 
    primary_platform,
    COUNT(*) AS number_of_users
FROM SocialMedia_Habits
GROUP BY primary_platform
ORDER BY number_of_users DESC;


--3. How frequently do users check social media across different primary platforms?
SELECT 
    primary_platform,
    daily_check_frequency,
    COUNT(*) AS number_of_participants
FROM SocialMedia_Habits
GROUP BY 
    primary_platform,
    daily_check_frequency
ORDER BY 
    primary_platform,
    number_of_participants DESC;

--4. How does first-check-of-day behavior vary by age group?
SELECT 
    p.age_group,
    s.first_check_of_day,
    COUNT(*) AS number_of_participants
FROM Participant p
JOIN SocialMedia_Habits s
    ON p.participant_id = s.participant_id
GROUP BY 
    p.age_group,
    s.first_check_of_day
ORDER BY 
    p.age_group,
    number_of_participants DESC;

--5. How common is late-night scrolling across participants?
SELECT 
    late_night_scrolling,
    COUNT(*) AS number_of_participants,
    CONCAT(
        CAST(
            COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()
            AS DECIMAL(5,2)
        ),
        '%'
    ) AS percentage
FROM SocialMedia_Habits
GROUP BY late_night_scrolling
ORDER BY number_of_participants DESC;


--6. Which content types are consumed most frequently?
SELECT TOP(10) 
    content_type_consumed,
    COUNT(*) AS number_of_participants
FROM SocialMedia_Habits
GROUP BY content_type_consumed
ORDER BY number_of_participants DESC;



--7. How frequently do people scroll without a specific purpose?
SELECT 
    scroll_without_purpose,
    COUNT(*) AS number_of_participants,
    CAST(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()
        AS DECIMAL(5,2)
    ) AS percentage
FROM SocialMedia_Habits
GROUP BY scroll_without_purpose
ORDER BY number_of_participants DESC;

--8. What percentage of participants keep notifications always on?
SELECT 
    CASE 
        WHEN notifications_always_on = 1 THEN 'Notifications On'
        WHEN notifications_always_on = 0 THEN 'Notifications Off'
    END AS notifications_status,
    
    COUNT(*) AS number_of_participants,
    
    Concat (CAST(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()
        AS DECIMAL(5,2) ) , '%'
    ) AS percentage

FROM SocialMedia_Habits
GROUP BY notifications_always_on
ORDER BY number_of_participants DESC;


--9. How does social media usage during work/study vary by employment status?
SELECT 
    p.employment_status,
    s.sm_during_work_study,
    COUNT(*) AS number_of_participants
FROM Participant p
JOIN SocialMedia_Habits s
    ON p.participant_id = s.participant_id
GROUP BY 
    p.employment_status,
    s.sm_during_work_study
ORDER BY 
    number_of_participants DESC;

--10. Is doomscrolling more frequent among people with higher daily social media usage?
SELECT 
    CASE
        WHEN f.avg_daily_sm_hours < 3 THEN 'Low'
        WHEN f.avg_daily_sm_hours < 6 THEN 'Medium'
        ELSE 'High'
    END AS social_media_usage_level,
    s.doomscrolling_frequency,
    COUNT(*) AS number_of_participants
FROM Fact_User_Metrics f
JOIN SocialMedia_Habits s
    ON f.participant_id = s.participant_id
GROUP BY 
    CASE
        WHEN f.avg_daily_sm_hours < 3 THEN 'Low'
        WHEN f.avg_daily_sm_hours < 6 THEN 'Medium'
        ELSE 'High'
    END,
    s.doomscrolling_frequency
ORDER BY 
    social_media_usage_level,
    number_of_participants DESC;