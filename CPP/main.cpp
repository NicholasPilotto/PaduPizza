#include <cstdio>
#include <iomanip>
#include <iostream>

#include "./dependencies/include/libpq-fe.h"

using std::cin;
using std::cout;
using std::endl;
using std::setw;

using std::string;

#define PG_HOST "xxx.xxx.xxx.xxx"
#define PG_USER "xxxxxxxxxxxxx"  //il vostro nome utente
#define PG_DB "padupizza"        //il nome del database
#define PG_PASS "***********"    //la vostra password
#define PG_PORT 5432

void checkResults(PGresult*, const PGconn*);

void stip_tit(PGconn*);
void stip_dip(PGconn*);
void piz_rif(PGconn*);
void insert_order(PGconn*);
void refill(PGconn*);
void fatt_prov(PGconn*);

void print_titolari(PGconn*);
void print_dipendenti(PGconn*);
void print_pizze(PGconn*);
void print_ingredienti(PGconn*);
void print_clienti(PGconn*);
void print_tipo_pagamento(PGconn*);
void print_formato_pizza(PGconn*);
void print_pizzeria(PGconn*);

int main(int argc, char const* argv[]) {
  PGconn* conn;
  char conn_info[250];
  sprintf(conn_info, "user=%s password=%s dbname=%s hostaddr=%s port=%d", PG_USER, PG_PASS, PG_DB, PG_HOST, PG_PORT);
  conn = PQconnectdb(conn_info);

  if (PQstatus(conn) != CONNECTION_OK) {
    cout << "Errore di connessione " << PQerrorMessage(conn);
    PQfinish(conn);
    exit(1);
  } else {
    int op;
    cout << "1) Inserimento di un ordine;" << endl;
    cout << "2) Calcolare lo stipendio di un titolare;" << endl;
    cout << "3) Calcolare lo stipendio di un dipendente;" << endl;
    cout << "4) Elencare tutte le pizzeria che hanno in magazzino un alimento di quantita' < 20;" << endl;
    cout << "5) Rifornire una pizzeria;" << endl;
    cout << "6) Elencare tutte le pizzerie che hanno fatturato sopra la media in un dato mese;" << endl;
    cout << "Inserire l'operazione da eseguire (1-6): ";
    cin >> op;

    switch (op) {
      case 1:
        insert_order(conn);
        break;
      case 2:
        stip_tit(conn);
        break;
      case 3:
        stip_dip(conn);
        break;
      case 4:
        piz_rif(conn);
        break;
      case 5:
        refill(conn);
        break;
      case 6:
        fatt_prov(conn);
      default:
        break;
    }
    insert_order(conn);
  }
  PQfinish(conn);
  return 0;
}

void print_titolari(PGconn* conn) {
  PGresult* res;

  cout << "\n---------------------------------------------------------- TITOLARI ----------------------------------------------------------" << endl;
  string query = "SELECT DISTINCT titolare.cf, titolare.nome, titolare.cognome FROM titolare JOIN pizzeria ON pizzeria.titolare = titolare.cf";

  res = PQexec(conn, query.c_str());

  checkResults(res, conn);
  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j));
    }
    printf("\n");
  }
}

void print_dipendenti(PGconn* conn) {
  PGresult* res;

  cout << "\n---------------------------------------------------------- DIPENDENTI ----------------------------------------------------------" << endl;
  string query = "SELECT  * FROM dipendente JOIN pizzeria ON pizzeria.id = dipendente.cf";

  res = PQexec(conn, query.c_str());

  checkResults(res, conn);
  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j));
    }
    printf("\n");
  }
}
void print_pizze(PGconn* conn) {
  PGresult* res;

  cout << "\n---------------------------------------------------------- PIZZE ----------------------------------------------------------" << endl;
  string query = "SELECT * FROM pizza";

  res = PQexec(conn, query.c_str());

  checkResults(res, conn);
  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j));
    }
    printf("\n");
  }
}

void print_ingredienti(PGconn* conn) {
  PGresult* res;

  cout << "\n---------------------------------------------------------- INGREDIENTI ----------------------------------------------------------" << endl;
  string query = "SELECT * FROM ingrediente";

  res = PQexec(conn, query.c_str());

  checkResults(res, conn);
  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j));
    }
    printf("\n");
  }
}

void print_clienti(PGconn* conn) {
  PGresult* res;

  cout << "\n---------------------------------------------------------- CLIENTI ----------------------------------------------------------" << endl;
  string query = "SELECT * FROM cliente";

  res = PQexec(conn, query.c_str());

  checkResults(res, conn);
  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j));
    }
    printf("\n");
  }
}

void print_tipo_pagamento(PGconn* conn) {
  PGresult* res;

  cout << "\n---------------------------------------------------------- TIPO-PAGAMENTO ----------------------------------------------------------" << endl;
  string query = "SELECT * FROM tipo_pagamento";

  res = PQexec(conn, query.c_str());

  checkResults(res, conn);
  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j));
    }
    printf("\n");
  }
}
void print_formato_pizza(PGconn* conn) {
  PGresult* res;

  cout << "\n---------------------------------------------------------- FORMATO-PIZZA ----------------------------------------------------------" << endl;
  string query = "SELECT * FROM formato_pizza";

  res = PQexec(conn, query.c_str());

  checkResults(res, conn);
  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j));
    }
    printf("\n");
  }
}

void print_pizzeria(PGconn* conn) {
  PGresult* res;

  cout << "\n---------------------------------------------------------- PIZZERIA ----------------------------------------------------------" << endl;
  string query = "SELECT * FROM pizzeria";

  res = PQexec(conn, query.c_str());

  checkResults(res, conn);
  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j));
    }
    printf("\n");
  }
}

void stip_tit(PGconn* conn) {
  PGresult* res;

  int month;
  string tit;

  print_titolari(conn);
  cout << endl;

  cout << "Inserisci il codice fiscale del titolare per la quale effettuare il calcolo dello stipendio: ";
  cin >> tit;
  cout << "Inserisci il mese per il calcolo dello stipendio (numero 1-12): ";
  cin >> month;

  string query =
      "SELECT \
	        CASE WHEN fatturato = 0 THEN 0 \
			      WHEN fatturato > 0 AND fatturato < 1000 THEN 1000 \
		        WHEN fatturato > 1000 AND fatturato < 2000 THEN 1000 + fatturato + (fatturato * 0.1) \
		        WHEN fatturato > 2000 AND fatturato < 3000 THEN 1000 + fatturato + (fatturato * 0.15) \
		        WHEN fatturato > 3000 AND fatturato < 4000 THEN 1000 + fatturato + (fatturato * 0.17) \
		        WHEN fatturato > 4000 THEN 1000 + fatturato + (fatturato * 0.2) \
	        END AS stipendio\
      FROM month_earning($1, $2)";

  PGresult* stmt = PQprepare(conn, "query_sti", query.c_str(), 2, NULL);

  const char* params[2];
  params[0] = tit.c_str();
  params[1] = std::to_string(month).c_str();
  res = PQexecPrepared(conn, "query_sti", 2, params, nullptr, 0, 0);

  checkResults(res, conn);

  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j) ? PQgetvalue(res, i, j) : 0);
    }
    printf("\n");
  }
}

void stip_dip(PGconn* conn) {
  PGresult* res;

  print_dipendenti(conn);
  cout << endl;

  int month;
  string dip;
  string pizzeria;

  cout << "Inserisci il codice fiscale del dipendente per la quale effettuare il calcolo dello stipendio: ";
  cin >> dip;
  cout << "Inserisci il mese per il calcolo dello stipendio (numero 1-12): ";
  cin >> month;

  string query =
      "SELECT distinct \
	        CASE WHEN dipendente.impiego = 'Domiciliare_Macchina' THEN  (stipendio * night_at_work.nights + km.km * 0.3) \
		           WHEN dipendente.impiego <> 'Domiciliare_Macchina' THEN stipendio * night_at_work.nights \
	        END AS stipendio\
          FROM dipendente \
          LEFT JOIN pizzeria \
          ON pizzeria.id = dipendente.pizzeria \
          LEFT JOIN turno \
          ON turno.dipendente = dipendente.cf \
          LEFT JOIN stipendio_base \
          ON stipendio_base.impiego = dipendente.impiego \
          LEFT JOIN night_at_work(dipendente.cf, $2, 2021) \
          ON dipendente.cf = night_at_work.dip \
          LEFT JOIN km(dipendente.cf, $2, 2021) \
          ON dipendente.cf = km.dip \
          WHERE dipendente.cf = $1";

  PGresult* stmt = PQprepare(conn, "query_sti", query.c_str(), 2, NULL);

  const char* params[2];
  params[0] = dip.c_str();
  params[1] = std::to_string(month).c_str();
  res = PQexecPrepared(conn, "query_sti", 2, params, nullptr, 0, 0);

  checkResults(res, conn);

  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j) ? PQgetvalue(res, i, j) : 0);
    }
    printf("\n");
  }
}

void piz_rif(PGconn* conn) {
  PGresult* res;

  string query =
      "SELECT pizzeria.id, ingrediente.nome, stock.quantita \
        FROM amministrazione \
        INNER JOIN pizzeria \
        ON pizzeria.amministrazione = amministrazione.id \
        INNER JOIN magazzino \
        ON magazzino.gestore = pizzeria.id \
        INNER JOIN stock \
        ON stock.magazzino = magazzino.id \
        INNER JOIN ingrediente \
        ON ingrediente.nome = stock.ingrediente \
        WHERE stock.quantita < 20";

  res = PQexec(conn, query.c_str());

  checkResults(res, conn);

  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-20s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-20s", PQgetvalue(res, i, j) ? PQgetvalue(res, i, j) : 0);
    }
    printf("\n");
  }
}

void checkResults(PGresult* res, const PGconn* conn) {
  if (PQresultStatus(res) != PGRES_TUPLES_OK) {
    cout << "Risultati inconsistenti!" << PQerrorMessage(conn) << endl;
    PQclear(res);
    exit(1);
  }
}

void refill(PGconn* conn) {
  PGresult* res;

  print_pizzeria(conn);
  cout << endl;

  print_ingredienti(conn);
  cout << endl;

  char query[10000];
  string aux =
      "BEGIN; \
	        WITH  \
	        	_piz AS ( \
	        		SELECT pizzeria.id AS p, amministrazione.id AS a \
	        		FROM pizzeria \
	        		LEFT JOIN amministrazione \
	        		ON amministrazione.id = pizzeria.amministrazione \
	        		WHERE pizzeria.id = '%s' \
	        	), \
	        	_rif AS ( \
	        		INSERT INTO rifornimento (mittente, magazzino, data) VALUES ((SELECT a FROM _piz), (SELECT id FROM magazzino WHERE gestore = (SELECT p FROM _piz)), NOW()) RETURNING id \
	        	), \
	        	_bol AS ( \
	        		INSERT INTO bolla_carico (rifornimento, ingrediente, quantita) VALUES ((SELECT MAX(id) FROM rifornimento), '%s', '%d') RETURNING ingrediente, rifornimento, quantita \
	        	), \
	        	_up AS ( \
	        		INSERT INTO stock (magazzino, ingrediente, quantita) VALUES ((SELECT id FROM magazzino WHERE magazzino.gestore = (SELECT p FROM _piz)), (SELECT ingrediente FROM _bol), (SELECT quantita FROM _bol)) ON CONFLICT DO NOTHING \
	        	) \
	        UPDATE stock SET quantita = stock.quantita + up.quantita \
	        FROM (SELECT quantita FROM _bol) AS up \
	        WHERE stock.magazzino = (SELECT id FROM magazzino WHERE magazzino.gestore = (SELECT p FROM _piz)) AND stock.ingrediente = (SELECT ingrediente FROM _bol); \
        COMMIT WORK;";

  string pizzeria;
  string ingrediente;
  int quant;
  cout << "Inserisci la pizzeria da rifornire: ";
  cin >> pizzeria;
  cout << "Inserisci l'ingrediente da rifornire: ";
  cin >> ingrediente;
  cout << "Inserisci la quantità: ";
  cin >> quant;

  sprintf(query, aux.c_str(), pizzeria.c_str(), ingrediente.c_str(), quant);
  res = PQexec(conn, query);
}

void insert_order(PGconn* conn) {
  PGresult* res;

  print_dipendenti(conn);
  cout << endl;

  print_clienti(conn);
  cout << endl;

  print_formato_pizza(conn);
  cout << endl;

  char query[10000];
  string aux =
      "BEGIN; \
	        WITH \
	        	_id AS ( \
	        		INSERT INTO ordine (ora, dipendente, pizzeria, cliente) VALUES (NOW(), '%s', '%s', '%s') RETURNING id \
	        	), \
	        	_comp AS ( \
	        		INSERT INTO composizione_ordine (ordine, pizza, formato_pizza, aggiunte, rimozioni, ripetizioni) VALUES  \
	        		%s \
	        	)  \
	        INSERT INTO scontrino (id, data, tipo_pagamento, totale_lordo, iva) VALUES ((SELECT id FROM _id), NOW(), '%s', 0, 0); \
          UPDATE scontrino SET totale_lordo = (SELECT * FROM total_price((SELECT MAX(id) FROM scontrino))) WHERE id = (SELECT MAX(id) FROM scontrino); \
          UPDATE scontrino SET iva = (SELECT * FROM total_vat((SELECT MAX(id) FROM scontrino))) WHERE id = (SELECT MAX(id) FROM scontrino); \
        COMMIT;";

  string pizzeria;
  string dipendente;
  string cliente;

  cout << "Inserisci la pizzeria nella quale effettuare l'ordine: ";
  cin >> pizzeria;
  cout << "Inserisci il dipendente che eseguira' l'ordine: ";
  cin >> dipendente;
  cout << "Inserisci il cliente alla quale consegnare l'ordine: ";
  cin >> cliente;

  int n_pizze;
  cout << "Inserire il numero di pizze diverse da inserire nell'ordine: ";
  cin >> n_pizze;

  string datas;
  string in;

  string pizza;
  string formato;
  int aggiunte;
  int rimozioni;
  int ripetizioni;

  for (int i = 0; i < n_pizze; i++) {
    char data[100];

    cout << "Inserisci il nome della pizza: ";
    cin >> pizza;
    cout << "Inserisci il formato della pizza: ";
    cin >> formato;
    cout << "Inserisci le aggiunte della  pizza: ";
    cin >> aggiunte;
    cout << "Inserisci le rimozioni della  pizza: ";
    cin >> rimozioni;
    cout << "Inserisci le ripetizioni della  pizza: ";
    cin >> ripetizioni;

    sprintf(data, "((SELECT id FROM _id), '%s', '%s', '%d', '%d', '%d'),", pizza.c_str(), formato.c_str(), aggiunte, rimozioni, ripetizioni);
    datas.append(data);
  }
  datas.pop_back();

  string pagamento;
  cout << "Inserisci il tipo di pagamento: ";
  cin >> pagamento;

  sprintf(query, aux.c_str(), dipendente.c_str(), pizzeria.c_str(), cliente.c_str(), datas.c_str(), pagamento.c_str());
  res = PQexec(conn, query);
}

void fatt_prov(PGconn* conn) {
  string aux =
      "SELECT SUM(scontrino.totale_lordo) \
       FROM scontrino \
       LEFT JOIN ordine \
       ON ordine.id = scontrino.id \
       LEFT JOIN pizzeria \
       ON pizzeria.id = ordine.pizzeria \
       LEFT JOIN amministrazione \
       ON amministrazione.id = pizzeria.id \
       WHERE date_part('month', scontrino.data) = %d \
       GROUP BY pizzeria.id";
  char query[10000];

  int month;
  cout << "Inserisci il numero del mese per il calcolo delle migliori pizzerie: ";
  cin >> month;

  sprintf(query, aux.c_str(), month);
  PGresult* res;

  res = PQexec(conn, query);

  checkResults(res, conn);

  int nFields = PQnfields(res);

  for (int i = 0; i < nFields; i++) {
    printf("%-50s", PQfname(res, i));
  }
  printf("\n\n");

  for (int i = 0; i < PQntuples(res); i++) {
    for (int j = 0; j < nFields; j++) {
      printf("%-50s", PQgetvalue(res, i, j) ? PQgetvalue(res, i, j) : 0);
    }
    printf("\n");
  }
}