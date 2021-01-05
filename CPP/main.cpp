#include <cstdio>
#include <iomanip>
#include <iostream>

#include "./dependencies/include/libpq-fe.h"

using std::cin;
using std::cout;
using std::endl;
using std::setw;

using std::string;

#define PG_HOST "127.0.0.1"
#define PG_USER "NicholasPilotto"  //il vostro nome utente
#define PG_DB "test_padupizza"     //il nome del database
#define PG_PASS "Nicholasp99"      //la vostra password
#define PG_PORT 5432

void checkResults(PGresult*, const PGconn*);

void stip_tit();

int main(int argc, char const* argv[]) {
  stip_tit();
  return 0;
}

void stip_tit() {
  PGconn* conn;
  char conn_info[250];
  sprintf(conn_info, "user=%s password=%s dbname=%s hostaddr=%s port=%d", PG_USER, PG_PASS, PG_DB, PG_HOST, PG_PORT);
  conn = PQconnectdb(conn_info);

  if (PQstatus(conn) != CONNECTION_OK) {
    cout << "Errore di connessione " << PQerrorMessage(conn);
    PQfinish(conn);
    exit(1);
  } else {
    cout << "Connessione avvenuta correttamente" << endl;
    PGresult* res;

    cout << "\n---------------------------------------------------------- TITOLARI ----------------------------------------------------------" << endl;
    string query = "SELECT DISTINCT titolare.cf, titolare.nome, titolare.cognome FROM titolare JOIN pizzeria ON pizzeria.titolare = titolare.cf";

    PGresult* stmt = PQprepare(conn, "query_t", query.c_str(), 0, NULL);

    res = PQexecPrepared(conn, "query_t", 0, nullptr, nullptr, 0, 0);

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

    int month;
    string tit;

    cout << "Inserisci il codice fiscale del titolare per la quale effettuare il calcolo dello stipendio: ";
    cin >> tit;
    cout << "Inserisci il mese per il calcolo dello stipendio";
    cin >> month;

    query =
        "SELECT \
	        CASE WHEN fatturato = 0 THEN 0 \
			      WHEN fatturato > 0 AND fatturato < 1000 THEN 1000 \
		        WHEN fatturato > 1000 AND fatturato < 2000 THEN 1000 + fatturato + (fatturato * 0.1) \
		        WHEN fatturato > 2000 AND fatturato < 3000 THEN 1000 + fatturato + (fatturato * 0.15) \
		        WHEN fatturato > 3000 AND fatturato < 4000 THEN 1000 + fatturato + (fatturato * 0.17) \
		        WHEN fatturato > 4000 THEN 1000 + fatturato + (fatturato * 0.2) \
	        END AS stipendio\
      FROM month_earning($1, $2)";

    stmt = PQprepare(conn, "query_sti", query.c_str(), 2, NULL);

    const char* params[2];
    params[0] = tit.c_str();
    params[1] = std::to_string(month).c_str();
    res = PQexecPrepared(conn, "query_sti", 2, params, nullptr, 0, 0);

    checkResults(res, conn);

    nFields = PQnfields(res);

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
}

// int main(int argc, char const* argv[]) {
//   PGconn* conn;
//   char conn_info[250];
//   sprintf(conn_info, "user=%s password=%s dbname=%s hostaddr=%s port=%d", PG_USER, PG_PASS, PG_DB, PG_HOST, PG_PORT);
//   conn = PQconnectdb(conn_info);

//   if (PQstatus(conn) != CONNECTION_OK) {
//     cout << "Errore di connessione " << PQerrorMessage(conn);
//     PQfinish(conn);
//     exit(1);
//   } else {
//     cout << "Connessione avvenuta correttamente" << endl;
//     PGresult* res;

//     cout << "\n---------------------------------------------------------- PIZZE ----------------------------------------------------------" << endl;
//     string query = "SELECT * FROM pizza";

//     PGresult* stmt = PQprepare(conn, "query_pizze", query.c_str(), 0, NULL);

//     res = PQexecPrepared(conn, "query_pizze", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     int nFields = PQnfields(res);

//     for (int i = 0; i < nFields; i++) {
//       printf("%-50s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-50s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n-------------------------------------- CLIENTI --------------------------------------" << endl;
//     query = "SELECT * FROM cliente";

//     stmt = PQprepare(conn, "query_clienti", query.c_str(), 0, NULL);
//     res = PQexecPrepared(conn, "query_clienti", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     nFields = PQnfields(res);
//     for (int i = 0; i < nFields; i++) {
//       printf("%-20s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-20s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n-------------------------------------- DIPEDENTI --------------------------------------" << endl;
//     query = "SELECT * FROM dipendente WHERE impiego = 'Domiciliare_Macchina' OR impiego = 'Domiciliare_Furgone'";

//     stmt = PQprepare(conn, "query_dipendenti", query.c_str(), 0, NULL);
//     res = PQexecPrepared(conn, "query_dipendenti", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     nFields = PQnfields(res);

//     for (int i = 0; i < nFields; i++) {
//       printf("%-25s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-25s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n---------------------------------------------------------- PIZZERIA ----------------------------------------------------------" << endl;
//     query = "SELECT * FROM pizzeria";

//     stmt = PQprepare(conn, "query_pizzeria", query.c_str(), 0, NULL);
//     res = PQexecPrepared(conn, "query_pizzeria", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     nFields = PQnfields(res);

//     for (int i = 0; i < nFields; i++) {
//       printf("%-28s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-28s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n---------------------------------------------------------- FORMATO_PIZZA ----------------------------------------------------------" << endl;
//     query = "SELECT * FROM formato_pizza";

//     stmt = PQprepare(conn, "query_for", query.c_str(), 0, NULL);
//     res = PQexecPrepared(conn, "query_for", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     nFields = PQnfields(res);

//     for (int i = 0; i < nFields; i++) {
//       printf("%-20s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-20s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n---------------------------------------------------------- TIPO_PAGAMENTO ----------------------------------------------------------" << endl;
//     query = "SELECT * FROM tipo_pagamento";

//     stmt = PQprepare(conn, "query_pag", query.c_str(), 0, NULL);
//     res = PQexecPrepared(conn, "query_pag", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     nFields = PQnfields(res);

//     for (int i = 0; i < nFields; i++) {
//       printf("%-20s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-20s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n\n\n\n";

//     string dipendente;
//     string pizzeria;
//     string cliente;

//     cout << "Inserisci il dipendente che deve eseguire l'ordine: ";
//     cin >> dipendente;

//     cout << "Inserisci la pizzeria che deve eseguire l'ordine: ";
//     cin >> pizzeria;

//     cout << "Inserisci il cliente che ricevera' l'ordine: ";
//     cin >> cliente;

//     int n_pizze = 0;
//     cout << "Quante pizze devi ordinare? ";
//     cin >> n_pizze;

//     string aux;

//     res = PQexec(conn, "BEGIN;");
//     query =
//         "WITH \
// 		      _id AS ( \
// 			      INSERT INTO ordine (ora, dipendente, pizzeria, cliente) VALUES (NOW(), ?, ?, ?) RETURNING id \
// 		    )";
//     const char* params1[3];
//     params1[0] = dipendente.c_str();
//     params1[1] = pizzeria.c_str();
//     params1[2] = cliente.c_str();
//     stmt = PQprepare(conn, "first", query.c_str(), 3, NULL);
//     res = PQexecPrepared(conn, "first", 3, params1, NULL, 0, 0);

//     for (int i = 0; i < n_pizze; i++) {
//       string pizza;
//       string formato;
//       int aggiunte;
//       int rimozioni;
//       int ripetizioni;
//       cout << "Inserisci l'id della pizza desiderata: ";
//       cin >> pizza;
//       cout << "Inserisci il formato della pizza: ";
//       cin >> formato;
//       cout << "Quante aggiunte vuoi fare? ";
//       cin >> aggiunte;
//       cout << "Quante rimozioni vuoi fare? ";
//       cin >> rimozioni;
//       cout << "Quante di questa pizza vuoi fare? ";
//       cin >> ripetizioni;

//       query =
//           "_comp AS ( \
// 			      INSERT INTO composizione_ordine (ordine, pizza, formato_pizza, aggiunte, rimozioni, ripetizioni) VALUES \
// 			        ((SELECT id FROM _id), ?, ?, ?, ?, ?) \
// 		      )";
//       const char* params2[5];
//       params2[0] = pizza.c_str();
//       params2[1] = formato.c_str();
//       params2[2] = std::to_string(aggiunte).c_str();
//       params2[3] = std::to_string(rimozioni).c_str();
//       params2[4] = std::to_string(ripetizioni).c_str();
//       stmt = PQprepare(conn, "second", query.c_str(), 5, NULL);
//       res = PQexecPrepared(conn, "second", 5, params2, NULL, 0, 0);
//     }

//     query =
//         "INSERT INTO scontrino (id, data, tipo_pagamento, totale_lordo, iva) VALUES ((SELECT id FROM _id), NOW(), ?, 0, 0); \
// 	      UPDATE scontrino SET totale_lordo = (SELECT * FROM total_price((SELECT MAX(id) FROM scontrino))) WHERE id = (SELECT MAX(id) FROM scontrino); \
// 	      UPDATE scontrino SET iva = (SELECT * FROM total_vat((SELECT MAX(id) FROM scontrino))) WHERE id = (SELECT MAX(id) FROM scontrino);";
//     string pag;
//     cout << "Come vuoi pagare? ";
//     cin >> pag;
//     const char* params3[1];
//     params3[0] = pag.c_str();
//     stmt = PQprepare(conn, "third", query.c_str(), 1, NULL);
//     res = PQexecPrepared(conn, "third", 1, params3, NULL, 0, 0);
//     res = PQexec(conn, "COMMIT;");
//     checkResults(res, conn);

//     cout << "Complete" << endl;
//     PQfinish(conn);
//   }

//   return 0;
// }

void checkResults(PGresult* res, const PGconn* conn) {
  if (PQresultStatus(res) != PGRES_TUPLES_OK) {
    cout << "Risultati inconsistenti!" << PQerrorMessage(conn) << endl;
    PQclear(res);
    exit(1);
  }
}

// #include <cstdio>
// #include <iomanip>
// #include <iostream>

// #include "./dependencies/include/libpq-fe.h"

// using std::cin;
// using std::cout;
// using std::endl;
// using std::setw;

// using std::string;

// #define PG_HOST "127.0.0.1"
// #define PG_USER "NicholasPilotto"  //il vostro nome utente
// #define PG_DB "test_padupizza"     //il nome del database
// #define PG_PASS "Nicholasp99"      //la vostra password
// #define PG_PORT 5432

// void checkResults(PGresult*, const PGconn*);

// int main(int argc, char const* argv[]) {
//   PGconn* conn;
//   char conn_info[250];
//   sprintf(conn_info, "user=%s password=%s dbname=%s hostaddr=%s port=%d", PG_USER, PG_PASS, PG_DB, PG_HOST, PG_PORT);
//   conn = PQconnectdb(conn_info);

//   if (PQstatus(conn) != CONNECTION_OK) {
//     cout << "Errore di connessione " << PQerrorMessage(conn);
//     PQfinish(conn);
//     exit(1);
//   } else {
//     cout << "Connessione avvenuta correttamente" << endl;
//     PGresult* res;

//     cout << "\n---------------------------------------------------------- PIZZE ----------------------------------------------------------" << endl;
//     string query = "SELECT * FROM pizza";

//     PGresult* stmt = PQprepare(conn, "query_pizze", query.c_str(), 0, NULL);

//     res = PQexecPrepared(conn, "query_pizze", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     int nFields = PQnfields(res);

//     for (int i = 0; i < nFields; i++) {
//       printf("%-50s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-50s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n-------------------------------------- CLIENTI --------------------------------------" << endl;
//     query = "SELECT * FROM cliente";

//     stmt = PQprepare(conn, "query_clienti", query.c_str(), 0, NULL);
//     res = PQexecPrepared(conn, "query_clienti", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     nFields = PQnfields(res);
//     for (int i = 0; i < nFields; i++) {
//       printf("%-20s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-20s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n-------------------------------------- DIPEDENTI --------------------------------------" << endl;
//     query = "SELECT * FROM dipendente WHERE impiego = 'Domiciliare_Macchina' OR impiego = 'Domiciliare_Furgone'";

//     stmt = PQprepare(conn, "query_dipendenti", query.c_str(), 0, NULL);
//     res = PQexecPrepared(conn, "query_dipendenti", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     nFields = PQnfields(res);

//     for (int i = 0; i < nFields; i++) {
//       printf("%-25s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-25s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n---------------------------------------------------------- PIZZERIA ----------------------------------------------------------" << endl;
//     query = "SELECT * FROM pizzeria";

//     stmt = PQprepare(conn, "query_pizzeria", query.c_str(), 0, NULL);
//     res = PQexecPrepared(conn, "query_pizzeria", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     nFields = PQnfields(res);

//     for (int i = 0; i < nFields; i++) {
//       printf("%-28s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-28s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n---------------------------------------------------------- FORMATO_PIZZA ----------------------------------------------------------" << endl;
//     query = "SELECT * FROM formato_pizza";

//     stmt = PQprepare(conn, "query_for", query.c_str(), 0, NULL);
//     res = PQexecPrepared(conn, "query_for", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     nFields = PQnfields(res);

//     for (int i = 0; i < nFields; i++) {
//       printf("%-20s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-20s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n---------------------------------------------------------- TIPO_PAGAMENTO ----------------------------------------------------------" << endl;
//     query = "SELECT * FROM tipo_pagamento";

//     stmt = PQprepare(conn, "query_pag", query.c_str(), 0, NULL);
//     res = PQexecPrepared(conn, "query_pag", 0, nullptr, nullptr, 0, 0);

//     checkResults(res, conn);
//     nFields = PQnfields(res);

//     for (int i = 0; i < nFields; i++) {
//       printf("%-20s", PQfname(res, i));
//     }
//     printf("\n\n");

//     for (int i = 0; i < PQntuples(res); i++) {
//       for (int j = 0; j < nFields; j++) {
//         printf("%-20s", PQgetvalue(res, i, j));
//       }
//       printf("\n");
//     }

//     cout << "\n\n\n\n";

//     string dipendente;
//     string pizzeria;
//     string cliente;

//     cout << "Inserisci il dipendente che deve eseguire l'ordine: ";
//     cin >> dipendente;

//     cout << "Inserisci la pizzeria che deve eseguire l'ordine: ";
//     cin >> pizzeria;

//     cout << "Inserisci il cliente che ricevera' l'ordine: ";
//     cin >> cliente;

//     int n_pizze = 0;
//     cout << "Quante pizze devi ordinare? ";
//     cin >> n_pizze;

//     string aux;

//     string insert =
//         "BEGIN; \
// 	        WITH \
// 		        _id AS ( \
// 		        	INSERT INTO ordine (ora, dipendente, pizzeria, cliente) VALUES (NOW(), $1, $2, $3) RETURNING id \
// 		        ), \
// 		        _comp AS ( \
// 		        	INSERT INTO composizione_ordine (ordine, pizza, formato_pizza, aggiunte, rimozioni, ripetizioni) VALUES \
// 		        	$4 \
// 		        )\
// 	        INSERT INTO scontrino (id, data, tipo_pagamento, totale_lordo, iva) VALUES ((SELECT id FROM _id), NOW(), $5, 0, 0); \
//           UPDATE scontrino SET totale_lordo = (SELECT * FROM total_price((SELECT MAX(id) FROM scontrino))) WHERE id = (SELECT MAX(id) FROM scontrino); \
//           UPDATE scontrino SET iva = (SELECT * FROM total_vat((SELECT MAX(id) FROM scontrino))) WHERE id = (SELECT MAX(id) FROM scontrino); \
//         COMMIT;";

//     string pizza;
//     string formato;
//     int aggiunte;
//     int rimozioni;
//     int ripetizioni;

//     for (int i = 0; i < n_pizze; i++) {
//       cout << "Inserisci l'id della pizza desiderata: ";
//       cin >> pizza;
//       cout << "Inserisci il formato della pizza: ";
//       cin >> formato;
//       cout << "Quante aggiunte vuoi fare? ";
//       cin >> aggiunte;
//       cout << "Quante rimozioni vuoi fare? ";
//       cin >> rimozioni;
//       cout << "Quante di questa pizza vuoi fare? ";
//       cin >> ripetizioni;

//       aux.append("((SELECT id FROM _id),'" + pizza + "','" + formato + "','" + std::to_string(aggiunte) + "','" + std::to_string(rimozioni) + "','" + std::to_string(ripetizioni) + "'),");
//     }

//     string pag;
//     cout << "Come vuoi pagare? ";
//     cin >> pag;

//     stmt = PQprepare(conn, "query_in", insert.c_str(), 5, NULL);
//     const char* parameters[5];

//     aux.pop_back();
//     parameters[0] = dipendente.c_str();
//     parameters[1] = pizzeria.c_str();
//     parameters[2] = cliente.c_str();
//     parameters[3] = aux.c_str();
//     parameters[4] = pag.c_str();
//     res = PQexecPrepared(conn, "query_in", 5, parameters, NULL, 0, 0);
//     checkResults(res, conn);

//     cout << "Complete" << endl;
//     PQfinish(conn);
//   }

//   return 0;
// }

// void checkResults(PGresult* res, const PGconn* conn) {
//   if (PQresultStatus(res) != PGRES_TUPLES_OK) {
//     cout << "Risultati inconsistenti!" << PQerrorMessage(conn) << endl;
//     PQclear(res);
//     exit(1);
//   }
// }