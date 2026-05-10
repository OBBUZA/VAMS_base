-- Создание функции для демонстрации среднего рейтинга волонтеров
CREATE FUNCTION get_average_rating()
RETURNS FLOAT AS $$
BEGIN
    RETURN (
        SELECT AVG(rating)
        FROM volunteers
    );
END;
$$ LANGUAGE plpgsql;

-- Создание функции для демонстрации количества участников в мероприятиях
CREATE FUNCTION get_event_participants(eventId INT)
RETURNS INT AS $$
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM participation
        WHERE event_id = eventId
    );
END;
$$ LANGUAGE plpgsql;

-- Создание процедуры для демонстрации принятой заявки
CREATE PROCEDURE approve_application(approve_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE applications
    SET status = 'approved'
    WHERE application_id = approve_id;
END;
$$;