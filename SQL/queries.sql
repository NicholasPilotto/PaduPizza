--- 1) Query per l'inserimento di un ordine nel Database

/*
INSERT INTO formato_pizza (tipo, differenza_prezzo) VALUES ('Mignon', 1.50);
INSERT INTO dipendente (cf, nome, cognome, data_assunzione, impiego, pizzeria) VALUES ('RSSMRA80A01G224W', 'Mario', 'Rossi', '2020-01-01', 'domiciliare', 1);
INSERT INTO scontrino (id, data, tipo_pagamento, totale_lordo, iva) VALUES (1, '2020-06-10', 'Contanti', 17.50, 2.50);
INSERT INTO cliente (id, cognome, indirizzo) VALUES (1, 'Franchetto', 'Via Verde, 10');
INSERT INTO ordine (id, ora, dipendente, pizzeria, cliente) VALUES (1, '19:15', 'RSSMRA80A01G224W', 1, 1);
INSERT INTO pizza (nome, prezzo) VALUES ('Margherita', 5.00);
INSERT INTO composizione_ordine (ordine, pizza, formato_pizza, aggiunte, rimozioni, ripetizioni) VALUES (1, 'Margherita', 'Mignon', 0, 0, 1);
*/

BEGIN;
uid TEXT := generate_uid(5);
INSERT INTO ordine (id, ora, dipendente, pizzeria, cliente) VALUES (uid, NOW(),1,1,1);
INSERT INTO scontrino (id, data, tipo_pagamento, totale_lordo, iva) VALUES (uid,NOW(),1,1,1);
COMMIT;


