CREATE TABLE Klienci 
(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    nazwa VARCHAR(100) NOT NULL,
    NIP VARCHAR(15) DEFAULT 'X',
    adres VARCHAR(255) NOT NULL,
    telefon VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL
);


CREATE TABLE Dostawcy
(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    nazwa VARCHAR(100) NOT NULL,
    NIP VARCHAR(15) NOT NULL,
    adres VARCHAR(255) NOT NULL,
    telefon VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL
);


CREATE TABLE Produkty 
(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    nazwa VARCHAR(100),
    opis TEXT,
    cena_netto DECIMAL(10,2),
    stawka_VAT DECIMAL(4,2),
    ID_Dostawcy INT,
    FOREIGN KEY (ID_Dostawcy) REFERENCES Dostawcy(ID)
);


CREATE TABLE Magazyn 
(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ID_Produktu INT,
    ilosc_dostepna INT,
    lokalizacja VARCHAR(50),
    FOREIGN KEY (ID_Produktu) REFERENCES Produkty(ID)
);


CREATE TABLE Zamowienia 
(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ID_Klienta INT,
    data_zamowienia DATE,
    status_zamowienia ENUM('Nowe', 'W Realizacji', 'Zrealizowane'),
    FOREIGN KEY (ID_Klienta) REFERENCES Klienci(ID)
);


CREATE TABLE Pozycje_Zamowienia 
(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ID_Zamowienia INT,
    ID_Produktu INT,
    ilosc INT,
    cena DECIMAL(10,2),
    FOREIGN KEY (ID_Zamowienia) REFERENCES Zamowienia(ID),
    FOREIGN KEY (ID_Produktu) REFERENCES Produkty(ID)
);
   

CREATE TABLE Pracownicy 
(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    rola VARCHAR(50),
    data_zatrudnienia DATE
);   
    
