CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_data TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE volunteers (
    volunteer_id INT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    rating FLOAT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE organizations (
    organizations_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL
);
CREATE TABLE events (
    event_id INT PRIMARY KEY,
    org_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (org_id) REFERENCES organizations(organizations_id)
);

CREATE TABLE applications (
    application_id INT PRIMARY KEY,
    volunteer_id INT NOT NULL,
    event_id INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (volunteer_id) REFERENCES volunteers(volunteer_id),
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    CHECK (status IN ('pending', 'approved', 'rejected'))
);

CREATE TABLE participation (
    participation_id INT PRIMARY KEY,
    volunteer_id INT NOT NULL,
    event_id INT NOT NULL,
    role VARCHAR(100) NOT NULL,
    FOREIGN KEY (volunteer_id) REFERENCES volunteers(volunteer_id),
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);