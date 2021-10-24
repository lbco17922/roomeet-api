CREATE TABLE users (
    id VARCHAR(36) PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    email VARCHAR(256) NOT NULL,
    password VARCHAR(512) NOT NULL,
    email_verified BOOLEAN NOT NULL,
    age INTEGER NOT NULL,
    smokes BOOLEAN NOT NULL,
    alcohol BOOLEAN NOT NULL,
    drugs BOOLEAN NOT NULL,
    pets BOOLEAN NOT NULL,
    budget INTEGER NOT NULL,
    -- Whole dollars only
    bedtime INTEGER NOT NULL,
    -- Minute of the day from midnight (0 - 1440)
    wake_up INTEGER NOT NULL,
    interaction INTEGER NOT NULL,
    -- rating 0 - 5
    cleanliness INTEGER NOT NULL,
    -- rating 0 - 5
    bathing INTEGER NOT NULL,
    amt_stuff INTEGER NOT NULL,
    -- rating 0-5
    sociability INTEGER NOT NULL,
    --rating 0-5
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    hobbies VARCHAR(512) NOT NULL,
    interests VARCHAR(512) NOT NULL,
    -- too similar to hobbies?
    music VARCHAR(512) NOT NULL,
    food VARCHAR(512) NOT NULL,
    needs_room BOOLEAN NOT NULL,
    has_room BOOLEAN NOT NULL
);
CREATE TABLE media (
    id INTEGER PRIMARY KEY,
    description VARCHAR(256),
    owner VARCHAR(36) REFERENCES user(id) NOT NULL,
    visible BOOLEAN NOT NULL,
    subject VARCHAR(16)
);
CREATE TABLE allergies (
    user REFERENCES users(id),
    allergy VARCHAR(128)
);
CREATE TABLE matches (
    user1 VARCHAR(36) REFERENCES user(id),
    user2 VARCHAR(36) REFERENCES user(id),
    match BOOLEAN -- True if they match, false if they reject each other, no entry in this table otherwise
);