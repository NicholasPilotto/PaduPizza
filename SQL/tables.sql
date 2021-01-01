DROP TABLE IF EXISTS amministrazione CASCADE;
DROP TABLE IF EXISTS bolla_carico CASCADE;
DROP TABLE IF EXISTS calendario CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS composizione_ordine CASCADE;
DROP TABLE IF EXISTS dipendente CASCADE;
DROP TABLE IF EXISTS formato_pizza CASCADE;
DROP TABLE IF EXISTS fornitore CASCADE;
DROP TABLE IF EXISTS ingrediente CASCADE;
DROP TABLE IF EXISTS km_percorsi CASCADE;
DROP TABLE IF EXISTS magazzino CASCADE;
DROP TABLE IF EXISTS ordine CASCADE;
DROP TABLE IF EXISTS pizza CASCADE;
DROP TABLE IF EXISTS pizzeria CASCADE;
DROP TABLE IF EXISTS ricetta CASCADE;
DROP TABLE IF EXISTS rifornimento CASCADE;
DROP TABLE IF EXISTS scontrino CASCADE;
DROP TABLE IF EXISTS stipendio_base CASCADE;
DROP TABLE IF EXISTS stock CASCADE;
DROP TABLE IF EXISTS titolare CASCADE;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE titolare (
	cf VARCHAR(20),
	nome VARCHAR(15),
	cognome VARCHAR(15),

	PRIMARY KEY (cf)
);

CREATE TABLE calendario (
	id TEXT DEFAULT (generate_uid(5)),
	giorno_chiusura INT,
	ora_apertura TIME,
	ora_chiusura TIME,
	
	PRIMARY KEY (id)
);

CREATE TABLE amministrazione (
	id TEXT DEFAULT (generate_uid(5)),
	sito_web VARCHAR(20),
	mail VARCHAR(20),
	numero_tel VARCHAR(10),
	fax VARCHAR(10),
	indirizzo VARCHAR(20),
	citta VARCHAR(10),
	provincia VARCHAR(2),
	
	PRIMARY KEY (id)
);

CREATE TABLE pizzeria (
	id TEXT DEFAULT (generate_uid(5)),
	indirizzo VARCHAR(20),
	citta VARCHAR(20),
	provincia VARCHAR(2),
	numero_tel VARCHAR(10),

	calendario TEXT,
	titolare VARCHAR(16),
	amministrazione TEXT,

	PRIMARY KEY (id),

	CONSTRAINT fk_pizzeria
	FOREIGN KEY (calendario) REFERENCES calendario(id) ON DELETE CASCADE,
	FOREIGN KEY (titolare) REFERENCES titolare(cf) ON DELETE CASCADE,
	FOREIGN KEY (amministrazione) REFERENCES amministrazione(id) ON DELETE CASCADE
);

CREATE TABLE stipendio_base (
	impiego VARCHAR(20),
	stipendio NUMERIC(5, 2),

	PRIMARY KEY (impiego)
);

CREATE TABLE dipendente (
	cf VARCHAR(16),
	nome VARCHAR(20),
	cognome VARCHAR(20),
	data_assunzione DATE,
	impiego VARCHAR(20),

	pizzeria TEXT,

	PRIMARY KEY(cf),

	CONSTRAINT fk_dipendente
	FOREIGN KEY (pizzeria) REFERENCES pizzeria(id) ON DELETE CASCADE,
	FOREIGN KEY (impiego) REFERENCES stipendio_base(impiego) ON DELETE CASCADE
);


CREATE TABLE km_percorsi (
	data DATE,
	dipendente VARCHAR(16),
	km INT,

	PRIMARY KEY (data, dipendente),

	CONSTRAINT fk_km_percorsi
	FOREIGN KEY (dipendente) REFERENCES dipendente(cf) ON DELETE CASCADE
);

CREATE TABLE cliente (
	id TEXT DEFAULT (generate_uid(5)),
	cognome VARCHAR(15),
	indirizzo VARCHAR(20),

	PRIMARY KEY (id)
);

CREATE TABLE ingrediente (
	nome VARCHAR(25),
	conservazione VARCHAR(20),

	PRIMARY KEY (nome)
);

CREATE TABLE ordine (
	id TEXT DEFAULT (generate_uid(5)),
	ora TIME,

	dipendente VARCHAR(16),
	pizzeria TEXT,
	cliente TEXT,

	PRIMARY KEY (id),

	CONSTRAINT fk_ordine
	FOREIGN KEY (dipendente) REFERENCES dipendente(cf) ON DELETE CASCADE,
	FOREIGN KEY (pizzeria) REFERENCES pizzeria(id) ON DELETE CASCADE,
	FOREIGN KEY (cliente) REFERENCES cliente(id) ON DELETE CASCADE
);

CREATE TABLE scontrino (
	id TEXT DEFAULT (generate_uid(5)),
	data TIMESTAMP,
	tipo_pagamento VARCHAR(20),
	totale_lordo NUMERIC(5, 2),
	iva DECIMAL(5, 2),

	PRIMARY KEY (id)
);

CREATE TABLE formato_pizza (
	tipo VARCHAR(15),
	differenza_prezzo NUMERIC(4, 2),

	PRIMARY KEY (tipo)
);

CREATE TABLE pizza (
	nome VARCHAR(15),
	prezzo NUMERIC(4, 2),

	PRIMARY KEY (nome)
);

CREATE TABLE composizione_ordine (
	ordine TEXT,
	pizza VARCHAR(15),
	formato_pizza VARCHAR(15),

	aggiunte INT,
	rimozioni INT,
	ripetizioni INT,

	PRIMARY KEY (ordine, pizza, formato_pizza),

	CONSTRAINT fk_composizione_ordine
	FOREIGN KEY (ordine) REFERENCES ordine(id) ON DELETE CASCADE,
	FOREIGN KEY (pizza) REFERENCES pizza(nome) ON DELETE CASCADE,
	FOREIGN KEY (formato_pizza) REFERENCES formato_pizza(tipo) ON DELETE CASCADE
);


CREATE TABLE ricetta (
	pizza VARCHAR(15),
	ingrediente VARCHAR(15),

	PRIMARY KEY (pizza, ingrediente),

	CONSTRAINT fk_ricetta
	FOREIGN KEY (pizza) REFERENCES pizza(nome) ON DELETE CASCADE,
	FOREIGN KEY (ingrediente) REFERENCES ingrediente(nome) ON DELETE CASCADE
);

CREATE TABLE fornitore (
	id TEXT DEFAULT (generate_uid(5)),
	p_iva VARCHAR(20),
	azienda VARCHAR(20),
	numero_tel VARCHAR(10),
	indirizzo VARCHAR(20),
	citta VARCHAR(20),
	provincia VARCHAR(2),

	PRIMARY KEY (id)
);

CREATE TABLE magazzino (
	id TEXT DEFAULT (generate_uid(5)),

	gestore TEXT,

	PRIMARY KEY (id),

	CONSTRAINT fk_magazzino
	FOREIGN KEY (gestore) REFERENCES fornitore(id) ON DELETE CASCADE
);

CREATE TABLE stock (
	magazzino TEXT DEFAULT (generate_uid(5)),
	ingrediente VARCHAR(20),

	quantita INT,

	PRIMARY KEY (magazzino, ingrediente),

	CONSTRAINT fk_stock
	FOREIGN KEY (magazzino) REFERENCES magazzino(id) ON DELETE CASCADE,
	FOREIGN KEY (ingrediente) REFERENCES ingrediente(nome) ON DELETE CASCADE
);

CREATE TABLE rifornimento (
	id TEXT DEFAULT (generate_uid(5)),

	mittente TEXT,
	magazzino TEXT,

	PRIMARY KEY (id),

	CONSTRAINT fk_rifornimento
	-- FOREIGN KEY (mittente) REFERENCES fornitore(id) ON DELETE CASCADE, ?
	-- FOREIGN KEY (mittente) REFERENCES fornitore(id) ON DELETE CASCADE, ?
	FOREIGN KEY (magazzino) REFERENCES magazzino(id) ON DELETE CASCADE
);

CREATE TABLE bolla_carico (
	rifornimento TEXT DEFAULT (generate_uid(5)),
	ingrediente VARCHAR(20),
	quantita INT,

	PRIMARY KEY (rifornimento, ingrediente),
	
	CONSTRAINT fk_bolla_carico
	FOREIGN KEY (rifornimento) REFERENCES rifornimento(id) ON DELETE CASCADE,
	FOREIGN KEY (ingrediente) REFERENCES ingrediente(nome) ON DELETE CASCADE
);

