-- Создание представления для демонстрации активных участников и их ролей в мероприятиях
CREATE VIEW active_participants2 AS
SELECT v.name, e.title, p.role
FROM participation p
JOIN volunteers v USING (volunteer_id)
JOIN events e USING (event_id);

-- Создание представления для демонстрации заявок в статусе "pending" с именами волонтеров и названиями мероприятий
CREATE VIEW pending_applications AS
SELECT a.application_id, v.name, e.title
FROM applications a
JOIN volunteers v USING (volunteer_id)
JOIN events e USING (event_id)
WHERE a.status = 'pending';