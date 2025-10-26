-- Insert Users
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (gen_random_uuid(), 'Alice', 'Johnson', 'alice@example.com', 'hash123', '555-1234', 'guest'),
    (gen_random_uuid(), 'Bob', 'Smith', 'bob@example.com', 'hash456', '555-5678', 'host'),
    (gen_random_uuid(), 'Charlie', 'Brown', 'charlie@example.com', 'hash789', '555-9876', 'admin');

-- Insert Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
SELECT gen_random_uuid(), user_id, 'Cozy Cottage', 'A small cottage near the lake.', 'Lakeview', 120.00
FROM "User" WHERE email = 'bob@example.com'
UNION ALL
SELECT gen_random_uuid(), user_id, 'City Apartment', 'Modern apartment in the city center.', 'Downtown', 200.00
FROM "User" WHERE email = 'bob@example.com';

-- Insert Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT gen_random_uuid(), p.property_id, u.user_id, '2025-12-01', '2025-12-05', 480.00, 'confirmed'
FROM Property p, "User" u
WHERE p.name = 'Cozy Cottage' AND u.email = 'alice@example.com'
UNION ALL
SELECT gen_random_uuid(), p.property_id, u.user_id, '2026-01-10', '2026-01-15', 1000.00, 'pending'
FROM Property p, "User" u
WHERE p.name = 'City Apartment' AND u.email = 'alice@example.com';

-- Insert Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
SELECT gen_random_uuid(), b.booking_id, b.total_price, 'credit_card'
FROM Booking b
WHERE b.status = 'confirmed';

-- Insert Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
SELECT gen_random_uuid(), p.property_id, u.user_id, 5, 'Wonderful stay! Very clean and cozy.'
FROM Property p, "User" u
WHERE p.name = 'Cozy Cottage' AND u.email = 'alice@example.com';

-- Insert Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
SELECT gen_random_uuid(), g.user_id, h.user_id, 'Hi, is your property available next weekend?'
FROM "User" g, "User" h
WHERE g.email = 'alice@example.com' AND h.email = 'bob@example.com'
UNION ALL
SELECT gen_random_uuid(), h.user_id, g.user_id, 'Yes, it is! Would you like to book it?'
FROM "User" g, "User" h
WHERE g.email = 'alice@example.com' AND h.email = 'bob@example.com';