-- User table --
CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(120)
);
-- added an admin column to users
ALTER TABLE users
ADD COLUMN admin BOOLEAN DEFAULT FALSE;

--User Stats Table -- 
CREATE TABLE user_stats(
    stat_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    team_name VARCHAR(255),
    hunter_name VARCHAR(255),
    total_ghost_hunts INT DEFAULT 0, -- if (success_rate === x && total_ghost_hunts === y) => grab a job from that tier at random
    successful_hunts INT DEFAULT 0, -- used to unlock certain jobs. people will only hire you if your success rate is at a certain number
    failed_hunts INT DEFAULT 0, 
    success_rate INT --successful_hunts/total_ghost_hunts
);
-- User inventory -- 
 CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    player_inv INT REFERENCES users(user_id),
    wallet INT,
    equipment INT REFERENCES gear_shop(item_id)
);

-- Gear Shop --
CREATE TABLE gear_shop(
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(255),
    item_price SMALLINT
);

-- Clue Table --
CREATE TABLE clues(
    clue_id SERIAL PRIMARY KEY,
    clue_name VARCHAR(255)
);

-- Ghost Table --
CREATE TABLE ghosts(
    ghost_id SERIAL PRIMARY KEY, 
    ghost_name VARCHAR(255),
    difficulty SMALLINT,
    hunting BOOLEAN,
    clue_one INT REFERENCES clues(clue_id),
    clue_two INT REFERENCES clues(clue_id),
    clue_three INT REFERENCES clues(clue_id)
);

-- Locations --
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    loc_name VARCHAR(255) UNIQUE,
    loc_city VARCHAR(255),
    loc_tier SMALLINT
);

-- Rooms --
CREATE TABLE rooms(
    room_id SERIAL PRIMARY KEY,
    location VARCHAR(255) REFERENCES locations(loc_name),
    room_name VARCHAR(200) NOT NULL
); 

-- Jobs --
CREATE TABLE jobs (
    job_id SERIAL PRIMARY KEY,
    job_name VARCHAR(255),
    job_description VARCHAR,
    job_tier SMALLINT,
    ghost INT REFERENCES ghosts(ghost_id),
    location INT REFERENCES locations(location_id),
    room INT REFERENCES rooms(room_id)
);


-- User Actions Table --

-- User Responses Table --
    -- makes a GET request only if the spirit responds to the equipment.