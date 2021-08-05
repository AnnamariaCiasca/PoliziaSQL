CREATE database Polizia;

CREATE TABLE AgenteDiPolizia (
	IdAgente INTEGER IDENTITY(1,1) NOT NULL, 
	Nome NVARCHAR(30) NOT NULL,
	Cognome NVARCHAR(50) NOT NULL,
	CodiceFiscale NVARCHAR(16) NOT NULL,
	DataDiNascita DATE NOT NULL,
	AnniServizio INTEGER,
	CONSTRAINT Agente_PK PRIMARY KEY(IdAgente),
	CONSTRAINT CHK_DataDiNascita CHECK (DataDiNascita<'2003-08-05'),
	CONSTRAINT U_Agente UNIQUE(CodiceFiscale)
);


CREATE TABLE AreaMetropolitana (
	IdArea INTEGER IDENTITY(1,1) NOT NULL, 
	CodiceArea NVARCHAR(5) NOT NULL,
	AltoRischio BIT NOT NULL,
	CONSTRAINT Area_PK PRIMARY KEY(IdArea),
	CONSTRAINT U_Area UNIQUE(CodiceArea)
);



CREATE TABLE Pattuglia (
	IdAgente INTEGER NOT NULL, 
    IdArea INTEGER NOT NULL, 
	CONSTRAINT Pattuglia1_FK FOREIGN KEY(IdAgente) REFERENCES AgenteDiPolizia(IdAgente),
	CONSTRAINT Pattuglia2_FK FOREIGN KEY(IdArea) REFERENCES AreaMetropolitana(IdArea),
);



INSERT INTO AgenteDiPolizia VALUES ('Luca', 'Verdi', 'VRDILC78L56B432B', '1978-02-04', 5);
INSERT INTO AgenteDiPolizia VALUES ('Mario', 'Rossi', 'MRORSS86L56B432F', '1986-03-10', 3);
INSERT INTO AgenteDiPolizia VALUES ('Maria', 'Bianchi','BNCHMR98L56B432B', '1998-10-04', 10);
INSERT INTO AgenteDiPolizia VALUES ('Giovanni', 'Neri', 'NRIGNN94L56B432C', '1994-02-04', 2);
INSERT INTO AgenteDiPolizia VALUES ('Sara', 'Ceri', 'CRISRA93L56B432H', '1993-02-04', 4);
INSERT INTO AgenteDiPolizia VALUES ('Michela', 'Micheli', 'MHLMCH72L56B432L', '1972-06-12', 12);
INSERT INTO AgenteDiPolizia VALUES ('Lucia', 'Gialli', 'GLLLCA98L56B432B', '1998-03-09', 8);
INSERT INTO AgenteDiPolizia VALUES ('Marco', 'Verdi', 'VRDIMRC69L56B43S', '1969-10-04', 6);
INSERT INTO AgenteDiPolizia VALUES ('Matteo', 'Mattei', 'MTTMTT96L56B432B', '1996-03-09', 2);
INSERT INTO AgenteDiPolizia VALUES ('Franca', 'Franchi', 'FRCFRH00L56B43S', '2000-10-04', 1);



INSERT INTO AreaMetropolitana VALUES('CFGHT', 1);
INSERT INTO AreaMetropolitana VALUES('ERTPL', 1);
INSERT INTO AreaMetropolitana VALUES('PLQWR', 0);
INSERT INTO AreaMetropolitana VALUES('CACMV', 0);
INSERT INTO AreaMetropolitana VALUES('APLFG', 0);
INSERT INTO AreaMetropolitana VALUES('ERTVZ', 1);
INSERT INTO AreaMetropolitana VALUES('AWRVN', 0);
INSERT INTO AreaMetropolitana VALUES('PLFRT', 1);
INSERT INTO AreaMetropolitana VALUES('ZXTVA', 1);
INSERT INTO AreaMetropolitana VALUES('ERPLM', 0);
INSERT INTO AreaMetropolitana VALUES('ZCFBN', 1);
INSERT INTO AreaMetropolitana VALUES('QAFBM', 0);
INSERT INTO AreaMetropolitana VALUES('ZXPGH', 1);
INSERT INTO AreaMetropolitana VALUES('QKLFV', 1);
INSERT INTO AreaMetropolitana VALUES('APVGB', 0);
INSERT INTO AreaMetropolitana VALUES('AMCBL', 1);
INSERT INTO AreaMetropolitana VALUES('WTYHC', 0);


INSERT INTO Pattuglia VALUES(1, 2);
INSERT INTO Pattuglia VALUES(1, 6);
INSERT INTO Pattuglia VALUES(1, 8);
INSERT INTO Pattuglia VALUES(2, 1);
INSERT INTO Pattuglia VALUES(2, 6);
INSERT INTO Pattuglia VALUES(2, 5);
INSERT INTO Pattuglia VALUES(3, 11);
INSERT INTO Pattuglia VALUES(3, 4);
INSERT INTO Pattuglia VALUES(4, 11);
INSERT INTO Pattuglia VALUES(4, 16);
INSERT INTO Pattuglia VALUES(4, 9);
INSERT INTO Pattuglia VALUES(4, 7);
INSERT INTO Pattuglia VALUES(5, 10);
INSERT INTO Pattuglia VALUES(5, 3);
INSERT INTO Pattuglia VALUES(6, 12);
INSERT INTO Pattuglia VALUES(6, 17);
INSERT INTO Pattuglia VALUES(6, 15);
INSERT INTO Pattuglia VALUES(6, 1);
INSERT INTO Pattuglia VALUES(7, 3);
INSERT INTO Pattuglia VALUES(7, 4);
INSERT INTO Pattuglia VALUES(17, 6);
INSERT INTO Pattuglia VALUES(17, 7);
INSERT INTO Pattuglia VALUES(17, 9);
INSERT INTO Pattuglia VALUES(18, 14);
INSERT INTO Pattuglia VALUES(18, 10);
INSERT INTO Pattuglia VALUES(18, 1);
INSERT INTO Pattuglia VALUES(18, 7);
INSERT INTO Pattuglia VALUES(19, 2);
INSERT INTO Pattuglia VALUES(19, 17);
INSERT INTO Pattuglia VALUES(19, 18);



SELECT * FROM AgenteDiPolizia
SELECT * FROM AreaMetropolitana
SELECT * FROM Pattuglia



--1.Visualizzare l'elenco degli agenti che lavorano in "aree ad alto rischio" e hanno meno di 3 anni di servizio
SELECT DISTINCT ap.Nome, ap.Cognome, ap.CodiceFiscale, ap.DataDiNascita, ap.AnniServizio, am.CodiceArea
FROM AgenteDiPolizia ap INNER JOIN Pattuglia p ON p.IdAgente = ap.IdAgente
                        INNER JOIN AreaMetropolitana am ON am.IdArea = p.IdArea
WHERE am.AltoRischio = 1 AND ap.AnniServizio<3;



--2.Visualizzare il numero di agenti assegnati per ogni area geografica (numero agenti e codice area)
SELECT COUNT(ap.IdAgente) as [Numero di Agenti], am.CodiceArea
FROM AgenteDiPolizia ap INNER JOIN Pattuglia p ON p.IdAgente = ap.IdAgente
                        INNER JOIN AreaMetropolitana am ON am.IdArea = p.IdArea
GROUP BY am.CodiceArea
ORDER BY [Numero di Agenti] DESC  -- Non era richiesto ma l'ho fatto per completezza