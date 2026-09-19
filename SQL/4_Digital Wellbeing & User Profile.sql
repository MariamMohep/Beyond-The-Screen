-------------KPIS---------------

--1. Average Social Media Addiction Risk
SELECT 
    ROUND(AVG(sm_addiction_risk_score), 2) AS avg_addiction_risk
FROM Fact_User_Metrics;

--2. Average Digital Wellbeing Score
SELECT 
    ROUND(AVG(digital_wellbeing_score), 2) AS avg_digital_wellbeing
FROM Fact_User_Metrics;

--3. Average Daily Screen Time
SELECT 
    ROUND(AVG(avg_daily_screen_time_hours), 2) AS avg_screen_time_hours
FROM Fact_User_Metrics;


-----------------Questions--------------------

--1. How does social media addiction risk vary by age group?
SELECT 
    p.age_group,
    AVG(m.sm_addiction_risk_score) AS avg_addiction_risk
FROM Participant p
JOIN Fact_User_Metrics M
    ON p.participant_id = m.participant_id
GROUP BY p.age_group
ORDER BY avg_addiction_risk DESC;

--2. How does digital wellbeing score vary by age group?
SELECT 
    p.age_group,
    AVG(m.digital_wellbeing_score) AS avg_digital_wellbeing_score
FROM Participant p
JOIN Fact_User_Metrics m
    ON p.participant_id = m.participant_id
GROUP BY p.age_group
ORDER BY avg_digital_wellbeing_score DESC;

--3. Does gender show differences in social media addiction risk?
SELECT 
    p.gender,
    AVG(m.sm_addiction_risk_score) AS avg_addiction_risk
FROM Participant p
JOIN Fact_User_Metrics m
    ON p.participant_id = m.participant_id
GROUP BY p.gender
ORDER BY avg_addiction_risk DESC;



--4. How does digital wellbeing vary by education level?
SELECT 
    p.education_level,
    AVG(m.digital_wellbeing_score) AS avg_digital_wellbeing_score
FROM Participant p
JOIN Fact_User_Metrics m
    ON p.participant_id = m.participant_id
GROUP BY p.education_level
ORDER BY avg_digital_wellbeing_score DESC;


--5. Which occupation categories have the highest average screen time?
SELECT 
    p.occupation_category,
    AVG(m.avg_daily_screen_time_hours) AS avg_screen_time_hours
FROM Participant p
JOIN Fact_User_Metrics m
    ON p.participant_id = m.participant_id
GROUP BY p.occupation_category
ORDER BY avg_screen_time_hours DESC;

--6 Does relationship status relate to social media usage?
SELECT 
    p.relationship_status,
    AVG(m.avg_daily_sm_hours) AS avg_social_media_hours
FROM Participant p
JOIN Fact_User_Metrics m
    ON p.participant_id = m.participant_id
GROUP BY p.relationship_status
ORDER BY avg_social_media_hours DESC;

--7. How does mental fog frequency vary across age groups?
SELECT 
    p.age_group,
    md.mental_fog_frequency,
    COUNT(*) AS number_of_participants
FROM Participant p
JOIN Mental_Detox md
    ON p.participant_id = md.participant_id
GROUP BY 
    p.age_group,
    md.mental_fog_frequency
ORDER BY 
    p.age_group,
    number_of_participants DESC;

 
