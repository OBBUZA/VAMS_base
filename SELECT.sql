-- Получить список всех волонтёров с их email
SELECT vol.volunteer_id, vol.name, usr.email
FROM volunteers vol
JOIN users usr ON vol.user_id = usr.user_id;

-- Получить список волонтёров, которые участвуют в мероприятиях
SELECT DISTINCT vol.volunteer_id, vol.name, e.title
FROM volunteers vol
JOIN participation prt ON vol.volunteer_id = prt.volunteer_id
JOIN events e ON prt.event_id = e.event_id;

-- Найти 5 волонтёров с самым высоким рейтингом
SELECT volunteer_id, name, rating
FROM volunteers
ORDER BY rating DESC
LIMIT 5;

-- Найти волонтёров с рейтингом выше среднего по системе
SELECT volunteer_id, name, rating
FROM volunteers
WHERE rating > (SELECT AVG(rating) FROM volunteers);

-- Найти волонтёров, которые подавали заявки, но не участвовали
SELECT DISTINCT vol.volunteer_id, vol.name
FROM volunteers vol
JOIN applications app ON vol.volunteer_id = app.volunteer_id
WHERE NOT EXISTS (
    SELECT * FROM participation prt
    WHERE prt.volunteer_id = vol.volunteer_id
    AND prt.event_id = app.event_id
);

-- Найти мероприятия и организации, которые их проводят(проводят мероприятия)
SELECT ev.event_id, ev.title, ev.date, org.name
FROM events ev
JOIN organizations org ON ev.org_id = org.organizations_id;

-- Посчитать количество участников на каждом мероприятии
SELECT ev.event_id, ev.title, COUNT(prt.participation_id) AS part_count
FROM events ev
LEFT JOIN participation prt ON ev.event_id = prt.event_id
GROUP BY ev.event_id, ev.title;

-- Найти все заявки, которые висят в ожидании
SELECT *
FROM applications
WHERE status = 'pending';

-- Найти у какого статуса сколько заявок
SELECT status, COUNT(*) AS app_count
FROM applications
GROUP BY status;

-- Найти заявки с именами волонтёров и названиями мероприятий
SELECT app.application_id, app.status, vol.name as vol_name, ev.title as ev_title
FROM applications app
JOIN volunteers vol on app.volunteer_id = vol.volunteer_id
JOIN events ev on app.event_id = ev.event_id;