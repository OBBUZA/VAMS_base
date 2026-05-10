-- Создание индекса для поиска заявок по статусу
CREATE INDEX idx_applications_status
ON applications(status);

-- Создание индекса для поиска волонтеров по рейтингу
CREATE INDEX idx_volunteers_rating
ON volunteers(rating);