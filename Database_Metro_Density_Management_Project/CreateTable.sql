USE MetroİçiYolcuYoğunluYönetimSistemi

CREATE TABLE İstasyon (
ID int PRIMARY KEY,
İstasyonAdı varchar(255) NOT NULL,
);

CREATE TABLE Metro (
ID int PRIMARY KEY,
MetroNumarası int NOT NULL,
VagonSayısı int NOT NULL,
);

CREATE TABLE Vagon (
ID int PRIMARY KEY,
MetroID int NOT NULL,
VagonNumarası int NOT NULL,
YolcuKapasitesi int NOT NULL,
EngelliKapasitesi int NOT NULL,
YolcuSayısı int,
EngelliYolcuSayısı int,
YolcuYoğunluğu char(255) NOT NULL,
Saat time NOT NULL,
Tarih date NOT NULL,
FOREIGN KEY(MetroID) REFERENCES Metro (ID) ON DELETE NO ACTION,
);

CREATE TABLE Paks(
ID int PRIMARY KEY,
İstasyonID int NOT NULL,
IşıkDurumu char(255) NOT NULL, --Y,S,K
EngelliIşıkDurumu char(255) NOT NULL, --Y,S,K
FOREIGN KEY(İstasyonID) REFERENCES İstasyon(ID) ON DELETE NO ACTION,
);

CREATE TABLE Hat(
ID int PRIMARY KEY,
Hatİsmi varchar(255) NOT NULL,
);

CREATE TABLE Geçiş(
PaksID int NOT NULL,
VagonID int NOT NULL,
GirenYolcu int,
ÇıkanYolcu int,
GirenEngelliYolcu int,
ÇıkanEngelliYolcu int,
Saat time NOT NULL,
Tarih date NOT NULL,
FOREIGN KEY(PaksID) REFERENCES Paks(ID) ON DELETE NO ACTION,
FOREIGN KEY(VagonID) REFERENCES Vagon(ID) ON DELETE NO ACTION,
);

CREATE TABLE İstasyon_Metro(
İstasyonID int NOT NULL,
MetroID int NOT NULL,
BeklenenGirişSaati time NOT NULL,
GirişSaati time,
ÇıkışSaati time,
Tarih date NOT NULL,
FOREIGN KEY(İstasyonID) REFERENCES İstasyon(ID) ON DELETE NO ACTION,
FOREIGN KEY(MetroID) REFERENCES Metro(ID) ON DELETE NO ACTION,
);

CREATE TABLE İstasyon_Hat(
İstasyonID int NOT NULL,
HatID int NOT NULL,
İstasyonSırası int NOT NULL,
FOREIGN KEY(İstasyonID) REFERENCES İstasyon(ID) ON DELETE NO ACTION,
FOREIGN KEY(HatID) REFERENCES Hat(ID) ON DELETE NO ACTION,
);

CREATE TABLE Sefer(
MetroID int NOT NULL,
HatID int NOT NULL,
BaşlangıçSaati date,
BitişSaati date,
SeferYönü varchar(255),
FOREIGN KEY(MetroID) REFERENCES Metro(ID) ON DELETE NO ACTION,
FOREIGN KEY(HatID) REFERENCES Hat(ID) ON DELETE NO ACTION,
);


