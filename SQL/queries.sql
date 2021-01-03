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

INSERT INTO scontrino (id, data, tipo_pagamento, totale_lordo, iva) VALUES ((SELECT id FROM _id), NOW(), ?, 0,0);

UPDATE scontrino SET totale_lordo = (SELECT * FROM total_price((SELECT MAX(id) FROM scontrino))) WHERE id = (SELECT MAX(id) FROM scontrino);
UPDATE scontrino SET iva = (SELECT * FROM total_vat((SELECT MAX(id) FROM scontrino))) WHERE id = (SELECT MAX(id) FROM scontrino);

COMMIT;

--- 2) Query per il calcolo dello stipendio mensile di un titolare di N pizzerie. Esso varia in base al fatturato totale
---	   delle pezzerie da esso gestite
SELECT
	CASE WHEN fatturato < 1000 THEN 1000
		  WHEN fatturato > 1000 THEN 1000 + fatturato + (fatturato * 0.1)
		  WHEN fatturato > 2000 THEN 1000 + fatturato + (fatturato * 0.15) 
		  WHEN fatturato > 3000 THEN 1000 + fatturato + (fatturato * 0.17) 
		  WHEN fatturato > 4000 THEN 1000 + fatturato + (fatturato * 0.2)
	END
FROM month_earning(?, ?)

--- 3) Query per il calcolo dello stipendio mensile di un dipendente
SELECT 
	IF impiego = 'Domiciliare_Macchina' THEN 
		(stipendio * night_at_work(dipendente.cf, 1) + km(dipendente.cf, 1) * 0.3
	ELSE (stipendio * night_at_work(dipendente.cf))
FROM dipendente
LEFT JOIN pizzeria
ON pizzeria.id = dipendente.pizzeria
LEFT JOIN km_percorsi
ON km_percorsi.dipendente = dipendente.cf
LEFT JOIN stipendio_base
ON stipendio_base.impiego = dipendente.impiego
WHERE pizzeria.id = ''
