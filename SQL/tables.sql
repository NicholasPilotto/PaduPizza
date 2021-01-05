DROP TABLE IF EXISTS amministrazione CASCADE;
DROP TABLE IF EXISTS bolla_carico CASCADE;
DROP TABLE IF EXISTS calendario CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS composizione_ordine CASCADE;
DROP TABLE IF EXISTS dipendente CASCADE;
DROP TABLE IF EXISTS formato_pizza CASCADE;
DROP TABLE IF EXISTS ingrediente CASCADE;
DROP TABLE IF EXISTS turno CASCADE;
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
DROP TABLE IF EXISTS tipo_pagamento CASCADE;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE titolare (
	cf VARCHAR(20),
	nome VARCHAR(15),
	cognome VARCHAR(15),

	PRIMARY KEY (cf)
);

CREATE TABLE calendario (
	id SERIAL,
	giorno_chiusura INT,
	ora_apertura TIME,
	ora_chiusura TIME,
	
	PRIMARY KEY (id)
);

CREATE TABLE amministrazione (
	id TEXT DEFAULT (generate_uid(5)),
	sito_web VARCHAR(20) DEFAULT 'www.padupizza.it/',
	mail VARCHAR(35),
	numero_tel VARCHAR(25),
	fax VARCHAR(15),
	indirizzo VARCHAR(50),
	citta VARCHAR(20),
	provincia VARCHAR(2),
	
	PRIMARY KEY (id)
);

CREATE TABLE pizzeria (
	id TEXT DEFAULT (generate_uid(5)),
	indirizzo VARCHAR(40),
	citta VARCHAR(20),
	provincia VARCHAR(2),
	numero_tel VARCHAR(10),

	calendario BIGINT,
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
	nome VARCHAR(25),
	cognome VARCHAR(25),
	data_assunzione DATE,
	impiego VARCHAR(25),

	pizzeria TEXT,

	PRIMARY KEY(cf),

	CONSTRAINT fk_dipendente
	FOREIGN KEY (pizzeria) REFERENCES pizzeria(id) ON DELETE CASCADE,
	FOREIGN KEY (impiego) REFERENCES stipendio_base(impiego) ON DELETE CASCADE
);


CREATE TABLE turno (
	data DATE,
	dipendente VARCHAR(16),
	km INT DEFAULT 0,

	PRIMARY KEY (data, dipendente),

	CONSTRAINT fk_km_percorsi
	FOREIGN KEY (dipendente) REFERENCES dipendente(cf) ON DELETE CASCADE
);

CREATE TABLE cliente (
	id SERIAL,
	cognome VARCHAR(15),
	indirizzo VARCHAR(50),

	PRIMARY KEY (id)
);

CREATE TABLE ingrediente (
	nome VARCHAR(40),
	conservazione VARCHAR(20),

	PRIMARY KEY (nome)
);

CREATE TABLE ordine (
	id SERIAL,
	ora TIME,

	dipendente VARCHAR(16),
	pizzeria TEXT,
	cliente BIGINT,

	PRIMARY KEY (id),

	CONSTRAINT fk_ordine
	FOREIGN KEY (dipendente) REFERENCES dipendente(cf) ON DELETE CASCADE,
	FOREIGN KEY (pizzeria) REFERENCES pizzeria(id) ON DELETE CASCADE,
	FOREIGN KEY (cliente) REFERENCES cliente(id) ON DELETE CASCADE
);

CREATE TABLE tipo_pagamento (
	pagamento VARCHAR(25),
	PRIMARY KEY (pagamento)
);

CREATE TABLE scontrino (
	id BIGINT,
	data TIMESTAMP,
	tipo_pagamento VARCHAR(20),
	totale_lordo NUMERIC(5, 2),
	iva DECIMAL(5, 2),

	PRIMARY KEY (id),
	
	CONSTRAINT fk_scontrino
	FOREIGN KEY (tipo_pagamento) REFERENCES tipo_pagamento(pagamento)
);

CREATE TABLE formato_pizza (
	tipo VARCHAR(15),
	differenza_prezzo NUMERIC(4, 2),

	PRIMARY KEY (tipo)
);

CREATE TABLE pizza (
	nome VARCHAR(35),
	prezzo NUMERIC(4, 2),

	PRIMARY KEY (nome)
);

CREATE TABLE composizione_ordine (
	ordine SERIAL,
	pizza VARCHAR(35),
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
	pizza VARCHAR(35),
	ingrediente VARCHAR(40),

	PRIMARY KEY (pizza, ingrediente),

	CONSTRAINT fk_ricetta
	FOREIGN KEY (pizza) REFERENCES pizza(nome) ON DELETE CASCADE,
	FOREIGN KEY (ingrediente) REFERENCES ingrediente(nome) ON DELETE CASCADE
);

CREATE TABLE magazzino (
	id SERIAL,

	gestore TEXT,

	PRIMARY KEY (id),

	CONSTRAINT fk_magazzino
	FOREIGN KEY (gestore) REFERENCES pizzeria(id) ON DELETE CASCADE
);

CREATE TABLE stock (
	magazzino SERIAL,
	ingrediente VARCHAR(40),

	quantita INT,

	PRIMARY KEY (magazzino, ingrediente),

	CONSTRAINT fk_stock
	FOREIGN KEY (magazzino) REFERENCES magazzino(id) ON DELETE CASCADE,
	FOREIGN KEY (ingrediente) REFERENCES ingrediente(nome) ON DELETE CASCADE
);

CREATE TABLE rifornimento (
	id SERIAL,

	mittente TEXT,
	magazzino BIGINT,

	PRIMARY KEY (id),

	CONSTRAINT fk_rifornimento
	FOREIGN KEY (mittente) REFERENCES amministrazione(id) ON DELETE CASCADE,
	FOREIGN KEY (magazzino) REFERENCES magazzino(id) ON DELETE CASCADE
);

CREATE TABLE bolla_carico (
	rifornimento SERIAL,
	ingrediente VARCHAR(40),
	quantita INT,

	PRIMARY KEY (rifornimento, ingrediente),
	
	CONSTRAINT fk_bolla_carico
	FOREIGN KEY (rifornimento) REFERENCES rifornimento(id) ON DELETE CASCADE,
	FOREIGN KEY (ingrediente) REFERENCES ingrediente(nome) ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION net_total_order(ord BIGINT) RETURNS table(price NUMERIC(5,2)) AS
$body$

	SELECT (SUM(prezzo + formato_pizza.differenza_prezzo) * ripetizioni) + aggiunte - rimozioni as total
	FROM composizione_ordine
	LEFT JOIN pizza
	ON pizza.nome = composizione_ordine.pizza
	LEFT JOIN formato_pizza
	ON formato_pizza.tipo = composizione_ordine.formato_pizza
	WHERE composizione_ordine.ordine = ord
	GROUP BY pizza, ripetizioni, aggiunte, rimozioni

$body$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION total_price(ord BIGINT) RETURNS table(price NUMERIC(5,2)) AS
$body$
	SELECT SUM(price) AS total
	FROM net_total_order(ord);
$body$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION total_vat(ord BIGINT) RETURNS table(price NUMERIC(5,2)) AS
$body$
	SELECT (price * 10) / 110 as total
	FROM total_price(ord);
$body$ LANGUAGE SQL;


CREATE OR REPLACE FUNCTION month_earning(tit TEXT, mon INT) RETURNS table(fatturato NUMERIC(5,2)) AS
$body$
	SELECT SUM(scontrino.totale_lordo) AS fatturato_mese
	FROM ordine
	LEFT JOIN scontrino
	ON scontrino.id = ordine.id
	LEFT JOIN pizzeria
	ON pizzeria.id = ordine.pizzeria
	GROUP BY pizzeria.titolare, date_part('month', scontrino.data)
	HAVING pizzeria.titolare = tit AND date_part('month', scontrino.data) = mon
$body$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION km(dip TEXT, mm INT, yy INT) RETURNS table(dip TEXT, km INT) AS
$body$
	SELECT dip, SUM(km)
	FROM turno
	WHERE date_part('month', turno.data) = mm AND date_part('year', turno.data) = yy AND turno.dipendente = dip
	GROUP BY turno.dipendente
$body$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION night_at_work(dip TEXT, mm INT, yy INT) RETURNS table(dip TEXt, nights INT) AS
$body$
	SELECT dip, COUNT(*)
	FROM turno
	WHERE dipendente = dip AND date_part('month', turno.data) = mm AND date_part('year', turno.data) = yy
	GROUP BY dipendente
$body$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION create_magazzino() RETURNS trigger AS $trig$
    BEGIN
        INSERT INTO magazzino (gestore) VALUES (NEW.id);
				RETURN NULL;
    END;
$trig$ LANGUAGE plpgsql;

CREATE TRIGGER create_new_magazzino AFTER INSERT ON pizzeria
	FOR EACH ROW EXECUTE PROCEDURE create_magazzino();

CREATE OR REPLACE FUNCTION fat_per_month(mm INT) RETURNS table(piz TEXT, fat NUMERIC, prov TEXT) AS
$body$
	SELECT pizzeria.id AS pizzeria, SUM(scontrino.totale_lordo) AS fatturato, amministrazione.provincia
	FROM scontrino
	LEFT JOIN ordine
	ON ordine.id = scontrino.id
	LEFT JOIN pizzeria
	ON pizzeria.id = ordine.pizzeria
	LEFT JOIN amministrazione
	ON amministrazione.id = pizzeria.amministrazione
	WHERE date_part('month', scontrino.data) = mm
	GROUP BY pizzeria.id, amministrazione.provincia
$body$ LANGUAGE SQL;