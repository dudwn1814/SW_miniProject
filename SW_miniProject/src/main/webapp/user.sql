CREATE TABLE user(
	userID VARCHAR(50) NOT NULL PRIMARY KEY,
	password VARCHAR(200) NOT NULL,
	username VARCHAR(200) NOT NULL,
	postcode VARCHAR(20) NOT NULL,
	address VARCHAR(50),
	detailAddress VARCHAR(50) NOT NULL,
	extraAddress VARCHAR(50),
	telno VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL
);