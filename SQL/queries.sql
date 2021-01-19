--- 1) Query per l'inserimento di un ordine nel Database
BEGIN;
	WITH
		_id AS (
			INSERT INTO ordine (ora, dipendente, pizzeria, cliente) VALUES (NOW(), ?, ?, ?) RETURNING id
		),
		_comp AS (
			INSERT INTO composizione_ordine (ordine, pizza, formato_pizza, aggiunte, rimozioni, ripetizioni) VALUES 
			((SELECT id FROM _id), ?, ?, ?, ?, ?),
			((SELECT id FROM _id), ?, ?, ?, ?, ?)
		)

	INSERT INTO scontrino (id, data, tipo_pagamento, totale_lordo, iva) VALUES ((SELECT id FROM _id), NOW(), ?, 0, 0);

	UPDATE scontrino SET totale_lordo = (SELECT * FROM total_price((SELECT MAX(id) FROM scontrino))) WHERE id = (SELECT MAX(id) FROM scontrino);
	UPDATE scontrino SET iva = (SELECT * FROM total_vat((SELECT MAX(id) FROM scontrino))) WHERE id = (SELECT MAX(id) FROM scontrino);
COMMIT;

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
FROM month_earning(?, ?)

--- 3) Query per il calcolo dello stipendio mensile di un dipendente
SELECT DISTINCT 
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
WHERE dipendente.cf = ?

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
	WITH 
		_piz AS (
			SELECT pizzeria.id AS p, amministrazione.id AS a
			FROM pizzeria
			LEFT JOIN amministrazione
			ON amministrazione.id = pizzeria.amministrazione
			WHERE pizzeria.id = ?AND amministrazione.id = ?
		),
		_rif AS (
			INSERT INTO rifornimento (mittente, magazzino, data) VALUES ((SELECT a FROM _piz), (SELECT id FROM magazzino WHERE gestore = (SELECT p FROM _piz)), NOW()) RETURNING id
		),
		_bol AS (
			INSERT INTO bolla_carico (rifornimento, ingrediente, quantita) VALUES ((SELECT MAX(id) FROM rifornimento), ?, ?) RETURNING ingrediente, rifornimento, quantita
		),
		_up AS (
			INSERT INTO stock (magazzino, ingrediente, quantita) VALUES ((SELECT id FROM magazzino WHERE magazzino.gestore = (SELECT p FROM _piz)), (SELECT ingrediente FROM _bol), (SELECT quantita FROM _bol)) ON CONFLICT DO NOTHING
		)

	UPDATE stock SET quantita = stock.quantita + up.quantita
	FROM (SELECT quantita FROM _bol) AS up
	WHERE stock.magazzino = (SELECT id FROM magazzino WHERE magazzino.gestore = (SELECT p FROM _piz)) AND stock.ingrediente = (SELECT ingrediente FROM _bol);
COMMIT WORK;

--- 6) Query che seleziona quali provincie fatturano più della media
SELECT SUM(scontrino.totale_lordo)
FROM scontrino
LEFT JOIN ordine
ON ordine.id = scontrino.id
LEFT JOIN pizzeria
ON pizzeria.id = ordine.pizzeria
LEFT JOIN amministrazione
ON amministrazione.id = pizzeria.id
WHERE date_part('month', scontrino.data) = ?
GROUP BY pizzeria.id