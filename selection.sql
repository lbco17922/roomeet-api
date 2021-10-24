SELECT u2.id
FROM users AS u1,
    users AS u2
WHERE u1.first_name = 'J. Robert'
    AND u1.last_name = 'Oppenheimer'
    AND 69 * ABS(u1.latitude - u2.latitude) + 55 * ABS(u1.longitude - u2.longitude) < 100 -- Calculate approximate distance away, by converting coordinates to miles, and using the distance formula to require that the matchers are within 10 miles of each other. Have to use the taxicab distance since SQLite doesn't have powers.
    AND (u1.id, u2.id) NOT IN (
        -- make sure they haven't matched already
        SELECT user1,
            user2
        FROM matches
        WHERE u1.id = user1
        UNION
        SELECT user2,
            user1
        FROM matches
        WHERE u1.id = user2
    )
    AND (
        -- make sure one can rent a room to the other
        (
            u1.has_room = TRUE
            AND u2.needs_room = TRUE
        )
        OR (
            u2.has_room = TRUE
            AND u1.needs_room = TRUE
        )
    ) -- make sure non-negotiable qualifications are met
    AND u1.smokes = u2.smokes
    AND u1.alcohol = u2.alcohol
    AND u1.drugs = u2.drugs
    AND u1.pets = u2.pets
ORDER BY -- order by the quantifiable options. Take the difference in option, 
    -- make it positive, divide by the maximum possible disagreement to normalize
    -- all of the parameters with respect to each other.
    ABS(u1.bedtime - u2.bedtime) / 720.0 + -- 12 hour difference maximum
    ABS(u1.wake_up - u2.wake_up) / 720.0 + --
    ABS(u1.interaction - u2.interaction) / 5.0 + --
    ABS(u1.cleanliness - u2.cleanliness) / 5.0 + --
    ABS(u1.bathing - u2.bathing) / 5.0 + ABS(u1.amt_stuff - u2.amt_stuff) / 5.0 + --
    ABS(u1.sociability - u2.sociability) / 5.0 + ABS(u1.budget - u2.budget) / 300 ASC;