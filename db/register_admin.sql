INSERT INTO users(
    username,
    email,
    password,
    admin
) VALUES (
    $1,
    $2,
    $3,
    TRUE
);