CREATE FUNCTION check_rating()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.rating < 0 THEN
        RAISE EXCEPTION 'Рейтинг не может быть отрицательным!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Создание триггера для проверки рейтинга на отрицательное значение
CREATE TRIGGER check_rating_trigger
BEFORE INSERT OR UPDATE ON volunteers
FOR EACH ROW
EXECUTE FUNCTION check_rating();



CREATE FUNCTION create_participation()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'approved' THEN
        INSERT INTO participation (participation_id, volunteer_id, event_id, role)
        VALUES (NEW.application_id, NEW.volunteer_id, NEW.event_id, 'Участник');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Создание триггера для создания новой записи в таблице participation при добавлении новой заявки
CREATE TRIGGER create_participation_trigger
AFTER INSERT ON applications
FOR EACH ROW
EXECUTE FUNCTION create_participation();