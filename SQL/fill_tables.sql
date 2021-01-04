/*
 * QUESTO FILE CONTIENE TUTTO IL CODICE UTILE-NECESSARIO-INDISPENSABILE PER L'INSERIMENTO DEI DATI IN TUTTE LE TABELLE DEL
 * DATABASE DI PADUPIZZA.
 * IL CORRETTO UTILIZZO È MOLTO SEMPLICE ED INTUITIVO;
 * VI SONO DUE POSSIBILITÀ DI INSERIMENTO:
 * 1) COPIA-INCOLLA DEL CODICE SOTTOSTANTE NELLA SEZIONE "Query Tool" DEL SOFTWARE PgAdmin4©, PER POI L'ESECUZIONE DELLA
 *	  TRANSAZIONE
 * 2) NELLA SEZIONE "Query Tool" DEL SOFTWARE PgAdmin4©, UTILIZZANDO IL TASTO "Open File", È POSSIBILE SELEZIONARE UN FILE
 *    CON ESTENSIONE ".sql" PER L'IMPORTAZIONE DI CODICE DA ESEGUIRE NELLA QUERY. SELEZIONANDO QUESTA ALTERNATIVA, IL CODICE
 *    IN QUESTIONE SI TROVERÀ NEL PATH "~/PaduPizza/SQL/fill_tables.sql", DOVE "~" INDICA TUTTO IL PERCORSO DI CARTELLE NELLA
 *    MACCHINA DELL'UTENTE UTILIZZATORE RAPPRESENTANTE LA DIRECTORY MADRE, CONTENENTE LA DIRECTORY PADUPIZZA.
*/


/*
 * Query da utilizzare per l'inserimento di tutti i dati necessari nella tabella contenente gli ingredienti utili per
 * la creazione delle pizze
*/
INSERT INTO ingrediente (nome, conservazione) VALUES
	('Farina', 'Fuori frigo'),
	('Palline di pasta normale', 'Frigo'),
	('Palline di pasta famiglia', 'Frigo'),
	('Palline di pasta integrale', 'Frigo'),
	('Pomodoro', 'Fuori frigo'),
	('Origano', 'Fuori frigo'),
	('Aglio', 'Fuori frigo'),
	('Mozzarella', 'Frigo'),
	('Salamino piccante', 'Frigo'),
	('Würstel', 'Frigo'),
	('Prosciutto cotto', 'Frigo'),
	('Speck', 'Frigo'),
	('Porchetta', 'Frigo'),
	('Bresaola', 'Frigo'),
	('Pancetta affumicata', 'Frigo'),
	('Salsiccia', 'Frigo'),
	('Sfilacci di cavallo', 'Frigo'),
	('Lardo', 'Frigo'),
	('Pancetta arrotolata', 'Frigo'),
	('Sopressa', 'Frigo'),
	('Prosciutto crudo', 'Frigo'),
	('Asparagi', 'Fuori frigo'),
	('Funghi', 'Fuori frigo'),
	('Carciofi', 'Fuori frigo'),
	('Olive', 'Fuori frigo'),
	('Olive verdi', 'Fuori frigo'),
	('Olive nere', 'Fuori frigo'),
	('Olive taggiasche', 'Fuori frigo'),
	('Peperoni', 'Frigo'),
	('Peperoni grigliati', 'Frigo'),
	('Peperoni al forno', 'Frigo'),
	('Capperi', 'Fuori frigo'),
	('Zucchine grigliate', 'Frigo'),
	('Melanzane', 'Frigo'),
	('Melanzane grigliate', 'Frigo'),
	('Patate fritte', 'Freezer'),
	('Patate al forno', 'Frigo'),
	('Zucchine', 'Frigo'),
	('Cipolla rossa', 'Fuori frigo'),
	('Cipolla bianca', 'Fuori frigo'),
	('Funghi Porcini', 'Funghi frigo'),
	('Spinaci', 'Frigo'),
	('Rucola', 'Frigo'),
	('Pomodorini', 'Frigo'),
	('Basilico', 'Frigo'),
	('Piselli', 'Fuori frigo'),
	('Mais', 'Fuori frigo'),
	('Funghi Chiodini', 'Fuori frigo'),
	('Tartufo nero', 'Frigo'),
	('Tartufo bianco', 'Frigo'),
	('Crema di funghi', 'Frigo'),
	('Crema di zucca', 'Frigo'),
	('Peperoncino', 'Fuori frigo'),
	('Noci', 'Fuori frigo'),
	('Pere', 'Fuori frigo'),
	('Ananas', 'Frigo'),
	('Radicchio', 'Frigo'),
	('Radicchio di Treviso', 'Frigo'),
	('Radicchio di Chioggia', 'Frigo'),
	('Pinoli', 'Fuori frigo'),
	('Rosmarino', 'Fuori frigo'),
	('Pesto genovese', 'Frigo'),
	('Formaggio Asiago', 'Frigo'),
	('Formaggio Gorgonzola', 'Frigo'),
	('Grana Padano', 'Frigo'),
	('Ricotta', 'Frigo'),
	('Mozzarella di Bufala', 'Frigo'),
	('Panna', 'Frigo'),
	('Philadelphia', 'Frigo'),
	('Provola', 'Frigo'),
	('Provola affumicata', 'Frigo'),
	('Burrata', 'Frigo'),
	('Briè', 'Frigo'),
	('Stracchino', 'Frigo'),
	('Acciughe', 'Frigo'),
	('Salmone affumicato', 'Frigo'),
	('Tonno sott''olio', 'Fuori frigo'),
	('Frutti di mare', 'Frigo'),
	('Gamberetti', 'Frigo'),
	('Polpa di granchio', 'Frigo'),
	('Tonno', 'Fuori Frigo');

/*
 * Query da utilizzare per l'inserimento di tutti i dati necessari nella tabella formato_pizza, utili per
 * la distinzione dei vari formati delle pizze negli ordini
*/
INSERT INTO formato_pizza VALUES 
	('Mignon', -1.00),
	('Normale', 0.00),
	('Famiglia', 1.00),
	('Doppia pasta', 1.50),
	('Integrale', 1.50),
	('Calzone', 0.50);

INSERT INTO cliente (cognome,indirizzo) VALUES 
	('Rossi','Via Francesco Girardi 128, Padova, PD'),
	('Villa','Via Sedile di Porto 23, Padova, PD'),
	('Esposito','Via Giotto 64, Verona, VR'),
	('Gentile','Via Santa Teresa degli Scalzi 128, Tombolo, PD'),
	('Bruno','P.O. Box 610, 2457 Risus. St.'),
	('Ferrante','Ap #968-7062 Velit. Ave'),
	('Ferrero','7211 Phasellus Avenue'),
	('Montanari','Ap #264-6008 Libero Av.'),
	('Pagano','9115 Massa. Rd.'),
	('Farina','3502 Fusce Road'),
	('De Santis','P.O. Box 565, 4346 Integer Rd.'),
	('Caruso','152 Ullamcorper, Road'),
	('Napolitano','1768 Sodales Ave'),
	('Caruso','Ap #405-6132 Nibh Rd.'),
	('Mele','Ap #636-789 Eu St.'),
	('Bernardi','431-9948 Convallis St.'),
	('Santoro','Ap #176-326 Aliquam Rd.'),
	('Ferrero','571-4109 Praesent Ave'),
	('Lombardo','706-495 Fermentum St.'),
	('Pastore','3422 Nulla Av.'),
	('Moro','Ap #541-1980 Arcu. St.'),
	('Ferraro','Ap #740-8475 Sit Avenue'),
	('Barone','P.O. Box 698, 6698 Id, St.'),
	('Perrone','Ap #402-8224 Sapien St.'),
	('Farina','7169 Dui. Rd.'),
	('Rizzi','4629 Libero. Ave'),
	('Grasso','P.O. Box 194, 3081 Malesuada St.'),
	('Valente','986-8728 Dolor Rd.'),
	('Giuliani','Ap #845-3506 Malesuada Street'),
	('Piras','P.O. Box 442, 7589 Mauris Street'),
	('De Rosa','614 Integer St.'),
	('Grasso','4387 Turpis Rd.'),
	('Pinna','7879 Natoque Road'),
	('Sorrentino','4637 Urna Street'),
	('Rinaldi','8926 Ullamcorper, Ave'),
	('Grasso','224 In Street'),
	('Fumagalli','Ap #572-2377 Mi Rd.'),
	('Costantini','6868 Tortor. Road'),
	('Esposito','P.O. Box 605, 427 Vitae, Avenue'),
	('Ferretti','P.O. Box 526, 490 Leo. Street'),
	('De Santis','Ap #114-5184 Libero. St.'),
	('Bruni','581-8707 Mattis. Street'),
	('Martini','2478 Ullamcorper Rd.'),
	('Villa','Ap #671-4445 Magna. Road'),
	('Milani','P.O. Box 501, 2657 Justo Avenue'),
	('Catalano','486-9014 Nec St.'),
	('Sala','Ap #501-4490 Adipiscing Street'),
	('Parisi','Ap #404-4495 Egestas Avenue'),
	('Riva','460-1403 In Av.'),
	('Montanari','P.O. Box 731, 5194 Malesuada St.'),
	('Grassi','640-8781 Pellentesque Av.'),
	('Sala','205-8224 Ut Av.'),
	('Ferro','2808 In St.'),
	('Moro','1252 Nam Avenue'),
	('Pinna','Ap #520-8337 Mauris Street'),
	('Serra','641-2673 Tellus Road'),
	('Albanese','428-2049 Rhoncus. Rd.'),
	('Bianco','379-5746 Vulputate Rd.'),
	('Greco','P.O. Box 245, 953 Risus. Rd.'),
	('Messina','574-5579 Sem St.'),
	('Ferro','835-9834 Tempus Avenue'),
	('Grimaldi','143-3512 Nunc St.'),
	('Sala','230 Quam Rd.'),
	('Villa','Ap #534-9703 Orci Av.'),
	('Benedetti','P.O. Box 899, 4429 Massa. St.'),
	('Conte','868-5984 Nulla Road'),
	('Di Stefano','Ap #459-570 Nullam Avenue'),
	('Russo','690-1716 Nisi. Rd.'),
	('Leone','P.O. Box 525, 5310 Lacus, St.'),
	('Sanna','Ap #795-1294 Sit Av.'),
	('Antonelli','Ap #717-1556 Consequat St.'),
	('Vitale','Ap #408-682 Consequat Street'),
	('Palumbo','Ap #544-7883 Mauris Rd.'),
	('Aiello','1990 Tempus St.'),
	('Sanna','7766 Sed Rd.'),
	('Proietti','Ap #823-8038 Libero. Avenue'),
	('Conte','P.O. Box 172, 9085 Penatibus Avenue'),
	('Conte','P.O. Box 415, 9057 Libero Street'),
	('Costantini','P.O. Box 837, 1436 Orci, Rd.'),
	('Ferrara','P.O. Box 651, 6976 Elit Street'),
	('Sorrentino','1548 In Rd.'),
	('Vitali','P.O. Box 786, 9851 Taciti Av.'),
	('Ruggiero','P.O. Box 649, 3983 Dolor Av.'),
	('Ricciardi','P.O. Box 571, 445 Eget, St.'),
	('Sanna','8894 Ac St.'),
	('Ferrante','978-9300 Sed St.'),
	('Zanetti','Ap #146-1491 Sit Ave'),
	('Valentini','836-5738 Vitae Rd.'),
	('Vitale','186-5408 Fringilla Rd.'),
	('Martinelli','Ap #995-589 Neque. St.'),
	('Martini','497 Lacus. Av.'),
	('Costa','603-8657 Tincidunt, Avenue'),
	('Ferri','P.O. Box 715, 6646 Nunc Ave'),
	('Pellegrino','P.O. Box 353, 8544 Ac Av.'),
	('Ferrante','9370 Aenean Street'),
	('Catalano','P.O. Box 164, 4979 Et, St.'),
	('Franco','Ap #985-5498 Eu, St.'),
	('Brambilla','365-5427 Odio. St.'),
	('Catalano','Ap #911-5365 Vestibulum, St.'),
	('Ferraro','P.O. Box 292, 8152 Cras Avenue');


INSERT INTO stipendio_base (impiego, stipendio) VALUES
	('Domiciliare_Furgone', 25.0),
	('Domiciliare_Macchina', 20.0),
	('Cassiere', 30.0),
	('Pizzaiolo', 40.0),
	('Aiuto_Pizzaiolo', 35.0);

INSERT INTO calendario (giorno_chiusura, ora_apertura, ora_chiusura) VALUES 
	(1, '18:00', '22:00'),
	(2, '18:00', '22:00'),
	(3, '18:00', '22:00'),
	(4, '18:00', '22:00'),
	(5, '18:00', '22:00'),
	(6, '18:00', '22:00'),
	(7, '18:00', '22:00');

INSERT INTO pizza (nome, prezzo) VALUES
	('Marinara', 4.00),
	('Margherita', 4.50),
	('Viennese', 5.00),
	('Diavola', 5.00),
	('Prosciutto cotto', 5.00),
	('Siciliana', 6.50),
	('Pugliese', 5.00),
	('Romana', 5.50),
	('Prosciutto e funghi', 6.00),
	('Misto bosco', 6.50),
	('Parmiggiana', 7.00),
	('Estate', 7.00),
	('Zucchine', 6.50),
	('Bufalina', 7.00),
	('Prosciutto e carciofi', 6.50),
	('Tonno e cipolla', 6.00),
	('4 stagioni', 6.50),
	('4 formaggi', 6.50),
	('Capricciosa', 6.50),
	('Asparagi', 5.00),
	('Gorgonzola', 5.00),
	('Inglesina', 6.00),
	('Peperoni', 5.00),
	('Philadelphia', 5.20),
	('Porchetta', 6.00),
	('Porcini', 5.50),
	('Radicchio', 4.80),
	('Rucola e grana', 5.50),
	('Tirolese', 6.00),
	('Tonno', 6.00),
	('Treviso', 5.50),
	('Turbo', 8.00),
	('Verdure ai ferri', 6.50),
	('Zingara', 7.00),
	('Bresaola rucola e grana', 7.00),
	('Brie e speck', 7.00),
	('Gamberetti', 6.00),
	('Gorgonzola e salsiccia', 6.00),
	('Gorgonzola e speck', 7.00),
	('Mari e monti', 7.00),
	('Melanzane e crudo', 8.00),
	('Melanzane e ricotta', 6.50),
	('Nick', 8.00),
	('Montanara', 8.00),
	('Porcini crudo e grana', 7.50),
	('Porcini e provola', 7.00),
	('Porcini e ricotta', 7.00),
	('Porcini e salsiccia', 7.00),
	('Salsiccia', 5.00),
	('Provola e pancetta', 6.00),
	('Provola e speck', 6.50),
	('Sfilacci', 6.50),
	('Ricotta e spinaci', 5.50),
	('Tombolina', 6.00);

INSERT INTO ricetta (pizza, ingrediente) VALUES
	('Marinara', 'Pomodoro'),
	('Marinara', 'Aglio'),
	('Marinara', 'Origano'),
	('Margherita', 'Pomodoro'),
	('Margherita', 'Mozzarella'),
	('Viennese', 'Pomodoro'),
	('Viennese', 'Mozzarella'),
	('Viennese', 'Würstel'),
	('Diavola', 'Pomodoro'),
	('Diavola', 'Mozzarella'),
	('Diavola', 'Salamino piccante'),
	('Prosciutto cotto', 'Pomodoro'),
	('Prosciutto cotto', 'Mozzarella'),
	('Prosciutto cotto', 'Prosciutto cotto'),
	('Siciliana', 'Pomodoro'),
	('Siciliana', 'Mozzarella'),
	('Siciliana', 'Acciughe'),
	('Siciliana', 'Salamino piccante'),
	('Siciliana', 'Capperi'),
	('Siciliana', 'Olive verdi'),
	('Pugliese', 'Pomodoro'),
	('Pugliese', 'Mozzarella'),
	('Pugliese', 'Cipolla bianca'),
	('Romana', 'Pomodoro'),
	('Romana', 'Mozzarella'),
	('Romana', 'Acciughe'),
	('Romana', 'Origano'),
	('Prosciutto e funghi', 'Pomodoro'),
	('Prosciutto e funghi', 'Mozzarella'),
	('Prosciutto e funghi', 'Prosciutto cotto'),
	('Prosciutto e funghi', 'Funghi'),
	('Misto bosco', 'Pomodoro'),
	('Misto bosco', 'Mozzarella'),
	('Misto bosco', 'Funghi'),
	('Parmiggiana', 'Pomodoro'),
	('Parmiggiana', 'Mozzarella'),
	('Parmiggiana', 'Melanzane'),
	('Parmiggiana', 'Grana Padano'),
	('Estate', 'Pomodoro'),
	('Estate', 'Mozzarella'),
	('Estate', 'Pomodorini'),
	('Estate', 'Basilico'),
	('Zucchine', 'Pomodoro'),
	('Zucchine', 'Mozzarella'),
	('Zucchine', 'Zucchine'),
	('Bufalina', 'Pomodoro'),
	('Bufalina', 'Mozzarella di Bufala'),
	('Prosciutto e carciofi', 'Pomodoro'),
	('Prosciutto e carciofi', 'Mozzarella'),
	('Prosciutto e carciofi', 'Prosciutto cotto'),
	('Prosciutto e carciofi', 'Carciofi'),
	('Tonno e cipolla', 'Pomodoro'),
	('Tonno e cipolla', 'Mozzarella'),
	('Tonno e cipolla', 'Tonno'),
	('Tonno e cipolla', 'Cipolla bianca'),
	('4 stagioni', 'Pomodoro'),
	('4 stagioni', 'Mozzarella'),
	('4 stagioni', 'Prosciutto cotto'),
	('4 stagioni', 'Funghi'),
	('4 stagioni', 'Carciofi'),
	('4 formaggi', 'Pomodoro'),
	('4 formaggi', 'Mozzarella'),
	('4 formaggi', 'Formaggio Gorgonzola'),
	('4 formaggi', 'Formaggio Asiago'),
	('Capricciosa', 'Pomodoro'),
	('Capricciosa', 'Mozzarella'),
	('Capricciosa', 'Prosciutto cotto'),
	('Capricciosa', 'Funghi'),
	('Capricciosa', 'Carciofi'),
	('Capricciosa', 'Capperi'),
	('Asparagi', 'Pomodoro'),
	('Asparagi', 'Mozzarella'),
	('Asparagi', 'Asparagi'),
	('Gorgonzola', 'Pomodoro'),
	('Gorgonzola', 'Mozzarella'),
	('Gorgonzola', 'Formaggio Gorgonzola'),
	('Inglesina', 'Pomodoro'),
	('Inglesina', 'Mozzarella'),
	('Inglesina', 'Prosciutto crudo'),
	('Peperoni', 'Pomodoro'),
	('Peperoni', 'Mozzarella'),
	('Peperoni', 'Peperoni al forno'),
	('Philadelphia', 'Pomodoro'),
	('Philadelphia', 'Mozzarella'),
	('Philadelphia', 'Philadelphia'),
	('Porchetta', 'Pomodoro'),
	('Porchetta', 'Mozzarella'),
	('Porchetta', 'Porchetta'),
	('Porcini', 'Pomodoro'),
	('Porcini', 'Mozzarella'),
	('Porcini', 'Funghi Porcini'),
	('Radicchio', 'Pomodoro'),
	('Radicchio', 'Mozzarella'),
	('Radicchio', 'Radicchio'),
	('Rucola e grana', 'Pomodoro'),
	('Rucola e grana', 'Mozzarella'),
	('Rucola e grana', 'Rucola'),
	('Rucola e grana', 'Grana Padano'),
	('Tirolese', 'Pomodoro'),
	('Tirolese', 'Mozzarella'),
	('Tirolese', 'Speck'),
	('Tonno', 'Pomodoro'),
	('Tonno', 'Mozzarella'),
	('Tonno', 'Tonno'),
	('Treviso', 'Pomodoro'),
	('Treviso', 'Mozzarella'),
	('Treviso', 'Radicchio di Treviso'),
	('Turbo', 'Pomodoro'),
	('Turbo', 'Mozzarella'),
	('Turbo', 'Prosciutto cotto'),
	('Turbo', 'Funghi'),
	('Turbo', 'Carciofi'),
	('Turbo', 'Olive verdi'),
	('Turbo', 'Pomodorini'),
	('Turbo', 'Asparagi'),
	('Turbo', 'Salamino piccante'),
	('Turbo', 'Würstel'),
	('Verdure ai ferri', 'Pomodoro'),
	('Verdure ai ferri', 'Mozzarella'),
	('Verdure ai ferri', 'Melanzane grigliate'),
	('Verdure ai ferri', 'Peperoni al forno'),
	('Verdure ai ferri', 'Zucchine grigliate'),
	('Zingara', 'Pomodoro'),
	('Zingara', 'Mozzarella'),
	('Zingara', 'Salamino piccante'),
	('Zingara', 'Funghi'),
	('Zingara', 'Olive'),
	('Zingara', 'Peperoni al forno'),
	('Bresaola rucola e grana', 'Pomodoro'),
	('Bresaola rucola e grana', 'Mozzarella'),
	('Bresaola rucola e grana', 'Bresaola'),
	('Bresaola rucola e grana', 'Rucola'),
	('Bresaola rucola e grana', 'Grana Padano'),
	('Brie e speck', 'Pomodoro'),
	('Brie e speck', 'Mozzarella'),
	('Brie e speck', 'Briè'),
	('Brie e speck', 'Speck'),
	('Gamberetti', 'Pomodoro'),
	('Gamberetti', 'Mozzarella'),
	('Gamberetti', 'Gamberetti'),
	('Gorgonzola e salsiccia', 'Pomodoro'),
	('Gorgonzola e salsiccia', 'Mozzarella'),
	('Gorgonzola e salsiccia', 'Formaggio Gorgonzola'),
	('Gorgonzola e salsiccia', 'Salsiccia'),
	('Gorgonzola e speck', 'Pomodoro'),
	('Gorgonzola e speck', 'Mozzarella'),
	('Gorgonzola e speck', 'Formaggio Gorgonzola'),
	('Gorgonzola e speck', 'Speck'),
	('Mari e monti', 'Pomodoro'),
	('Mari e monti', 'Mozzarella'),
	('Mari e monti', 'Funghi'),
	('Mari e monti', 'Gamberetti'),
	('Melanzane e crudo', 'Pomodoro'),
	('Melanzane e crudo', 'Mozzarella'),
	('Melanzane e crudo', 'Melanzane grigliate'),
	('Melanzane e crudo', 'Prosciutto crudo'),
	('Melanzane e ricotta', 'Pomodoro'),
	('Melanzane e ricotta', 'Mozzarella'),
	('Melanzane e ricotta', 'Melanzane grigliate'),
	('Melanzane e ricotta', 'Ricotta'),
	('Nick', 'Pomodoro'),
	('Nick', 'Mozzarella'),
	('Nick', 'Funghi Porcini'),
	('Nick', 'Pomodorini'),
	('Nick', 'Porchetta'),
	('Montanara', 'Pomodoro'),
	('Montanara', 'Mozzarella'),
	('Montanara', 'Funghi Chiodini'),
	('Montanara', 'Pancetta affumicata'),
	('Montanara', 'Formaggio Gorgonzola'),
	('Porcini crudo e grana', 'Pomodoro'),
	('Porcini crudo e grana', 'Mozzarella'),
	('Porcini crudo e grana', 'Funghi Porcini'),
	('Porcini crudo e grana', 'Prosciutto crudo'),
	('Porcini crudo e grana', 'Grana Padano'),
	('Porcini e provola', 'Pomodoro'),
	('Porcini e provola', 'Mozzarella'),
	('Porcini e provola', 'Funghi Porcini'),
	('Porcini e provola', 'Provola'),
	('Porcini e ricotta', 'Pomodoro'),
	('Porcini e ricotta', 'Mozzarella'),
	('Porcini e ricotta', 'Funghi Porcini'),
	('Porcini e ricotta', 'Ricotta'),
	('Porcini e salsiccia', 'Pomodoro'),
	('Porcini e salsiccia', 'Mozzarella'),
	('Porcini e salsiccia', 'Funghi Porcini'),
	('Porcini e salsiccia', 'Salsiccia'),
	('Salsiccia', 'Pomodoro'),
	('Salsiccia', 'Mozzarella'),
	('Salsiccia', 'Salsiccia'),
	('Provola e pancetta', 'Pomodoro'),
	('Provola e pancetta', 'Mozzarella'),
	('Provola e pancetta', 'Provola'),
	('Provola e pancetta', 'Pancetta affumicata'),
	('Provola e speck', 'Pomodoro'),
	('Provola e speck', 'Mozzarella'),
	('Provola e speck', 'Provola'),
	('Provola e speck', 'Speck'),
	('Sfilacci', 'Pomodoro'),
	('Sfilacci', 'Mozzarella'),
	('Sfilacci', 'Sfilacci di cavallo'),
	('Ricotta e spinaci', 'Pomodoro'),
	('Ricotta e spinaci', 'Mozzarella'),
	('Ricotta e spinaci', 'Ricotta'),
	('Ricotta e spinaci', 'Spinaci'),
	('Tombolina', 'Pomodoro'),
	('Tombolina', 'Mozzarella'),
	('Tombolina', 'Stracchino'),
	('Tombolina', 'Rucola');


INSERT INTO amministrazione (mail, numero_tel, fax, indirizzo, citta, provincia) VALUES 
('kchelsom0@etsy.com', '822-849-1266', '533-676-6803', '67 Canary Avenue', 'Roma', 'RM'),
('twagenen1@goodreads.com', '621-112-4035', '852-798-7909', '00 Colorado Park', 'Livorno', 'LI'),
 ('ejeffcoate2@weebly.com', '796-762-9015', '825-885-7459', '09381 Sugar Avenue', 'Roma', 'RM'),
 ('gpriest3@chicagotribune.com', '673-437-2778', '655-148-9173', '14 Lotheville Terrace', 'Trieste', 'tr'),
 ('dhuchot4@cocolog-nifty.com', '254-395-4121', '313-135-2800', '0380 Blue Bill Park Alley', 'Villanova', 'PD'),
 ('lritchie5@infoseek.co.jp', '411-660-8527', '480-476-9127', '7 Delaware Lane', 'Roma', 'RM'),
 ('rglabach6@prweb.com', '477-300-1120', '840-103-5092', '713 Ilene Center', 'Padova', 'PD'),
 ('mgurry7@qq.com', '751-259-4703', '719-386-3238', '441 Charing Cross Terrace', 'Palermo', 'PA'),
 ('mcarwardine8@canalblog.com', '194-906-7868', '120-391-2288', '42 Buell Way', 'Padova', 'PD'),
 ('vosselton9@marketwatch.com', '280-719-6671', '596-748-3523', '0 Park Meadow Junction', 'Messina', 'MS'),
 ('bbeggia@geocities.com', '883-692-7770', '709-533-5316', '76412 Oriole Way', 'Napoli', 'NA'),
 ('dlamartineb@gravatar.com', '379-910-0091', '795-245-1225', '717 Memorial Terrace', 'Genova', 'GE'),
 ('mrimellc@latimes.com', '170-366-2107', '241-601-0616', '9 Burning Wood Terrace', 'Villanova', 'PD'),
 ('mbiermatowiczd@google.com.hk', '785-758-0598', '991-595-3116', '5 Marcy Place', 'Bergamo', 'BE'),
 ('rattriee@tmall.com', '166-296-9502', '230-524-2251', '56371 Prairieview Pass', 'Roma', 'RM'),
 ('mdradeyf@va.gov', '387-311-5713', '799-389-1776', '78032 Dorton Pass', 'Trieste', 'TR'),
 ('rdjurevicg@people.com.cn', '347-628-0304', '232-968-8391', '20843 Pearson Drive', 'Palermo', 'PA'),
 ('dgoodfelloweh@sun.com', '932-254-4438', '678-864-6602', '534 Darwin Plaza', 'Catania', 'CA'),
 ('cmcgreadyi@kickstarter.com', '472-265-7445', '537-801-6256', '7380 Melrose Park', 'Bologna', 'BO'),
 ('zetchellsj@ted.com', '783-104-6014', '618-475-8397', '55 Mayfield Plaza', 'Livorno', 'LI'),
 ('emcquirkk@indiegogo.com', '399-881-1023', '788-208-9897', '760 Parkside Park', 'Brescia', 'BR'),
 ('lwakel@senate.gov', '621-278-6118', '202-404-8003', '5535 Erie Court', 'Messina', 'MS'),
 ('ppidgeleym@ftc.gov', '715-694-7641', '610-405-2101', '76038 Mockingbird Trail', 'Laspezia', 'LS'),
 ('jaldien@arizona.edu', '217-173-4442', '690-811-4269', '08056 Warbler Terrace', 'Catania', 'CA'),
 ('kiannio@theatlantic.com', '909-120-3685', '287-131-8516', '39939 Michigan Trail', 'Roma', 'RM'),
 ('lcurgenvenp@quantcast.com', '831-622-2038', '750-218-4199', '6109 Mariners Cove Trail', 'Milano', 'MI'),
 ('mstowteq@hubpages.com', '711-455-0461', '992-763-6119', '36786 Walton Parkway', 'Napoli', 'NA'),
 ('mcomfordr@bizjournals.com', '450-654-7401', '325-429-1379', '9 Maple Circle', 'Messina', 'MS'),
 ('adibbss@webs.com', '135-272-3260', '194-666-6597', '34277 Rieder Avenue', 'Milano', 'MI'),
 ('ntimminst@time.com', '545-186-1474', '211-866-3888', '14 Fuller Drive', 'Palermo', 'PA'),
 ('jalsopu@independent.co.uk', '709-861-9095', '946-820-3833', '58468 Delaware Junction', 'Padova', 'PD'),
 ('hhawkswoodv@redcross.org', '895-513-4937', '637-987-0660', '3875 Jenifer Street', 'Venezia', 'VE'),
 ('epeeverw@smh.com.au', '998-875-0297', '861-864-7481', '316 Dahle Way', 'Trieste', 'TR'),
 ('ljellymanx@zimbio.com', '807-645-6206', '310-725-0118', '1 Paget Junction', 'Messina', 'MS'),
 ('beddowy@wikipedia.org', '365-602-6482', '911-236-6256', '7301 Emmet Circle', 'Firenze', 'FI'),
 ('adougalz@arstechnica.com', '382-906-6520', '727-204-7898', '03983 Messerschmidt Park', 'Roma', 'RM'),
 ('jwickey10@wiley.com', '208-397-1267', '401-830-7488', '618 Arapahoe Hill', 'Napoli', 'NA'),
 ('draffeorty11@ezinearticles.com', '382-347-7795', '386-140-4768', '592 Green Ridge Avenue', 'Trieste', 'TR'),
 ('mtrevenu12@shutterfly.com', '127-998-5173', '267-750-9019', '8339 Village Terrace', 'Roma', 'RM'),
 ('ccrebott13@pinterest.com', '367-153-3945', '348-690-0619', '81818 Jana Crossing', 'Brescia', 'BR'),
 ('kblaymires14@sfgate.com', '214-206-4630', '550-154-7881', '7810 Nelson Center', 'Catania', 'CA'),
 ('gmcneely15@diigo.com', '102-932-3536', '120-612-9525', '02486 Division Alley', 'Napoli', 'NA'),
 ('jbails16@goo.ne.jp', '300-874-2897', '196-578-5422', '3577 Roxbury Junction', 'Messina', 'MS'),
 ('aizak17@dmoz.org', '814-190-5970', '664-203-0811', '8 Merry Alley', 'Roma', 'RM'),
 ('karnoult18@msu.edu', '415-132-4779', '175-279-9335', '9 Columbus Terrace', 'Torino', 'TO'),
 ('cpickerin19@usgs.gov', '209-552-2827', '197-859-3872', '90 Artisan Plaza', 'Palermo', 'PA'),
 ('aalexandersson1a@edublogs.org', '629-524-3566', '479-129-1657', '7600 Luster Hill', 'Genova', 'GE'),
 ('ghartshorne1b@noaa.gov', '711-338-4957', '648-740-2774', '4 Redwing Circle', 'Milano', 'MI'),
 ('wjaggi1c@vistaprint.com', '993-231-8991', '621-329-5150', '235 Algoma Street', 'Roma', 'RM'),
 ('charms1d@wired.com', '180-401-6512', '906-128-9442', '65 Sauthoff Drive', 'Verona', 'VR'),
 ('hwhiscard1e@gov.uk', '606-239-1920', '188-762-9486', '360 Ridgeway Street', 'Laspezia', 'LS'),
 ('hmartonfi1f@loc.gov', '542-989-6731', '390-981-6183', '191 Dakota Parkway', 'Roma', 'RM'),
 ('nskylett1g@phoca.cz', '702-670-2133', '471-154-6680', '9997 Warrior Avenue', 'Bergamo', 'BE'),
 ('amckinnon1h@google.it', '494-546-2833', '676-285-7986', '6 Roxbury Pass', 'Perugia', 'PR'),
 ('dmateiko1i@sciencedaily.com', '714-181-4706', '637-470-3639', '14 Knutson Court', 'Roma', 'RM'),
 ('ufrankes1j@quantcast.com', '781-923-2242', '398-969-6199', '2388 Nobel Circle', 'Mestre', 'VE'),
 ('candrzejak1k@youku.com', '356-776-3672', '663-346-7719', '1410 Dawn Terrace', 'Padova', 'PD'),
 ('mgreswell1l@tiny.cc', '638-773-9301', '370-201-3374', '74549 Meadow Vale Drive', 'Pescara', 'PE'),
 ('gmcilhagga1m@chicagotribune.com', '544-787-9359', '191-215-5936', '55 Lake View Crossing', 'Messina', 'MS'),
 ('ehurworth1n@cloudflare.com', '847-892-8198', '668-189-2607', '51 Fallview Parkway', 'Salerno', 'SA'),
 ('iladdle1o@webmd.com', '682-233-4794', '650-148-3248', '612 Express Avenue', 'Catania', 'CA'),
 ('acrockford1p@psu.edu', '734-212-2355', '501-297-1586', '0422 Hollow Ridge Way', 'Padova', 'PD'),
 ('dtschirschky1q@bbc.co.uk', '147-346-4160', '820-733-6326', '1 Old Gate Place', 'Messina', 'MS'),
 ('jorable1r@wikipedia.org', '538-692-6244', '779-250-4949', '27 Loomis Plaza', 'Pescara', 'PE'),
 ('wfieldhouse1s@weather.com', '993-975-5001', '561-446-4518', '544 Kenwood Junction', 'Cagliari', 'CG'),
 ('esunner1t@globo.com', '595-428-5452', '885-856-5464', '23866 Maple Wood Junction', 'Milano', 'MI'),
 ('lgilliard1u@squidoo.com', '594-341-7214', '893-699-7046', '74257 Sullivan Court', 'Villanova', 'PD'),
 ('mfeehan1v@github.com', '112-123-7897', '753-423-3518', '06 Stuart Court', 'Messina', 'MS'),
 ('lrosensaft1w@engadget.com', '175-415-1336', '541-688-7950', '4 Acker Place', 'Torino', 'TO'),
 ('hvasiliev1x@oracle.com', '814-246-8256', '710-250-1568', '3 Manitowish Lane', 'Milano', 'MI'),
 ('apeschka1y@home.pl', '598-510-5466', '829-838-0814', '166 Commercial Place', 'Roma', 'RM'),
 ('hkarpinski1z@marriott.com', '889-617-6769', '868-583-3874', '9685 6th Pass', 'Trieste', 'TR'),
 ('sgettins20@squidoo.com', '880-457-0649', '728-926-6643', '1 Esker Pass', 'Laspezia', 'LS'),
 ('dmullin21@blinklist.com', '799-452-1548', '579-897-9639', '6139 Bonner Road', 'Roma', 'RM'),
 ('faps22@pbs.org', '747-460-4822', '771-836-7778', '251 Arapahoe Junction', 'Catania', 'CA'),
 ('bgoodread23@gizmodo.com', '879-725-6681', '763-722-2088', '954 Fairfield Lane', 'Napoli', 'NA'),
 ('gisitt24@paginegialle.it', '180-376-3352', '568-698-2412', '91897 Waxwing Center', 'Reggio Calabria', 'RC'),
 ('fgoudman25@bandcamp.com', '384-192-9411', '394-403-4230', '1930 Nelson Circle', 'Verona', 'VR'),
 ('fblow26@vk.com', '511-417-8249', '525-598-0644', '943 Manitowish Trail', 'Roma', 'RM'),
 ('rrimer27@huffingtonpost.com', '250-818-8428', '432-534-4349', '29319 Anhalt Terrace', 'Ancona', 'AN'),
 ('jsalmen28@statcounter.com', '150-539-9698', '239-714-7297', '5 Sherman Plaza', 'Bergamo', 'BE'),
 ('jredmond29@ft.com', '316-495-8850', '849-994-8723', '64092 Longview Junction', 'Palermo', 'PA'),
 ('ddonnison2a@elegantthemes.com', '954-224-7009', '422-990-5781', '208 Rigney Place', 'Bologna', 'BO'),
 ('tnelthrop2b@blog.com', '466-128-9700', '486-376-4162', '76 Debs Center', 'Cagliari', 'CA'),
 ('ograser2c@sina.com.cn', '665-901-8423', '537-314-7811', '21 Southridge Avenue', 'Bergamo', 'BE'),
 ('myeatman2d@mtv.com', '821-548-1139', '637-891-9632', '761 Canary Road', 'Firenze', 'FI'),
 ('ibolens2e@opera.com', '248-683-3772', '370-732-7870', '58 Cambridge Way', 'Roma', 'RM'),
 ('fendacott2f@ow.ly', '969-334-6379', '517-645-9053', '64537 Thierer Center', 'Salerno', 'SA'),
 ('kcruden2g@mashable.com', '106-698-9687', '155-888-3421', '06599 Oak Valley Pass', 'Messina', 'MS'),
 ('taishford2h@berkeley.edu', '209-654-4523', '994-276-9140', '12 Summerview Point', 'Milano', 'MI'),
 ('seastam2i@ibm.com', '734-136-0416', '349-900-3054', '6 Bayside Road', 'Napoli', 'NA'),
 ('ptidbold2j@youtu.be', '249-993-1599', '203-697-1190', '65750 Helena Street', 'Bologna', 'BO'),
 ('rsnalham2k@addtoany.com', '987-367-6598', '676-570-8681', '8 Swallow Point', 'Livorno', 'LI'),
 ('wcreswell2l@biglobe.ne.jp', '173-799-4078', '155-250-5607', '17892 Farwell Road', 'Mestre', 'VE'),
 ('cdesesquelle2m@163.com', '707-804-3064', '433-746-1159', '77 Everett Point', 'Catania', 'CA'),
 ('fshere2n@unesco.org', '724-628-9301', '406-975-8371', '02 Nelson Place', 'Reggio Calabria', 'RC'),
 ('cskehan2o@craigslist.org', '901-515-6354', '683-573-1392', '27472 Walton Circle', 'Genova', 'GE'),
 ('fmockford2p@eventbrite.com', '810-639-8434', '272-118-5727', '963 Anniversary Center', 'Napoli', 'NA'),
 ('rhalladey2q@goo.gl', '512-307-3797', '976-798-5636', '7648 Cherokee Lane', 'Padova', 'PD'),
 ('rsheard2r@bloomberg.com', '921-124-7516', '493-698-1137', '06 International Hill', 'Milano', 'MI');