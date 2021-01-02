--- 1) Query per l'inserimento di un ordine nel Database

CREATE OR REPLACE FUNCTION net_total_order(ord BIGINT) RETURNS table(price NUMERIC(5,2)) AS
$body$

	SELECT (SUM(prezzo) * ripetizioni) + aggiunte - rimozioni as total
	FROM composizione_ordine
	LEFT JOIN pizza
	ON pizza.nome = composizione_ordine.pizza
	LEFT JOIN formato_pizza
	ON formato_pizza.tipo = composizione_ordine.formato_pizza
	WHERE composizione_ordine.ordine = ord
	GROUP BY pizza, ripetizioni, aggiunte, rimozioni

$body$ LANGUAGE SQL;

BEGIN;
WITH 
	_id AS (
		INSERT INTO ordine (ora, dipendente, pizzeria, cliente) VALUES (NOW(), ?, ?, 1) RETURNING id
	),
	_comp AS (
		INSERT INTO composizione_ordine (ordine, pizza, formato_pizza, aggiunte, rimozioni, ripetizioni) VALUES 
		((SELECT id FROM _id), ?, ?, ?, ?, ?),
		((SELECT id FROM _id), ?, ?, ?, ?, ?)
	),
	_totale AS (
		SELECT SUM(price) AS totale
		FROM net_total_order((SELECT id FROM _id)) --- totale dell'ordine desiderato
	),
	_iva AS (
		SELECT ((totale * 10) / 110) AS iva
		FROM _totale
	)

INSERT INTO scontrino (id, data, tipo_pagamento, totale_lordo, iva) VALUES ((SELECT id FROM _id), NOW(), ?, (SELECT totale FROM _totale), (SELECT iva FROM _iva));
COMMIT;
