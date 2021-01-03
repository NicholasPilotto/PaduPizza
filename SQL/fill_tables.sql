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
	('Pomodoro', 'Fuori frigo');
	('Aglio', 'Fuori frigo');
	('Mozzarella', 'Frigo');
	('Salamino piccante', 'Frigo');
	('Würstel', 'Frigo');
	('Prosciutto cotto', 'Frigo');
	('Speck', 'Frigo');
	('Porchetta', 'Frigo');
	('Bresaola', 'Frigo');
	('Pancetta affumicata', 'Frigo');
	('Salsiccia', 'Frigo');
	('Sfilacci di cavallo', 'Frigo');
	('Lardo', 'Frigo');
	('Pancetta arrotolata', 'Frigo');
	('Sopressa', 'Frigo');
	('Prosciutto crudo', 'Frigo');
	('Funghi', 'Fuori frigo');
	('Carciofi', 'Fuori frigo');
	('Olive verdi', 'Fuori frigo');
	('Olive nere', 'Fuori frigo');
	('Olive taggiasche', 'Fuori frigo');
	('Peperoni', 'Frigo');
	('Peperoni grigliati', 'Frigo');
	('Peperoni al forno', 'Frigo');
	('Capperi', 'Fuori frigo');
	('Zucchine grigliate', 'Frigo');
	('Melanzane', 'Frigo');
	('Melanzane grigliate', 'Frigo');
	('Patate fritte', 'Freezer');
	('Patate al forno', 'Frigo');
	('Zucchine', 'Frigo');
	('Cipolla rossa', 'Fuori frigo');
	('Cipolla bianca', 'Fuori frigo');
	('Funghi Porcini', 'Funghi frigo');
	('Spinaci', 'Frigo');
	('Rucola', 'Frigo');
	('Pomodorini', 'Frigo');
	('Basilico', 'Frigo');
	('Piselli', 'Fuori frigo');
	('Mais', 'Fuori frigo');
	('Funghi Chiodini', 'Fuori frigo');
	('Tartufo nero', 'Frigo');
	('Tartufo bianco', 'Frigo');
	('Crema di funghi', 'Frigo');
	('Crema di zucca', 'Frigo');
	('Peperoncino', 'Fuori frigo');
	('Noci', 'Fuori frigo');
	('Pere', 'Fuori frigo');
	('Ananas', 'Frigo');
	('Radicchio', 'Frigo');
	('Radicchio di Treviso', 'Frigo');
	('Radicchio di Chioggia', 'Frigo');
	('Pinoli', 'Fuori frigo');
	('Rosmarino', 'Fuori frigo');
	('Pesto genovese', 'Frigo');
	('Formaggio Asiago', 'Frigo');
	('Formaggio Gorgonzola', 'Frigo');
	('Grana Padano', 'Frigo');
	('Ricotta', 'Frigo');
	('Mozzarella di Bufala', 'Frigo');
	('Panna', 'Frigo');
	('Philadelphia', 'Frigo');
	('Provola', 'Frigo');
	('Provola affumicata', 'Frigo');
	('Burrata', 'Frigo');
	('Briè', 'Frigo');
	('Acciughe', 'Frigo');
	('Salmone affumicato', 'Frigo');
	('Tonno sott''olio', 'Fuori frigo');
	('Frutti di mare', 'Frigo');
	('Gamberetti', 'Frigo');
	('Polpa di granchio', 'Frigo');

/*
 * Query da utilizzare per l'inserimento di tutti i dati necessari nella tabella formato_pizza, utili per
 * la distinzione dei vari formati delle pizze negli ordini
*/
INSERT INTO formato_pizza VALUES 
	('Mignon', -1.00);
	('Normale', 0.00);
	('Famiglia', 1.00);
	('Doppia pasta', 1.50);
	('Calzone', 0.50);

INSERT INTO "cliente" (id,cognome,indirizzo) VALUES 
	('Rossi','Via Francesco Girardi 128, Padova, PD');
	('Villa','Via Sedile di Porto 23, Padova, PD');
	('Esposito','Via Giotto 64, Verona, VR');
	('Gentile','Via Santa Teresa degli Scalzi 128, Tombolo, PD');
	('Bruno','P.O. Box 610, 2457 Risus. St.');
	('Ferrante','Ap #968-7062 Velit. Ave');
	('Ferrero','7211 Phasellus Avenue');
	('Montanari','Ap #264-6008 Libero Av.');
	('Pagano','9115 Massa. Rd.');
	('Farina','3502 Fusce Road');
	('De Santis','P.O. Box 565, 4346 Integer Rd.');
	('Caruso','152 Ullamcorper, Road');
	('Napolitano','1768 Sodales Ave');
	('Caruso','Ap #405-6132 Nibh Rd.');
	('Mele','Ap #636-789 Eu St.');
	('Bernardi','431-9948 Convallis St.');
	('Santoro','Ap #176-326 Aliquam Rd.');
	('Ferrero','571-4109 Praesent Ave');
	('Lombardo','706-495 Fermentum St.');
	('Pastore','3422 Nulla Av.');
	('Moro','Ap #541-1980 Arcu. St.');
	('Ferraro','Ap #740-8475 Sit Avenue');
	('Barone','P.O. Box 698, 6698 Id, St.');
	('Perrone','Ap #402-8224 Sapien St.');
	('Farina','7169 Dui. Rd.');
	('Rizzi','4629 Libero. Ave');
	('Grasso','P.O. Box 194, 3081 Malesuada St.');
	('Valente','986-8728 Dolor Rd.');
	('Giuliani','Ap #845-3506 Malesuada Street');
	('Piras','P.O. Box 442, 7589 Mauris Street');
	('De Rosa','614 Integer St.');
	('Grasso','4387 Turpis Rd.');
	('Pinna','7879 Natoque Road');
	('Sorrentino','4637 Urna Street');
	('Rinaldi','8926 Ullamcorper, Ave');
	('Grasso','224 In Street');
	('Fumagalli','Ap #572-2377 Mi Rd.');
	('Costantini','6868 Tortor. Road');
	('Esposito','P.O. Box 605, 427 Vitae, Avenue');
	('Ferretti','P.O. Box 526, 490 Leo. Street');
	('De Santis','Ap #114-5184 Libero. St.');
	('Bruni','581-8707 Mattis. Street'):
	('Martini','2478 Ullamcorper Rd.');
	('Villa','Ap #671-4445 Magna. Road');
	('Milani','P.O. Box 501, 2657 Justo Avenue');
	('Catalano','486-9014 Nec St.');
	('Sala','Ap #501-4490 Adipiscing Street');
	('Parisi','Ap #404-4495 Egestas Avenue');
	('Riva','460-1403 In Av.');
	('Montanari','P.O. Box 731, 5194 Malesuada St.');
	('Grassi','640-8781 Pellentesque Av.');
	('Sala','205-8224 Ut Av.');
	('Ferro','2808 In St.');
	('Moro','1252 Nam Avenue');
	('Pinna','Ap #520-8337 Mauris Street');
	('Serra','641-2673 Tellus Road');
	('Albanese','428-2049 Rhoncus. Rd.');
	('Bianco','379-5746 Vulputate Rd.');
	('Greco','P.O. Box 245, 953 Risus. Rd.');
	('Messina','574-5579 Sem St.');
	('Ferro','835-9834 Tempus Avenue');
	('Grimaldi','143-3512 Nunc St.');
	('Sala','230 Quam Rd.');
	('Villa','Ap #534-9703 Orci Av.');
	('Benedetti','P.O. Box 899, 4429 Massa. St.');
	('Conte','868-5984 Nulla Road');
	('Di Stefano','Ap #459-570 Nullam Avenue');
	('Russo','690-1716 Nisi. Rd.');
	('Leone','P.O. Box 525, 5310 Lacus, St.');
	('Sanna','Ap #795-1294 Sit Av.');
	('Antonelli','Ap #717-1556 Consequat St.');
	('Vitale','Ap #408-682 Consequat Street');
	('Palumbo','Ap #544-7883 Mauris Rd.');
	('Aiello','1990 Tempus St.');
	('Sanna','7766 Sed Rd.');
	('Proietti','Ap #823-8038 Libero. Avenue');
	('Conte','P.O. Box 172, 9085 Penatibus Avenue');
	('Conte','P.O. Box 415, 9057 Libero Street');
	('Costantini','P.O. Box 837, 1436 Orci, Rd.');
	('Ferrara','P.O. Box 651, 6976 Elit Street');
	('Sorrentino','1548 In Rd.');
	('Vitali','P.O. Box 786, 9851 Taciti Av.');
	('Ruggiero','P.O. Box 649, 3983 Dolor Av.');
	('Ricciardi','P.O. Box 571, 445 Eget, St.');
	('Sanna','8894 Ac St.');
	('Ferrante','978-9300 Sed St.');
	('Zanetti','Ap #146-1491 Sit Ave');
	('Valentini','836-5738 Vitae Rd.');
	('Vitale','186-5408 Fringilla Rd.');
	('Martinelli','Ap #995-589 Neque. St.');
	('Martini','497 Lacus. Av.');
	('Costa','603-8657 Tincidunt, Avenue');
	('Ferri','P.O. Box 715, 6646 Nunc Ave');
	('Pellegrino','P.O. Box 353, 8544 Ac Av.');
	('Ferrante','9370 Aenean Street');
	('Catalano','P.O. Box 164, 4979 Et, St.');
	('Franco','Ap #985-5498 Eu, St.');
	('Brambilla','365-5427 Odio. St.');
	('Catalano','Ap #911-5365 Vestibulum, St.');
	('Ferraro','P.O. Box 292, 8152 Cras Avenue');


INSERT INTO stipendio_base (impiego, stipendio) VALUES
	('Domiciliare_Furgone', 25.0);
	('Domiciliare_Macchina', 20.0);
	('Cassiere', 30.0);
	('Pizzaiolo', 40.0);
	('Aiuto_Pizzaiolo', 35.0);




