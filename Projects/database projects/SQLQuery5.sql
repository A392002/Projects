create database new_final_spotify
GO

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    country VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL,
    city VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    age INT NOT NULL
);

CREATE TABLE premium_users (
    premium_user_id INT PRIMARY KEY,
    user_id INT,  -- Change to user_id
    features VARCHAR(255) NOT NULL,
    packages VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE rate (
    Rate_id INT PRIMARY KEY,
	premium_user_id INT,
    rate INT,
    FOREIGN KEY (premium_user_id) REFERENCES premium_users(premium_user_id)
);

CREATE TABLE invoice (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    serial_code VARCHAR(50) NOT NULL UNIQUE,
    package VARCHAR(255) NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
	premium_user_id INT,
    price DECIMAL(10,2) NOT NULL,
    pay_date DATE NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (premium_user_id) REFERENCES premium_users(premium_user_id)
);

CREATE TABLE feedback (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    comments VARCHAR(255) NOT NULL,
	premium_user_id INT,
    likes INT NOT NULL DEFAULT 0,
    dislikes INT NOT NULL DEFAULT 0,
    report_id INT,
    is_blocked BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (premium_user_id) REFERENCES premium_users(premium_user_id)
);

CREATE TABLE artists (
    artist_id INT PRIMARY KEY,
	user_id INT,
	artist_name varchar(50) not null,
    spotify_code VARCHAR(100) NOT NULL,
    followers_numbers INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

	CREATE TABLE tracks (
		track_id INT IDENTITY(1,1) PRIMARY KEY,
		artist_id INT,  -- Add artist_id column
		release_date DATE NOT NULL,
		bytes INT NOT NULL,
		track_name VARCHAR(255) NOT NULL,
		length INT NOT NULL,
		genre VARCHAR(50) NOT NULL,
		price DECIMAL(10,2) NOT NULL,
		FOREIGN KEY (artist_id) REFERENCES artists(artist_id)  -- Establish foreign key relationship
	);


	CREATE TABLE podcasts (
		podcast_id INT IDENTITY(1,1) PRIMARY KEY,
		artist_id INT,  -- Add artist_id column
		hosted_by VARCHAR(255) NOT NULL,
		genre VARCHAR(50) NOT NULL,
		release_date DATE NOT NULL,
		number_podcasts INT NOT NULL,
		number_of_episodes INT NOT NULL,
		FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
	);

	CREATE TABLE albums (
		album_id INT IDENTITY(1,1) PRIMARY KEY,
		track_id INT,
		release_date DATE NOT NULL,
		album_name VARCHAR(255) NOT NULL,
		genre VARCHAR(50) NOT NULL,
		songs_number INT NOT NULL,
		FOREIGN KEY (track_id) REFERENCES tracks(track_id)
	);

	CREATE TABLE most_listened_tracks (
		m_track_id INT IDENTITY(1,1) PRIMARY KEY,
		user_id INT,
		track_id INT,
		artist_name VARCHAR(255) NOT NULL,
		number_of_listeners INT NOT NULL,
		song_name VARCHAR(255) NOT NULL,
		FOREIGN KEY (user_id) REFERENCES users(user_id),
		FOREIGN KEY (track_id) REFERENCES tracks(track_id)
	);

	CREATE TABLE top_albums (
		t_album_id INT IDENTITY(1,1) PRIMARY KEY,
		album_id INT,
		artist_name VARCHAR(255) NOT NULL,
		album_name VARCHAR(255) NOT NULL,
		year_released INT NOT NULL,
		number_of_songs INT NOT NULL,
		FOREIGN KEY (album_id) REFERENCES albums(album_id)
	);

	CREATE TABLE company (
		company_id INT IDENTITY(1,1) PRIMARY KEY,
		company_name VARCHAR(255) NOT NULL,
		album_id int,
		location VARCHAR(255) NOT NULL,
		FOREIGN KEY (album_id) REFERENCES albums(album_id)
	);

	CREATE TABLE playlist (
		playlist_id INT IDENTITY(1,1) PRIMARY KEY,
		track_id INT,
		album_id INT,
		creation_date DATE NOT NULL,
		playlist_name VARCHAR(255) NOT NULL,
		songs_number INT NOT NULL,
		length INT NOT NULL,
		FOREIGN KEY (track_id) REFERENCES tracks(track_id),
		FOREIGN KEY (album_id) REFERENCES albums(album_id)
	);
INSERT INTO users (user_id, first_name, last_name, email, password, birth_date, country, gender, city, address, phone, age)
VALUES
  (1, 'John', 'Doe', 'john@example.com', 'password123', '1990-05-15', 'USA', 'M', 'New York', '123 Main St', '123-456-7890', 32),
  (2, 'Jane', 'Smith', 'jane@example.com', 'pass456', '1988-10-25', 'Canada', 'F', 'Toronto', '456 Maple Ave', '987-654-3210', 34),
  (3, 'Mike', 'Johnson', 'mike@example.com', 'mikepass', '1995-03-08', 'UK', 'M', 'London', '789 Oak St', '111-222-3333', 27),
  (4, 'Emily', 'Williams', 'emily@example.com', 'emilypass', '1992-12-18', 'Australia', 'F', 'Sydney', '567 Pine St', '444-555-6666', 30),
  (5, 'David', 'Brown', 'david@example.com', 'davidpass', '1993-08-22', 'Germany', 'M', 'Berlin', '890 Elm St', '777-888-9999', 29),
  (6, 'Sophia', 'Miller', 'sophia@example.com', 'sophiapass', '1997-06-14', 'France', 'F', 'Paris', '234 Birch St', '222-333-4444', 25),
  (7, 'William', 'Wilson', 'william@example.com', 'williampass', '1985-04-30', 'Spain', 'M', 'Madrid', '678 Oak St', '555-666-7777', 37),
  (8, 'Olivia', 'Martinez', 'olivia@example.com', 'oliviapass', '1989-11-05', 'Italy', 'F', 'Rome', '456 Cedar St', '999-888-7777', 33),
  (9, 'James', 'Taylor', 'james@example.com', 'jamespass', '1991-09-12', 'Brazil', 'M', 'Rio de Janeiro', '789 Pine St', '111-999-3333', 31),
  (10, 'Ava', 'Lopez', 'ava@example.com', 'avapass', '1994-07-28', 'Argentina', 'F', 'Buenos Aires', '345 Oak St', '222-444-6666', 28),
  (11, 'Daniel', 'Garcia', 'daniel@example.com', 'danielpass', '1987-02-19', 'Mexico', 'M', 'Mexico City', '567 Maple St', '777-555-3333', 35),
  (12, 'Mia', 'Hernandez', 'mia@example.com', 'miapass', '1996-01-07', 'China', 'F', 'Beijing', '890 Pine St', '888-444-2222', 26),
  (13, 'Logan', 'Gonzalez', 'logan@example.com', 'loganpass', '1986-06-30', 'Japan', 'M', 'Tokyo', '123 Elm St', '333-666-9999', 36),
  (14, 'Charlotte', 'Perez', 'charlotte@example.com', 'charlottepass', '1998-04-23', 'Russia', 'F', 'Moscow', '456 Oak St', '555-777-3333', 24),
  (15, 'Benjamin', 'Sanchez', 'benjamin@example.com', 'benjaminpass', '1999-03-11', 'India', 'M', 'Mumbai', '789 Maple St', '777-888-1111', 23),
  (16, 'Amelia', 'Ramirez', 'amelia@example.com', 'ameliapass', '1990-10-01', 'South Korea', 'F', 'Seoul', '234 Cedar St', '888-777-2222', 32),
  (17, 'Elijah', 'Torres', 'elijah@example.com', 'elijahpass', '1993-12-25', 'South Africa', 'M', 'Johannesburg', '567 Pine St', '999-444-6666', 29),
  (18, 'Harper', 'Nguyen', 'harper@example.com', 'harperpass', '1997-08-14', 'Australia', 'F', 'Melbourne', '890 Maple St', '111-555-7777', 25),
  (19, 'Lucas', 'Chen', 'lucas@example.com', 'lucaspass', '1988-11-03', 'Canada', 'M', 'Vancouver', '123 Cedar St', '222-333-4444', 33),
  (20, 'Avery', 'Gupta', 'avery@example.com', 'averypass', '1995-09-21', 'UK', 'F', 'Manchester', '456 Elm St', '333-666-9999', 26),
  (21, 'Evelyn', 'Wong', 'evelyn@example.com', 'evelynpass', '1992-07-18', 'Germany', 'F', 'Hamburg', '789 Cedar St', '444-777-2222', 29),
  (22, 'Jackson', 'Kim', 'jackson@example.com', 'jacksonpass', '1989-04-02', 'France', 'M', 'Lyon', '890 Pine St', '555-888-1111', 32),
  (23, 'Scarlett', 'Singh', 'scarlett@example.com', 'scarlettpass', '1994-01-29', 'Spain', 'F', 'Barcelona', '234 Elm St', '666-999-2222', 27),
  (24, 'Leo', 'Das', 'leo@example.com', 'leopass', '1996-11-08', 'Italy', 'M', 'Milan', '567 Cedar St', '777-111-3333', 25),
  (25, 'Chloe', 'Ali', 'chloe@example.com', 'chloepass', '1991-06-05', 'Brazil', 'F', 'Sao Paulo', '890 Elm St', '888-222-4444', 30),
  (26, 'Lincoln', 'Fernandez', 'lincoln@example.com', 'lincolnpass', '1987-03-22', 'Argentina', 'M', 'Buenos Aires', '123 Cedar St', '999-333-6666', 35),
  (27, 'Zoey', 'Das', 'zoey@example.com', 'zoeypass', '1998-12-17', 'Mexico', 'F', 'Mexico City', '456 Maple St', '111-777-8888', 23),
  (28, 'Mateo', 'Khan', 'mateo@example.com', 'mateopass', '1993-09-10', 'China', 'M', 'Shanghai', '789 Pine St', '222-444-6666', 28),
  (29, 'Riley', 'Wang', 'riley@example.com', 'rileypass', '1990-08-07', 'Japan', 'F', 'Tokyo', '234 Elm St', '333-666-9999', 31),
  (30, 'Aria', 'Singh', 'aria@example.com', 'ariapass', '1985-02-14', 'South Korea', 'F', 'Seoul', '567 Cedar St', '444-888-1111', 37);
---------------------------------------------------------------------------------------

-- Inserting 30 rows into the premium_users table
INSERT INTO premium_users (premium_user_id, user_id, features, packages)
VALUES
  (1, 1, 'Premium Feature 1', 'Package 1'),
  (2, 2, 'Premium Feature 2', 'Package 2'),
  (3, 3, 'Premium Feature 3', 'Package 3'),
  (4, 4, 'Premium Feature 4', 'Package 4'),
  (5, 5, 'Premium Feature 5', 'Package 5'),
  (6, 6, 'Premium Feature 6', 'Package 6'),
  (7, 7, 'Premium Feature 7', 'Package 7'),
  (8, 8, 'Premium Feature 8', 'Package 8'),
  (9, 9, 'Premium Feature 9', 'Package 9'),
  (10, 10, 'Premium Feature 10', 'Package 10'),
  (11, 11, 'Premium Feature 11', 'Package 11'),
  (12, 12, 'Premium Feature 12', 'Package 12'),
  (13, 13, 'Premium Feature 13', 'Package 13'),
  (14, 14, 'Premium Feature 14', 'Package 14'),
  (15, 15, 'Premium Feature 15', 'Package 15'),
  (16, 16, 'Premium Feature 16', 'Package 16'),
  (17, 17, 'Premium Feature 17', 'Package 17'),
  (18, 18, 'Premium Feature 18', 'Package 18'),
  (19, 19, 'Premium Feature 19', 'Package 19'),
  (20, 20, 'Premium Feature 20', 'Package 20'),
  (21, 21, 'Premium Feature 21', 'Package 21'),
  (22, 22, 'Premium Feature 22', 'Package 22'),
  (23, 23, 'Premium Feature 23', 'Package 23'),
  (24, 24, 'Premium Feature 24', 'Package 24'),
  (25, 25, 'Premium Feature 25', 'Package 25'),
  (26, 26, 'Premium Feature 26', 'Package 26'),
  (27, 27, 'Premium Feature 27', 'Package 27'),
  (28, 28, 'Premium Feature 28', 'Package 28'),
  (29, 29, 'Premium Feature 29', 'Package 29'),
  (30, 30, 'Premium Feature 30', 'Package 30');
  ------------------------------------------------------------
  -- Insert 20 rows of data into the rate table
INSERT INTO rate (Rate_id, premium_user_id, rate) VALUES
(1, 1, 4),
(2, 2, 5),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 4),
(7, 7, 3),
(8, 8, 5),
(9, 9, 4),
(10, 10, 5),
(11, 11, 4),
(12, 12, 3),
(13, 13, 5),
(14, 14, 4),
(15, 15, 3),
(16, 16, 5),
(17, 17, 4),
(18, 18, 3),
(19, 19, 5),
(20, 20, 4);
---------------------------------------------------------------------------------------------
-- Insert 20 rows of data into the invoice table
INSERT INTO invoice (user_id, serial_code, package, total_cost, premium_user_id, price, pay_date, payment_method) VALUES
(1, 'SERIAL001', 'Package A', 29.99, 1, 29.99, '2024-01-05', 'Credit Card'),
(2, 'SERIAL002', 'Package B', 39.99, 2, 39.99, '2024-01-06', 'PayPal'),
(3, 'SERIAL003', 'Package C', 49.99, 3, 49.99, '2024-01-07', 'Credit Card'),
(4, 'SERIAL004', 'Package A', 29.99, 4, 29.99, '2024-01-08', 'PayPal'),
(5, 'SERIAL005', 'Package B', 39.99, 5, 39.99, '2024-01-09', 'Credit Card'),
(6, 'SERIAL006', 'Package C', 49.99, 6, 49.99, '2024-01-10', 'PayPal'),
(7, 'SERIAL007', 'Package A', 29.99, 7, 29.99, '2024-01-11', 'Credit Card'),
(8, 'SERIAL008', 'Package B', 39.99, 8, 39.99, '2024-01-12', 'PayPal'),
(9, 'SERIAL009', 'Package C', 49.99, 9, 49.99, '2024-01-13', 'Credit Card'),
(10, 'SERIAL010', 'Package A', 29.99, 10, 29.99, '2024-01-14', 'PayPal'),
(11, 'SERIAL011', 'Package B', 39.99, 11, 39.99, '2024-01-15', 'Credit Card'),
(12, 'SERIAL012', 'Package C', 49.99, 12, 49.99, '2024-01-16', 'PayPal'),
(13, 'SERIAL013', 'Package A', 29.99, 13, 29.99, '2024-01-17', 'Credit Card'),
(14, 'SERIAL014', 'Package B', 39.99, 14, 39.99, '2024-01-18', 'PayPal'),
(15, 'SERIAL015', 'Package C', 49.99, 15, 49.99, '2024-01-19', 'Credit Card'),
(16, 'SERIAL016', 'Package A', 29.99, 16, 29.99, '2024-01-20', 'PayPal'),
(17, 'SERIAL017', 'Package B', 39.99, 17, 39.99, '2024-01-21', 'Credit Card'),
(18, 'SERIAL018', 'Package C', 49.99, 18, 49.99, '2024-01-22', 'PayPal'),
(19, 'SERIAL019', 'Package A', 29.99, 19, 29.99, '2024-01-23', 'Credit Card'),
(20, 'SERIAL020', 'Package B', 39.99, 20, 39.99, '2024-01-24', 'PayPal');
------------------------------------------------------------------------------
-- Insert 20 rows of data into the feedback table
INSERT INTO feedback (user_id, comments, premium_user_id, likes, dislikes, report_id, is_blocked) VALUES
(1, 'Great service!', 1, 10, 2, NULL, 0),
(2, 'Love the premium features!', 2, 15, 5, NULL, 0),
(3, 'Amazing experience with the app!', 3, 20, 8, NULL, 0),
(4, 'Could use some improvements.', 4, 5, 10, NULL, 0),
(5, 'The best music platform out there!', 5, 25, 3, NULL, 0),
(6, 'Not satisfied with the customer support.', 6, 3, 12, NULL, 0),
(7, 'Fantastic app design!', 7, 18, 4, NULL, 0),
(8, 'Premium is worth every penny.', 8, 22, 7, NULL, 0),
(9, 'User-friendly interface.', 9, 13, 6, NULL, 0),
(10, 'Needs more variety in the music library.', 10, 8, 15, NULL, 0),
(11, 'Excellent app for discovering new music.', 11, 30, 2, NULL, 0),
(12, 'Responsive and quick support team.', 12, 17, 5, NULL, 0),
(13, 'Great platform for artists to showcase their work.', 13, 28, 4, NULL, 0),
(14, 'Premium subscription is a game-changer!', 14, 19, 6, NULL, 0),
(15, 'Highly recommend to fellow music lovers.', 15, 24, 3, NULL, 0),
(16, 'Could use more features in the free version.', 16, 6, 9, NULL, 0),
(17, 'Awesome playlist recommendations.', 17, 23, 5, NULL, 0),
(18, 'Premium gives an ad-free experience, worth it!', 18, 26, 4, NULL, 0),
(19, 'Easy to navigate and find favorite artists.', 19, 14, 7, NULL, 0),
(20, 'The app crashed a few times, needs fixing.', 20, 4, 11, NULL, 0);
-------------------------------------------------------------------------
INSERT INTO artists (artist_id, artist_name, user_id, spotify_code, followers_numbers)
VALUES
    (1, 'Artist1', 1, 'SPOTIFYCODE1', 10000),
    (2, 'Artist2', 2, 'SPOTIFYCODE2', 8000),
    (3, 'Artist3', 3, 'SPOTIFYCODE3', 12000),
    (4, 'Artist4', 4, 'SPOTIFYCODE4', 15000),
    (5, 'Artist5', 5, 'SPOTIFYCODE5', 9000),
    (6, 'Artist6', 6, 'SPOTIFYCODE6', 11000),
    (7, 'Artist7', 7, 'SPOTIFYCODE7', 13000),
    (8, 'Artist8', 8, 'SPOTIFYCODE8', 1000),
    (9, 'Artist9', 9, 'SPOTIFYCODE9', 7000),
    (10, 'Artist10', 10, 'SPOTIFYCODE10', 18000),
    (11, 'Artist11', 11, 'SPOTIFYCODE11', 9500),
    (12, 'Artist12', 12, 'SPOTIFYCODE12', 1200),
    (13, 'Artist13', 13, 'SPOTIFYCODE13', 16000),
    (14, 'Artist14', 14, 'SPOTIFYCODE14', 2000),
    (15, 'Artist15', 15, 'SPOTIFYCODE15', 3000),
    (16, 'Artist16', 16, 'SPOTIFYCODE16', 6000),
    (17, 'Artist17', 17, 'SPOTIFYCODE17', 1100),
    (18, 'Artist18', 18, 'SPOTIFYCODE18', 5000),
    (19, 'Artist19', 19, 'SPOTIFYCODE19', 4500),
    (20, 'Artist20', 20, 'SPOTIFYCODE20', 800);
  -----------------------------------------------------------------------
  -- Insert 20 rows of data into the tracks table
INSERT INTO tracks (artist_id, release_date, bytes, track_name, length, genre, price) VALUES
(1, '2023-01-15', 512000, 'Track 1', 240, 'Pop', 1.99),
(2, '2023-02-20', 480000, 'Track 2', 210, 'Rock', 2.49),
(3, '2023-03-25', 600000, 'Track 3', 280, 'Electronic', 1.79),
(4, '2023-04-10', 550000, 'Track 4', 260, 'Hip-Hop', 2.99),
(5, '2023-05-12', 490000, 'Track 5', 230, 'R&B', 1.89),
(6, '2023-06-18', 520000, 'Track 6', 250, 'Pop', 2.29),
(7, '2023-07-22', 530000, 'Track 7', 270, 'Electronic', 1.69),
(8, '2023-08-30', 480000, 'Track 8', 220, 'Rock', 2.79),
(9, '2023-09-05', 510000, 'Track 9', 240, 'Hip-Hop', 2.19),
(10, '2023-10-14', 540000, 'Track 10', 260, 'R&B', 1.99),
(11, '2023-11-20', 500000, 'Track 11', 230, 'Pop', 2.49),
(12, '2023-12-25', 590000, 'Track 12', 270, 'Electronic', 1.79),
(13, '2024-01-02', 460000, 'Track 13', 210, 'Rock', 2.99),
(14, '2024-02-08', 570000, 'Track 14', 250, 'Hip-Hop', 1.89),
(15, '2024-03-14', 540000, 'Track 15', 260, 'R&B', 2.29),
(16, '2024-04-20', 500000, 'Track 16', 230, 'Pop', 1.69),
(17, '2024-05-26', 520000, 'Track 17', 240, 'Electronic', 2.79),
(18, '2024-06-30', 510000, 'Track 18', 250, 'Rock', 2.19),
(19, '2024-07-15', 480000, 'Track 19', 220, 'Hip-Hop', 1.99),
(20, '2024-08-22', 550000, 'Track 20', 270, 'R&B', 2.49);
-------------------------------------------------------------------------------
-- Insert 20 rows of data into the podcasts table
INSERT INTO podcasts (artist_id, hosted_by, genre, release_date, number_podcasts, number_of_episodes) VALUES
(1, 'Host 1', 'Comedy', '2023-01-15', 10, 50),
(2, 'Host 2', 'Technology', '2023-02-20', 15, 70),
(3, 'Host 3', 'News', '2023-03-25', 8, 40),
(4, 'Host 4', 'Science', '2023-04-10', 12, 60),
(5, 'Host 5', 'Business', '2023-05-12', 10, 55),
(6, 'Host 6', 'Health', '2023-06-18', 18, 80),
(7, 'Host 7', 'Education', '2023-07-22', 14, 65),
(8, 'Host 8', 'Comedy', '2023-08-30', 11, 48),
(9, 'Host 9', 'Technology', '2023-09-05', 20, 90),
(10, 'Host 10', 'News', '2023-10-14', 9, 42),
(11, 'Host 11', 'Science', '2023-11-20', 13, 58),
(12, 'Host 12', 'Business', '2023-12-25', 15, 70),
(13, 'Host 13', 'Health', '2024-01-02', 17, 75),
(14, 'Host 14', 'Education', '2024-02-08', 16, 68),
(15, 'Host 15', 'Comedy', '2024-03-14', 10, 50),
(16, 'Host 16', 'Technology', '2024-04-20', 14, 62),
(17, 'Host 17', 'News', '2024-05-26', 12, 55),
(18, 'Host 18', 'Science', '2024-06-30', 19, 88),
(19, 'Host 19', 'Business', '2024-07-15', 8, 38),
(20, 'Host 20', 'Health', '2024-08-22', 16, 72);
---------------------------------------------------------------
-- Insert 20 rows of data into the albums table
INSERT INTO albums (track_id, release_date, album_name, genre, songs_number) VALUES
(1, '2023-01-10', 'Album 1', 'Pop', 12),
(2, '2023-02-15', 'Album 2', 'Rock', 10),
(3, '2023-03-20', 'Album 3', 'Hip Hop', 15),
(4, '2023-04-25', 'Album 4', 'Electronic', 8),
(5, '2023-05-30', 'Album 5', 'Country', 11),
(6, '2023-06-05', 'Album 6', 'Jazz', 9),
(7, '2023-07-10', 'Album 7', 'Blues', 14),
(8, '2023-08-15', 'Album 8', 'R&B', 13),
(9, '2023-09-20', 'Album 9', 'Reggae', 10),
(10, '2023-10-25', 'Album 10', 'Classical', 16),
(11, '2023-11-30', 'Album 11', 'Folk', 12),
(12, '2023-12-05', 'Album 12', 'Indie', 14),
(13, '2024-01-10', 'Album 13', 'Metal', 11),
(14, '2024-02-15', 'Album 14', 'Punk', 9),
(15, '2024-03-20', 'Album 15', 'Alternative', 13),
(16, '2024-04-25', 'Album 16', 'Latin', 10),
(17, '2024-05-30', 'Album 17', 'World', 15),
(18, '2024-06-05', 'Album 18', 'Gospel', 8),
(19, '2024-07-10', 'Album 19', 'New Age', 12),
(20, '2024-08-15', 'Album 20', 'Soul', 14);
-------------------------------------------------------------------
-- Insert 20 rows of data into the most_listened_tracks table
INSERT INTO most_listened_tracks (user_id, track_id, artist_name, number_of_listeners, song_name) VALUES
(1, 1, 'Artist A', 100, 'Song 1'),
(2, 2, 'Artist B', 150, 'Song 2'),
(3, 3, 'Artist C', 120, 'Song 3'),
(4, 4, 'Artist D', 90, 'Song 4'),
(5, 5, 'Artist E', 110, 'Song 5'),
(6, 6, 'Artist F', 130, 'Song 6'),
(7, 7, 'Artist G', 80, 'Song 7'),
(8, 8, 'Artist H', 95, 'Song 8'),
(9, 9, 'Artist I', 105, 'Song 9'),
(10, 10, 'Artist J', 125, 'Song 10'),
(11, 11, 'Artist K', 140, 'Song 11'),
(12, 12, 'Artist L', 115, 'Song 12'),
(13, 13, 'Artist M', 85, 'Song 13'),
(14, 14, 'Artist N', 100, 'Song 14'),
(15, 15, 'Artist O', 120, 'Song 15'),
(16, 16, 'Artist P', 95, 'Song 16'),
(17, 17, 'Artist Q', 110, 'Song 17'),
(18, 18, 'Artist R', 75, 'Song 18'),
(19, 19, 'Artist S', 90, 'Song 19'),
(20, 20, 'Artist T', 105, 'Song 20');
--------------------------------------------------------------------------------
-- Insert 20 rows of data into the top_albums table
INSERT INTO top_albums (album_id, artist_name, album_name, year_released, number_of_songs) VALUES
(1, 'Artist A', 'Album 1', 2020, 12),
(2, 'Artist B', 'Album 2', 2019, 10),
(3, 'Artist C', 'Album 3', 2021, 15),
(4, 'Artist D', 'Album 4', 2018, 8),
(5, 'Artist E', 'Album 5', 2017, 14),
(6, 'Artist F', 'Album 6', 2022, 11),
(7, 'Artist G', 'Album 7', 2016, 9),
(8, 'Artist H', 'Album 8', 2015, 13),
(9, 'Artist I', 'Album 9', 2014, 16),
(10, 'Artist J', 'Album 10', 2023, 10),
(11, 'Artist K', 'Album 11', 2013, 12),
(12, 'Artist L', 'Album 12', 2012, 14),
(13, 'Artist M', 'Album 13', 2024, 11),
(14, 'Artist N', 'Album 14', 2011, 9),
(15, 'Artist O', 'Album 15', 2010, 15),
(16, 'Artist P', 'Album 16', 2009, 8),
(17, 'Artist Q', 'Album 17', 2025, 13),
(18, 'Artist R', 'Album 18', 2008, 16),
(19, 'Artist S', 'Album 19', 2007, 10),
(20, 'Artist T', 'Album 20', 2026, 11);
-----------------------------------------------------------------------------
-- Insert 20 rows of data into the company table
INSERT INTO company (company_name, album_id, location) VALUES
('Company A', 1, 'Location 1'),
('Company B', 2, 'Location 2'),
('Company C', 3, 'Location 3'),
('Company D', 4, 'Location 4'),
('Company E', 5, 'Location 5'),
('Company F', 6, 'Location 6'),
('Company G', 7, 'Location 7'),
('Company H', 8, 'Location 8'),
('Company I', 9, 'Location 9'),
('Company J', 10, 'Location 10'),
('Company K', 11, 'Location 11'),
('Company L', 12, 'Location 12'),
('Company M', 13, 'Location 13'),
('Company N', 14, 'Location 14'),
('Company O', 15, 'Location 15'),
('Company P', 16, 'Location 16'),
('Company Q', 17, 'Location 17'),
('Company R', 18, 'Location 18'),
('Company S', 19, 'Location 19'),
('Company T', 20, 'Location 20');
------------------------------------------------------------------------------
-- Insert 20 rows of data into the playlist table
INSERT INTO playlist (track_id, album_id, creation_date, playlist_name, songs_number, length) VALUES
(1, 1, '2023-01-01', 'My Playlist 1', 10, 120),
(2, 2, '2023-01-02', 'My Playlist 2', 15, 180),
(3, 3, '2023-01-03', 'Cool Songs', 8, 100),
(4, 4, '2023-01-04', 'Favorites', 12, 150),
(5, 5, '2023-01-05', 'Road Trip Mix', 20, 240),
(6, 6, '2023-01-06', 'Relaxation Vibes', 14, 170),
(7, 7, '2023-01-07', 'Workout Jams', 18, 200),
(8, 8, '2023-01-08', 'Study Playlist', 25, 300),
(9, 9, '2023-01-09', 'Old Classics', 10, 120),
(10, 10, '2023-01-10', 'Party Hits', 30, 360),
(11, 11, '2023-01-11', 'Chill Mode', 22, 260),
(12, 12, '2023-01-12', 'Best of 2023', 16, 190),
(13, 13, '2023-01-13', 'Indie Vibes', 15, 180),
(14, 14, '2023-01-14', 'Jazz Lounge', 10, 120),
(15, 15, '2023-01-15', 'EDM Explosion', 28, 330),
(16, 16, '2023-01-16', 'Country Roads', 12, 150),
(17, 17, '2023-01-17', 'Rock Classics', 20, 240),
(18, 18, '2023-01-18', 'R&B Grooves', 15, 180),
(19, 19, '2023-01-19', 'Latin Beats', 18, 200),
(20, 20, '2023-01-20', 'Hip Hop Heat', 25, 300);

--Retrieve all users who have premium accounts
SELECT * FROM users
WHERE user_id IN (SELECT user_id FROM premium_users);


---------------------------------------------------
--the number of premium users for each country

SELECT country, (SELECT COUNT(*) FROM premium_users WHERE user_id = users.user_id) AS premium_user_count
FROM users;


------------------------------------------------------------


-- users who have given the highest rating
SELECT *
FROM users
WHERE user_id IN (
    SELECT premium_user_id
    FROM rate
    WHERE rate = (SELECT MAX(rate) FROM rate)
);

----------------------------------------------

--the total number of listeners for each track:

SELECT t.track_name, COUNT(mlt.user_id) AS total_listeners
FROM tracks t
LEFT JOIN most_listened_tracks mlt ON t.track_id = mlt.track_id
GROUP BY t.track_name;


---List the top 5 most listened tracks and their artists
SELECT TOP 5 t.track_id, t.track_name, a.artist_name, m.number_of_listeners
FROM most_listened_tracks m
JOIN tracks t ON m.track_id = t.track_id
JOIN artists a ON t.artist_id = a.artist_id
ORDER BY m.number_of_listeners DESC;


--------------------------------------------------------------
-- the total number of songs in each album:
SELECT al.album_id, al.album_name, COUNT(t.track_id) AS total_songs
FROM albums al
JOIN tracks t ON al.track_id = t.track_id
GROUP BY al.album_id, al.album_name;


-----------------------------------------------------------------

--Retrieve feedback with user and premium user information:
SELECT f.*, u.first_name, u.last_name, pu.features
FROM feedback f
JOIN users u ON f.user_id = u.user_id
JOIN premium_users pu ON f.premium_user_id = pu.premium_user_id;


---------------------------------------------------------------
----List top albums with company information:
SELECT ta.*, c.company_name
FROM top_albums ta
JOIN albums a ON ta.album_id = a.album_id
JOIN company c ON a.album_id = c.album_id;


-----------------------------------------------------
--Find playlists with track and album details:
SELECT p.*, t.track_name, a.album_name
FROM playlist p
LEFT JOIN tracks t ON p.track_id = t.track_id
LEFT JOIN albums a ON p.album_id = a.album_id
----------------------------------------------------
--Create a view for top albums with company information:

CREATE VIEW vw_top_albums AS
SELECT ta.*, c.company_name
FROM top_albums ta
JOIN albums a ON ta.album_id = a.album_id
JOIN company c ON a.album_id = c.album_id;

SELECT * FROM vw_top_albums;
-----------------------------------
--procedure that retrieves details of premium users
CREATE PROCEDURE GetPremiumUserDetails
AS
BEGIN
    SELECT u.*, p.features, p.packages
    FROM users u
    JOIN premium_users p ON u.user_id = p.user_id;
END;

EXEC GetPremiumUserDetails;

----- the same query dynamic

CREATE PROCEDURE DynamicGetPremiumUserDetails
    @UserID INT
AS
BEGIN
    SELECT u.*, p.features, p.packages
    FROM users u
    JOIN premium_users p ON u.user_id = p.user_id
    WHERE u.user_id = @UserID;
END;

EXEC DynamicGetPremiumUserDetails @UserID = 1;