CREATE DATABASE IF NOT EXISTS users;
USE users;

CREATE TABLE IF NOT EXISTS user_Profil (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    full_name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO user_Profil (username, full_name, email, password)
VALUES ('ahlam_maimouni', 'Ahlam Maimouni', 'ahlam.maimouni@biofeed.com', 'Ahlam2025!');
INSERT INTO user_Profil (username, full_name, email, password)
VALUES 
('john_doe', 'John Doe', 'john.doe@biofeed.com', 'JohnDoe#1234'),
('jane_smith', 'Jane Smith', 'jane.smith@biofeed.com', 'JaneS2023!'),
('mohamed_ali', 'Mohamed Ali', 'mohamed.ali@biofeed.com', 'MohamedAli@789'),
('sara_brown', 'Sara Brown', 'sara.brown@biofeed.com', 'SaraBrown$567'),
('adam_jones', 'Adam Jones', 'adam.jones@biofeed.com', 'AdamJ%2345'),
('lina_wilson', 'Lina Wilson', 'lina.wilson@biofeed.com', 'LinaW!8765'),
('paul_davis', 'Paul Davis', 'paul.davis@biofeed.com', 'PaulD#6789'),
('emily_clark', 'Emily Clark', 'emily.clark@biofeed.com', 'EmilyC@4567'),
('ryan_white', 'Ryan White', 'ryan.white@biofeed.com', 'RyanW!1234'),
('laura_moore', 'Laura Moore', 'laura.moore@biofeed.com', 'LauraM$9876'),
('david_martin', 'David Martin', 'david.martin@biofeed.com', 'DavidM@5678'),
('olivia_taylor', 'Olivia Taylor', 'olivia.taylor@biofeed.com', 'OliviaT#3456'),
('mike_thomas', 'Mike Thomas', 'mike.thomas@biofeed.com', 'MikeT!7890'),
('lisa_harris', 'Lisa Harris', 'lisa.harris@biofeed.com', 'LisaH#1230'),
('daniel_hall', 'Daniel Hall', 'daniel.hall@biofeed.com', 'DanielH%4563'),
('sophie_allen', 'Sophie Allen', 'sophie.allen@biofeed.com', 'SophieA@7654'),
('mark_wright', 'Mark Wright', 'mark.wright@biofeed.com', 'MarkW!8765'),
('chloe_adams', 'Chloe Adams', 'chloe.adams@biofeed.com', 'ChloeA#2345'),
('james_scott', 'James Scott', 'james.scott@biofeed.com', 'JamesS$5678'),
('amelia_turner', 'Amelia Turner', 'amelia.turner@biofeed.com', 'AmeliaT@9876');


CREATE DATABASE IF NOT EXISTS flutter_app;
USE flutter_app;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

