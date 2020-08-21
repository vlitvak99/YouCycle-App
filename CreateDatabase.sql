PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Users (
	Username VARCHAR(50) PRIMARY KEY CHECK (length(Username) > 0 AND length(Username) <= 50),
	Password VARCHAR(50) NOT NULL CHECK (length(Password) > 0 AND length(Password) <= 50),
	FirstName VARCHAR(50) NOT NULL CHECK (length(FirstName) > 0 AND length(FirstName) <= 50),
	LastName VARCHAR(50) NOT NULL CHECK (length(LastName) > 0 AND length(LastName) <= 50),
	Email VARCHAR(50) NOT NULL UNIQUE CHECK (length(Email) > 0 AND length(Email) <= 50 AND Email LIKE '%_@__%.__%'),
	ZipCode INTEGER NOT NULL
);

/*
 * Options for 'Category'
 * 'M' - Mixed Paper
 * 'C' - Commingled Materials
 * 'S' - Scrap Metal
 * 'E' - Electronics
 *
 * https://www.montgomerycountymd.gov/sws/footprint/
 */
CREATE TABLE IF NOT EXISTS Recycling (
	ID INTEGER PRIMARY KEY AUTOINCREMENT,
	Username VARCHAR(50) NOT NULL REFERENCES Users(Username) ON DELETE CASCADE,
	ProductName VARCHAR(50) NOT NULL,
	Category CHAR CHECK (Category = 'M' OR Category = 'C' OR Category = 'S' OR Category = 'E'),
	RecycleNumber INTEGER,
	TimeStamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS Recycling_Username ON Recycling(Username, TimeStamp);


CREATE TABLE IF NOT EXISTS RecyclingInstructions (
	ZipCode INTEGER PRIMARY KEY,
	Source TEXT,
	Instructions TEXT NOT NULL
);
