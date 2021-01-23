--- 1) Query per l'inserimento di un ordine nel Database
BEGIN;
DO $$
DECLARE
	_id BIGINT;
	_now TIMESTAMP;
BEGIN 
	_now := NOW();
	INSERT INTO ordine (ora, dipendente, pizzeria, cliente) VALUES 
				(_now, 'CRLVNI04E21D612L', 'q2Gw1', 3) RETURNING id INTO _id;
	INSERT INTO composizione_ordine (ordine, pizza, formato_pizza, aggiunte, rimozioni, ripetizioni) VALUES 
		(_id, 'Diavola', 'Normale', 1, 0, 2);

	INSERT INTO scontrino (id, data, tipo_pagamento, totale_lordo, iva) VALUES 
		(_id, _now, 'Contanti', (SELECT * FROM total_price(_id)), (SELECT * FROM total_vat(_id)));
END;
$$ LANGUAGE 'plpgsql';
COMMIT;

-- Dipendente CRLVNI04E21D612L(Ivano Carlini), Pizzeria q2Gw1 (Via Mira, 32, Giaron, VR), Cliente 3 (Esposito, Via Giotto 64, Verona)
-- Pizza Diavola, Formato Normale, Aggiunte 1, Rimozioni 0, Ripetizioni 2
-- TipoPagamento Contanti


--- 2) Query per il calcolo dello stipendio mensile di un titolare di N pizzerie. Esso varia in base al fatturato totale
---	   delle pezzerie da esso gestite
SELECT
	CASE WHEN fatturato = 0 THEN 0
			 WHEN fatturato > 0 AND fatturato < 1000 THEN 1000
		   WHEN fatturato > 1000 AND fatturato < 2000 THEN 1000 + fatturato + (fatturato * 0.1)
		   WHEN fatturato > 2000 AND fatturato < 3000 THEN 1000 + fatturato + (fatturato * 0.15)
		   WHEN fatturato > 3000 AND fatturato < 4000 THEN 1000 + fatturato + (fatturato * 0.17)
		   WHEN fatturato > 4000 THEN 1000 + fatturato + (fatturato * 0.2)
	END AS stipendio
FROM month_earning('LCNCTN10L25F205T', 1, 2020);

SELECT nome, cognome, 
	CASE WHEN fatturato = 0 THEN 0
			 WHEN fatturato > 0 AND fatturato < 1000 THEN 1000
		   WHEN fatturato > 1000 AND fatturato < 2000 THEN 1000 + fatturato + (fatturato * 0.1)
		   WHEN fatturato > 2000 AND fatturato < 3000 THEN 1000 + fatturato + (fatturato * 0.15)
		   WHEN fatturato > 3000 AND fatturato < 4000 THEN 1000 + fatturato + (fatturato * 0.17)
		   WHEN fatturato > 4000 THEN 1000 + fatturato + (fatturato * 0.2)
	END AS stipendio
FROM titolare, month_earning('LCNCTN10L25F205T', 1, 2020)
WHERE cf= 'LCNCTN10L25F205T';
-- Titolare LCNCTN10L25F205T(Costantino Luciani), 1(Gennaio), 2020

--- 3) Query per il calcolo dello stipendio mensile di un dipendente
SELECT DISTINCT nome, cognome,
	CASE WHEN night_at_work.nights = 0 THEN 0
		   WHEN dipendente.impiego = 'Domiciliare_Macchina' THEN  (stipendio * night_at_work.nights + km.km * 0.3)
		   WHEN dipendente.impiego <> 'Domiciliare_Macchina' THEN stipendio * night_at_work.nights
	END as Stipendio
FROM dipendente
LEFT JOIN pizzeria
ON pizzeria.id = dipendente.pizzeria
LEFT JOIN turno
ON turno.dipendente = dipendente.cf
LEFT JOIN lavoro
ON lavoro.impiego = dipendente.impiego
LEFT JOIN night_at_work(dipendente.cf, 1, 2020)
ON dipendente.cf = night_at_work.dipendente
LEFT JOIN km(dipendente.cf, 1, 2020)
ON dipendente.cf = km.dip
WHERE dipendente.cf = 'DNADMN05R09L219Y';
-- Dipendente DNADMN05R09L219Y(Damiano Dani)

--- 4) Query che seleziona tutte le pizzerie i quali magazzini contengono una quantità di ingrediente inferiore a 20
SELECT pizzeria.id, ingrediente.nome, stock.quantita
FROM amministrazione
INNER JOIN pizzeria
ON pizzeria.amministrazione = amministrazione.id
INNER JOIN magazzino
ON magazzino.gestore = pizzeria.id
INNER JOIN stock
ON stock.magazzino = magazzino.id
INNER JOIN ingrediente
ON ingrediente.nome = stock.ingrediente
WHERE stock.quantita < 20

--- 5) Query per il refill di un magazzino di una pizzeria proveniente dalla sua amministrazione
BEGIN;
DO $$
DECLARE
	_pizzeria TEXT;
	_amministrazione TEXT;
	_ingrediente VARCHAR;
	_magazzino BIGINT;
	_quantita INTEGER;
	_rifornimento BIGINT;
	_bolla BIGINT;
BEGIN 
	_pizzeria := 'RfaXX';
	_ingrediente := 'Peperoni';
	_quantita := 12;
	_magazzino := (SELECT id FROM magazzino WHERE magazzino.gestore = _pizzeria);
	_amministrazione := (SELECT amministrazione.id
						 					 FROM pizzeria
						 					 LEFT JOIN amministrazione
						 					 ON amministrazione.id = pizzeria.amministrazione
						 					 WHERE pizzeria.id = _pizzeria);
	INSERT INTO rifornimento (mittente, magazzino, data) VALUES (_amministrazione, _magazzino, NOW()) RETURNING id INTO _rifornimento;
	INSERT INTO bolla_carico (rifornimento, ingrediente, quantita) VALUES (_rifornimento, _ingrediente, _quantita);
	INSERT INTO stock (magazzino, ingrediente, quantita) VALUES (_magazzino, _ingrediente, _quantita) ON CONFLICT (magazzino, ingrediente) DO
		UPDATE SET quantita = stock.quantita + _quantita;
END;
$$ LANGUAGE 'plpgsql';
COMMIT;

--- 6) Query che seleziona quali pizzerie fatturano più della media
SELECT pizzeria.indirizzo, SUM(scontrino.totale_lordo)
FROM scontrino
LEFT JOIN ordine
ON ordine.id = scontrino.id
LEFT JOIN pizzeria
ON pizzeria.id = ordine.pizzeria
LEFT JOIN amministrazione
ON amministrazione.id = pizzeria.id
WHERE date_part('month', scontrino.data) = 1
GROUP BY pizzeria.id;

-- 1(Gennaio)