------KPIS----

--1 Average Productivity Self-Rating
SELECT 
    ROUND(AVG(productivity_self_rating), 2) AS avg_productivity
FROM Fact_User_Metrics;

        ------------------------------------------------------------------

--2 Average Deep Work Duration
SELECT 
    ROUND(AVG(deep_work_duration_minutes), 2) AS avg_deep_work
FROM Fact_User_Metrics;

        ----------------------------------------------------------------

--3 Average Tasks Completed Per Day
SELECT 
    ROUND(AVG(tasks_completed_per_day), 2) AS avg_tasks_completed
FROM Fact_User_Metrics;


      ---------------------------------------TOPIC 2-----------------------------------------------

--1️ Does higher daily social media usage relate to lower productivity?
SELECT 
    CASE
        WHEN avg_daily_sm_hours < 3 THEN 'Low Usage'
        WHEN avg_daily_sm_hours < 6 THEN 'Medium Usage'
        ELSE 'High Usage'
    END AS social_media_usage_level,
    
  ROUND(  AVG(CAST(productivity_self_rating AS FLOAT)),2) AS avg_productivity_rating

FROM Fact_User_Metrics

GROUP BY 
    CASE
        WHEN avg_daily_sm_hours < 3 THEN 'Low Usage'
        WHEN avg_daily_sm_hours < 6 THEN 'Medium Usage'
        ELSE 'High Usage'
    END

ORDER BY avg_productivity_rating DESC;

       -----------------------------------------------------------------------

--2️ How does average screen time vary across productivity decline levels?
SELECT
    productivity_self_rating,
    ROUND(AVG(avg_daily_screen_time_hours), 2) AS avg_screen_time
FROM Fact_User_Metrics
GROUP BY productivity_self_rating
ORDER BY avg_screen_time DESC;

                 -------------------------------------------------------------

--3️ Is social media use during work/study associated with productivity decline?

SELECT 
    sm_during_work_study,
    productivity_decline_score,
    COUNT(*) AS participants
FROM SocialMedia_Habits s
JOIN Productivity_Cognition p
    ON s.participant_id = p.participant_id
GROUP BY 
    sm_during_work_study,
    productivity_decline_score
ORDER BY sm_during_work_study, participants DESC;

             -------------------------------------------------------------

--4️ Does higher task-switching frequency relate to greater productivity decline?

SELECT 
    task_switching_frequency,
    productivity_decline_score,
    COUNT(*) AS participants
FROM Productivity_Cognition
GROUP BY 
    task_switching_frequency,
    productivity_decline_score
ORDER BY task_switching_frequency;

             -----------------------------------------------------------------------
 
  --5️ How does difficulty maintaining focus vary with social media usage?
SELECT 
    CASE
        WHEN avg_daily_sm_hours < 4 THEN 'Low'
        WHEN avg_daily_sm_hours < 5.5 THEN 'Medium'
        WHEN avg_daily_sm_hours < 6.5 THEN 'High'
        ELSE 'Very High'
    END AS usage_level,
    difficulty_maintaining_focus,
    COUNT(*) AS participants
FROM Fact_User_Metrics f
JOIN Productivity_Cognition p
    ON f.participant_id = p.participant_id
GROUP BY 
    CASE
        WHEN avg_daily_sm_hours < 4 THEN 'Low'
        WHEN avg_daily_sm_hours < 5.5 THEN 'Medium'
        WHEN avg_daily_sm_hours < 6.5 THEN 'High'
        ELSE 'Very High'
    END,
    difficulty_maintaining_focus;
 
                -----------------------------------------------------------------

--6 Does deep-work duration decrease as social media usage increases?

SELECT 
    CASE
        WHEN avg_daily_sm_hours < 4 THEN 'Low'
        WHEN avg_daily_sm_hours < 5.5 THEN 'Medium'
        WHEN avg_daily_sm_hours < 6.5 THEN 'High'
        ELSE 'Very High'
    END AS usage_level,
    ROUND(AVG(deep_work_duration_minutes), 2) AS avg_deep_work
FROM Fact_User_Metrics
GROUP BY 
    CASE
        WHEN avg_daily_sm_hours < 4 THEN 'Low'
        WHEN avg_daily_sm_hours < 5.5 THEN 'Medium'
        WHEN avg_daily_sm_hours < 6.5 THEN 'High'
        ELSE 'Very High'
    END
ORDER BY avg_deep_work DESC;

              -----------------------------------------------------------

--7 How does attention span vary across different social media usage levels?

SELECT 
    CASE
        WHEN avg_daily_sm_hours < 4 THEN 'Low'
        WHEN avg_daily_sm_hours < 5.5 THEN 'Medium'
        WHEN avg_daily_sm_hours < 6.5 THEN 'High'
        ELSE 'Very High'
    END AS usage_level,
    ROUND(AVG(attention_span_minutes), 2) AS avg_attention_span
FROM Fact_User_Metrics
GROUP BY 
    CASE
        WHEN avg_daily_sm_hours < 4 THEN 'Low'
        WHEN avg_daily_sm_hours < 5.5 THEN 'Medium'
        WHEN avg_daily_sm_hours < 6.5 THEN 'High'
        ELSE 'Very High'
    END
ORDER BY avg_attention_span DESC;

              -----------------------------------------------------------------------------



            
