 ---------------------------KPIS----------------------

--1 — Average Sleep Hours

SELECT 
    ROUND(AVG(avg_sleep_hours), 2) AS avg_sleep_hours
FROM Fact_User_Metrics;


---
-- 2 — Average Digital Wellbeing Score

SELECT 
    ROUND(AVG(digital_wellbeing_score), 2) AS avg_digital_wellbeing
FROM Fact_User_Metrics;


---
-- 3— Average Social Media Addiction Risk

SELECT 
    ROUND(AVG(sm_addiction_risk_score), 2) AS avg_addiction_risk
FROM Fact_User_Metrics;



-- 1. How does average sleep duration vary with daily social media usage?

SELECT 
    CASE 
        WHEN avg_daily_sm_hours < 3 THEN 'Low Usage' 
        WHEN avg_daily_sm_hours < 6 THEN 'Medium Usage' 
        ELSE 'High Usage' 
    END AS social_media_usage_level, 
    
    ROUND(AVG(avg_sleep_hours), 2) AS avg_sleep_hours

FROM Fact_User_Metrics 

GROUP BY 
    CASE 
        WHEN avg_daily_sm_hours < 3 THEN 'Low Usage' 
        WHEN avg_daily_sm_hours < 6 THEN 'Medium Usage' 
        ELSE 'High Usage' 
    END 

ORDER BY avg_sleep_hours DESC;

---
-- 2. Is late-night scrolling associated with lower sleep quality?

SELECT 
    s.late_night_scrolling,
    m.sleep_quality,
    COUNT(*) AS number_of_participants
FROM SocialMedia_Habits s
JOIN Mental_Detox m
    ON s.participant_id = m.participant_id
GROUP BY 
    s.late_night_scrolling,
    m.sleep_quality
ORDER BY 
    s.late_night_scrolling,
    number_of_participants DESC;


---
-- 3. Does screen time vary across sleep-quality levels?

SELECT 
    md.sleep_quality,
    ROUND(AVG(m.avg_daily_screen_time_hours), 2) AS avg_screen_time_hours
FROM Mental_Detox md
JOIN Fact_User_Metrics m
    ON md.participant_id = m.participant_id
GROUP BY md.sleep_quality
ORDER BY avg_screen_time_hours DESC;


---

-- 4. Is mental fog more frequent among people with higher social media usage?

SELECT 
    CASE
        WHEN m.avg_daily_sm_hours < 3 THEN 'Low Usage'
        WHEN m.avg_daily_sm_hours < 6 THEN 'Medium Usage'
        ELSE 'High Usage'
    END AS social_media_usage_level,
    
    md.mental_fog_frequency,
    COUNT(*) AS number_of_participants

FROM Fact_User_Metrics m

JOIN Mental_Detox md
    ON m.participant_id = md.participant_id

GROUP BY 
    CASE
        WHEN m.avg_daily_sm_hours < 3 THEN 'Low Usage'
        WHEN m.avg_daily_sm_hours < 6 THEN 'Medium Usage'
        ELSE 'High Usage'
    END,
    md.mental_fog_frequency

ORDER BY 
    social_media_usage_level,
    number_of_participants DESC;


---

-- 5. Is irritability when offline associated with social media addiction risk?

SELECT 
    md.irritability_when_offline,
    ROUND(AVG(m.sm_addiction_risk_score), 2) AS avg_addiction_risk
FROM Fact_User_Metrics m
JOIN Mental_Detox md
    ON m.participant_id = md.participant_id
GROUP BY md.irritability_when_offline
ORDER BY avg_addiction_risk DESC;


---

-- 6. Is boredom-to-phone reflex associated with addiction risk?

SELECT 
    md.boredom_to_phone_reflex,
    ROUND(AVG(m.sm_addiction_risk_score), 2) AS avg_addiction_risk
FROM Fact_User_Metrics m
JOIN Mental_Detox md
    ON m.participant_id = md.participant_id
GROUP BY md.boredom_to_phone_reflex
ORDER BY avg_addiction_risk DESC;

---

-- 7. How does digital wellbeing score vary across social media usage levels?

SELECT 
    CASE
        WHEN avg_daily_sm_hours < 3 THEN 'Low Usage'
        WHEN avg_daily_sm_hours < 6 THEN 'Medium Usage'
        ELSE 'High Usage'
    END AS social_media_usage_level,
    
    ROUND(AVG(digital_wellbeing_score), 2) AS avg_digital_wellbeing_score

FROM Fact_User_Metrics

GROUP BY 
    CASE
        WHEN avg_daily_sm_hours < 3 THEN 'Low Usage'
        WHEN avg_daily_sm_hours < 6 THEN 'Medium Usage'
        ELSE 'High Usage'
    END

ORDER BY avg_digital_wellbeing_score DESC;

---

