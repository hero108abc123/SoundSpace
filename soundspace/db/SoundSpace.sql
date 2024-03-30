Create Database SoundSpace;
Go

Use SoundSpace
Go

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Email VARCHAR(255),
    Password VARCHAR(255),
	DisplayName VARCHAR(255),
	Age int,
	Gender VARCHAR(255)
);

CREATE TABLE Artist (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(255),
    Genre VARCHAR(255)
);

CREATE TABLE Album (
    AlbumID INT PRIMARY KEY,
    Title VARCHAR(255),
    ArtistID INT,
    Genre VARCHAR(255),
    ReleaseDate DATE,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID)
);

CREATE TABLE Track (
    TrackID INT PRIMARY KEY,
    Title VARCHAR(255),
    ArtistID INT,
    AlbumID INT,
    Duration TIME,
    ReleaseDate DATE,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID),
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)
);

CREATE TABLE Playlist (
    PlaylistID INT PRIMARY KEY,
    UserID INT,
    Title VARCHAR(255),
    CreationDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Likes (
    UserID INT,
    TrackID INT,
	PRIMARY KEY (UserID, TrackID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (TrackID) REFERENCES Track(TrackID)
);

CREATE TABLE TrackPlaylist (
	TrackID INT,
	PlaylistID INT,
	PRIMARY KEY (PlaylistID, TrackID),
	FOREIGN KEY (TrackID) REFERENCES Track(TrackID),
	FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID)
);