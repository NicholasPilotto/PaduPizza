CREATE TABLE titolare (
	cf VARCHAR(20),
	nome VARCHAR(15),
	cognome VARHCAR(15),

	PRIMARY KEY (cf),
);

CREATE TABLE calendario (
	id BIGINT,
	giorno_chiusura INT,
	ora_apertura TIMESTAMP,
	ora_chiusura TIMESTAMP,
);

CREATE TABLE amministrazione (
	id BIGINT,
	sito_web VARCHAR(15),
	mail VARCHAR(15),
	numero_tel VARCHAR(10),
	fax VARCHAR(10),
	indirizzo VARCHAR(20),
	citta VARCHAR(10),
	provincia VARCHAR(2),
);

CREATE TABLE pizzeria (
	id BIGINT,
	indirizzo VARCHAR(20),
	citta VARCHAR(10),
	provincia VARCHAR(2),
	numero_tel VARCHAR(10),

	calendario BIGINT,
	titolare VARCHAR(16),
	amministrazione BIGINT,

	PRIMARY KEY (id),

	FOREIGN KEY (caledario) REFERENCES calendario(id),
	FOREIGN KEY (titolare) REFERENCES titolare(cf),
	FOREIGN KEY (amministrazione) REFERENCES amministrazione(id),
);

CREATE TABLE dipendente (
	cf VARCHAR(16),
	nome VARCHAR(15),
	cognome VARCHAR(15),
	data_assunzione DATETIME,
	impiego VARCHAR(10),

	pizzeria BIGINT,

	PRIMARY KEY(cf),

	FOREIGN KEY (pizzeria) REFERENCES pizzeria(id),
);


CREATE TABLE km_percorsi (
	data DATETIME,
	dipendente VARCHAR(16),
	km INT

	PRIMARY KEY (data, dipendente),

	FOREIGN KEY (dipendente) REFERENCES dipendente(cf),
);

CREATE TABLE stipendio_base (
	impiego VARCHAR(10),
	stipendio DECIMAL(3,2),

	PRIMARY KEY (impiego),

	FOREIGN KEY (impiego) REFERENCES dipendente(impiego),
);

CREATE TABLE cliente (
	id BIGINT,
	cognome VARCHAR(15),
	indirizzo VARCHAR(20),

	PRIMARY KEY (id),
);

CREATE TABLE ordine (
	id BIGINT,
	ora TIMESTAMP,

	dipendente BIGINT,
	pizzeria BIGINT,
	cliente BIGINT,

	PRIMARY KEY (id),

	FOREIGN KEY (dipendente) REFERENCES dipendente(id),
	FOREIGN KEY (pizzeria) REFERENCES pizzeria(id),
	FOREIGN KEY cliente REFERENCES cliente(id),
);

CREATE TABLE scontrino (
	id BIGINT,
	data TIMESTAMP,
	tipo_pagamento VARCHAR(10),
	totale_lordo DECIMAL(3, 2),
	iva DECIMAL(3, 2),

	PRIMARY KEY (id),
);

CREATE TABLE formato_pizza (
	tipo VARCHAR(10),
	differenza_prezzo DECIMAL(1, 2),

	PRIMARY KEY (tipo)
);

CREATE TABLE pizza (
	nome VARCHAR(10),
	prezzo DECIMAL(2, 2),

	PRIMARY KEY (nome)
);

CREATE TABLE composizione_ordine(
	ordine BIGINT,
	pizza BIGINT,
	formato_pizza VARCHAR(10),

	aggiunte INT,
	rimozioni INT,
	ripetizioni INT,

	PRIMARY KEY (ordine, pizza, formato_pizza),

	FOREIGN KEY (ordine) REFERENCES ordine(id),
	FOREIGN KEY (pizza) REFERENCES pizza(id),
	FOREIGN KEY (formato_pizza) REFERENCES formato_pizza(nome),
);

CREATE TABLE ricetta (
	pizza VARCHAR(10),
	ingrediente VARCHAR(10),

	PRIMARY KEY (pizza, ingrediente),

	FOREIGN KEY (pizza) REFERENCES pizza(nome),
	FOREIGN KEY (ingrediente) REFERENCES ingrediente(nome)
);

CREATE TABLE ingrediente (
	nome VARCHAR(10),
	conservazione VARCHAR(20),
	data_scadente TIMESTAMP,

	PRIMARY KEY (nome)
);

CREATE TABLE fornitore (
	id BIGINT,
	p_iva VARCHAR(20),
	azienda VARCHAR(20),
	numero_tel VARCHAR(10),
	indirizzo VARCHAR(20),
	citta VARCHAR(15),
	provincia VARCHAR(2),

	PRIMARY KEY (id)
);

CREATE TABLE magazzino (
	id BIGINT,

	gestore BIGINT,

	PRIMARY KEY (id),

	FOREIGN KEY (gestore) REFERENCES fornitore(id)
);

CREATE TABLE stock (
	magazzino BIGINT,
	ingrediente VARCHAR(10),

	quantita INT,

	PRIMARY KEY (magazzino, ingrediente),

	FOREIGN KEY (magazzino) REFERENCES magazzino(id),
	FOREIGN KEY (ingrediente) REFERENCES ingrediente(nome)
);

CREATE TABLE rifornimento (
	id BIGINT,

	mittente BIGINT,
	magazzino BIGINT,

	PRIMARY KEY (id),

	FOREIGN KEY (mittente) REFERENCES fornitore(id), /*?*/
	FOREIGN KEY (mittente) REFERENCES fornitore(id), /*?*/
	FOREIGN KEY (magazzino) REFERENCES magazzino(id)
);

CREATE TABLE bolla_carico (
	rifornimento BIGINT,
	ingrediente VARCHAR(10),
	quantita INT,

	PRIMARY KEY (rifornimento, ingrediente),

	FOREIGN KEY (rifornimento) REFERENCES rifornimento(id),
	FOREIGN KEY (ingrediente) REFERENCES ingrediente(nome)
);
