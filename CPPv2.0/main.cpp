#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

#include "./dependencies/include/libpq-fe.h"
#include "./pq.hpp"

using pq::connection;
using pq::row_t;

using std::cerr;
using std::cin;
using std::cout;
using std::endl;
using std::ifstream;
using std::setw;
using std::string;
using std::vector;

vector<string> get_credential();

void print_dipendenti(connection*);
void print_titolari(connection*);
void print_pizze(connection*);
void print_ingredienti(connection*);
void print_clienti(connection*);
void print_tipo_pagamento(connection*);
void print_formato_pizza(connection*);
void print_pizzeria(connection*);

void stip_tit(connection*);
void stip_dip(connection*);
void piz_refill(connection*);
void insert_order(connection*, string);
void refill(connection*, string);
void fatt_prov(connection*);

int main() {
  vector<string> credential = get_credential();
  connection* conn;
  string cred = "host=" + credential[0] + "dbname=" + credential[1] + "user=" + credential[2] + "password=" + credential[3];
  try {
    conn = new connection(cred);
  } catch (std::runtime_error error) {
    cout << "\033[1;31mImpossibile connettersi al database!\033[0m" << endl;
    cout << "\033[1;31mErrore: " << error.what() << "\033[0m" << endl;
    return 1;
  }

  int op;
  cout << "\033[1;33m1)\033[0m Inserimento di un ordine;" << endl;
  cout << "\033[1;33m2)\033[0m Calcolare lo stipendio di un titolare;" << endl;
  cout << "\033[1;33m3)\033[0m Calcolare lo stipendio di un dipendente;" << endl;
  cout << "\033[1;33m4)\033[0m Elencare tutte le pizzeria che hanno in magazzino un alimento di quantita' < 20;" << endl;
  cout << "\033[1;33m5)\033[0m Rifornire una pizzeria;" << endl;
  cout << "\033[1;33m6)\033[0m Elencare tutte le pizzerie che hanno fatturato sopra la media in un dato mese;" << endl;
  cout << "Inserire l'operazione da eseguire (1-6): ";
  cin >> op;

  try {
    switch (op) {
      case 1:
        insert_order(conn, cred);
        break;
      case 2:
        stip_tit(conn);
        break;
      case 3:
        stip_dip(conn);
        break;
      case 4:
        piz_refill(conn);
        break;
      case 5:
        refill(conn, cred);
        break;
      case 6:
        fatt_prov(conn);
      default:
        break;
    }
  } catch (std::runtime_error error) {
    cout << "\033[1;31mErrore: " << error.what() << "\033[0m" << endl;
    return EXIT_FAILURE;
  }

  delete conn;
  return 0;
}

vector<string> get_credential() {
  vector<string> aux;
  ifstream file("./credential.txt");

  if (!file) {
    cerr << "File con le credenziali non trovato" << endl;
    exit(1);
  }

  while (!file.eof()) {
    string line;
    file >> line;
    aux.push_back(line + " ");
  }

  file.close();

  return aux;
}

void print_dipendenti(connection* conn) {
  vector<row_t> rows = conn->exec("SELECT dipendente.cf, dipendente.nome, dipendente.cognome, dipendente.impiego, dipendente.pizzeria FROM dipendente JOIN pizzeria ON pizzeria.id = dipendente.pizzeria");

  cout << "\033[1;4;94mCodice Fiscale" << setw(15) << "Nome" << setw(22) << "Cognome" << setw(25) << "Impiego" << setw(22) << "Pizzeria"
       << "\033[0m" << endl;
  for (row_t& row : rows) {
    string cf = row["cf"];
    string name = row["nome"];
    string last_name = row["cognome"];
    string imp = row["impiego"];
    string piz = row["pizzeria"];

    cout << cf << setw(15) << name << setw(20) << last_name << setw(25) << imp << setw(20) << piz << endl;
  }
}

void print_titolari(connection* conn) {
  vector<row_t> rows = conn->exec("SELECT DISTINCT titolare.cf, titolare.nome, titolare.cognome FROM titolare JOIN pizzeria ON pizzeria.titolare = titolare.cf");

  cout << "\033[1;4;94mCodice Fiscale" << setw(15) << "Nome" << setw(22) << "Cognome"
       << "\033[0m" << endl;
  for (row_t& row : rows) {
    string cf = row["cf"];
    string name = row["nome"];
    string last_name = row["cognome"];

    cout << cf << setw(15) << name << setw(20) << last_name << endl;
  }

  cout << endl;
}

void print_pizze(connection* conn) {
  vector<row_t> rows = conn->exec("SELECT * FROM pizza");

  cout << "\033[1;4;94m" << setw(25) << "Nome" << setw(17) << "Prezzo"
       << "\033[0m" << endl;
  for (row_t& row : rows) {
    string name = row["nome"];
    string price = row["prezzo"];

    cout << setw(25) << name << setw(15) << "€" << price << endl;
  }

  cout << endl;
}

void print_ingredienti(connection* conn) {
  vector<row_t> rows = conn->exec("SELECT * FROM ingrediente");

  cout << "\033[1;4;94m" << setw(28) << "Nome" << setw(20) << "Conservazione"
       << "\033[0m" << endl;
  for (row_t& row : rows) {
    string name = row["nome"];
    string cons = row["conservazione"];

    cout << setw(28) << name << setw(20) << cons << endl;
  }

  cout << endl;
}

void print_clienti(connection* conn) {
  vector<row_t> rows = conn->exec("SELECT * FROM cliente");

  cout << "\033[1;4;94mID" << setw(20) << "Cogome" << setw(55) << "Indirizzo"
       << "\033[0m" << endl;
  for (row_t& row : rows) {
    string id = row["id"];
    string name = row["cognome"];
    string add = row["indirizzo"];

    cout << id << setw(20) << name << setw(55) << add << endl;
  }

  cout << endl;
}

void print_tipo_pagamento(connection* conn) {
  vector<row_t> rows = conn->exec("SELECT * FROM tipo_pagamento");

  cout << "\033[1;4;94mPagamento"
       << "\033[0m" << endl;
  for (row_t& row : rows) {
    string pag = row["pagamento"];

    cout << pag << endl;
  }

  cout << endl;
}

void print_formato_pizza(connection* conn) {
  vector<row_t> rows = conn->exec("SELECT * FROM formato_pizza");

  cout << setw(5) << "\033[1;4;94mVariazione" << setw(18) << "Formato"
       << "\033[0m" << endl;
  for (row_t& row : rows) {
    string pag = row["tipo"];
    string diff = row["differenza_prezzo"];

    cout << setw(5) << "€" << diff << setw(20) << pag << endl;
  }

  cout << endl;
}

void print_pizzeria(connection* conn) {
  vector<row_t> rows = conn->exec("SELECT * FROM pizzeria");

  cout << "\033[1;4;94mID" << setw(30) << "Indirizzo" << setw(27) << "Citta" << setw(16) << "Provincia" << setw(13) << "Numero"
       << "\033[0m" << endl;
  for (row_t& row : rows) {
    string id = row["id"];
    string add = row["indirizzo"];
    string city = row["citta"];
    string prov = row["provincia"];
    string num = row["numero_tel"];

    cout << id << setw(30) << add << setw(25) << city << setw(11) << prov << setw(20) << num << endl;
  }
}

void insert_order(connection* conn, string c) {
  print_dipendenti(conn);
  cout << endl;

  print_clienti(conn);
  cout << endl;

  print_formato_pizza(conn);
  cout << endl;

  print_pizze(conn);
  cout << endl;

  print_tipo_pagamento(conn);
  cout << endl;

  char query[10000];
  string aux =
      "BEGIN; \
       DO $$ \
       DECLARE \
       	_id BIGINT; \
       	_now TIMESTAMP; \
       BEGIN  \
       	_now := NOW(); \
       	INSERT INTO ordine (ora, dipendente, pizzeria, cliente) VALUES  \
       				(_now, '%s', '%s', '%s') RETURNING id INTO _id; \
       	INSERT INTO composizione_ordine (ordine, pizza, formato_pizza, aggiunte, rimozioni, ripetizioni) VALUES  \
       		%s \
        \
       	INSERT INTO scontrino (id, data, tipo_pagamento, totale_lordo, iva) VALUES (_id, _now, '%s', (SELECT * FROM total_price(_id)), (SELECT * FROM total_vat(_id))); \
       END; \
       $$ LANGUAGE 'plpgsql'; \
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

    sprintf(data, "(_id, '%s', '%s', '%d', '%d', '%d'),", pizza.c_str(), formato.c_str(), aggiunte, rimozioni, ripetizioni);
    datas.append(data);
  }
  datas.pop_back();
  datas.push_back(';');

  string pagamento;
  cout << "Inserisci il tipo di pagamento: ";
  cin >> pagamento;

  sprintf(query, aux.c_str(), dipendente.c_str(), pizzeria.c_str(), cliente.c_str(), datas.c_str(), pagamento.c_str());

  PGconn* con = PQconnectdb(c.c_str());
  PGresult* r = PQexec(con, query);
  if (r) {
    cout << "\033[1;32mOrdine inserito correttamente!\033[0m" << endl;
  } else {
    cout << "\033[1;33mOrdine non inserito!\033[0m" << endl;
  }
}

void stip_tit(connection* conn) {
  int month;
  int year;
  string tit;

  print_titolari(conn);
  cout << endl;

  auto stmt = conn->prepare("select_tit",
                            "SELECT \
	                            CASE WHEN fatturato = 0 THEN 0 \
			                          WHEN fatturato > 0 AND fatturato < 1000 THEN 1000 \
		                            WHEN fatturato > 1000 AND fatturato < 2000 THEN 1000 + fatturato + (fatturato * 0.1) \
		                            WHEN fatturato > 2000 AND fatturato < 3000 THEN 1000 + fatturato + (fatturato * 0.15) \
		                            WHEN fatturato > 3000 AND fatturato < 4000 THEN 1000 + fatturato + (fatturato * 0.17) \
		                            WHEN fatturato > 4000 THEN 1000 + fatturato + (fatturato * 0.2) \
	                            END AS stipendio\
                            FROM month_earning($1, $2, $3)",
                            3);

  cout << "Inserisci il codice fiscale del titolare per la quale effettuare il calcolo dello stipendio: ";
  cin >> tit;
  cout << "Inserisci il mese per il calcolo dello stipendio (numero 1-12): ";
  cin >> month;
  cout << "Inserisci l'anno per il calcolo dello stipendio (e.g. 2020): ";
  cin >> year;
  cout << endl;

  vector<row_t> rows = conn->exec(stmt, tit, month, year);

  cout << endl;
  cout << "\033[1;4;94mStipendio"
       << "\033[0m" << endl;
  if (rows.empty()) {
    cout << "€0" << endl;
  } else {
    for (row_t& row : rows) {
      cout << "€" << row["stipendio"].str() << endl;
    }
  }

  cout << endl;
}

void stip_dip(connection* conn) {
  print_dipendenti(conn);
  cout << endl;

  int month;
  int year;
  string dip;

  cout << "Inserisci il codice fiscale del dipendente per la quale effettuare il calcolo dello stipendio: ";
  cin >> dip;
  cout << "Inserisci il mese per il calcolo dello stipendio (numero 1-12): ";
  cin >> month;
  cout << "Inserisci l'anno per il calcolo dello stipendio (e.g. 2020): ";
  cin >> year;
  cout << endl;

  auto stmt = conn->prepare("select_dip",
                            "SELECT DISTINCT  \
                              	CASE WHEN night_at_work.nights = 0 THEN 0 \
                              		   WHEN dipendente.impiego = 'Domiciliare_Macchina' THEN  (stipendio * night_at_work.nights + km.km * 0.3) \
                              		   WHEN dipendente.impiego <> 'Domiciliare_Macchina' THEN stipendio * night_at_work.nights \
                              	END as Stipendio \
                              FROM dipendente \
                              LEFT JOIN pizzeria \
                              ON pizzeria.id = dipendente.pizzeria \
                              LEFT JOIN turno \
                              ON turno.dipendente = dipendente.cf \
                              LEFT JOIN lavoro \
                              ON lavoro.impiego = dipendente.impiego \
                              LEFT JOIN night_at_work(dipendente.cf, $2, $3) \
                              ON dipendente.cf = night_at_work.dipendente \
                              LEFT JOIN km(dipendente.cf, $2, $3) \
                              ON dipendente.cf = km.dip \
                              WHERE dipendente.cf = $1",
                            3);

  vector<row_t> rows = conn->exec(stmt, dip, month, year);

  cout << endl;
  cout << "\033[1;4;94mStipendio"
       << "\033[0m" << endl;
  if (rows.empty()) {
    cout << "€0" << endl;
  } else {
    for (row_t& row : rows) {
      cout << "€" << row["stipendio"].str() << endl;
    }
  }

  cout << endl;
}

void piz_refill(connection* conn) {
  print_pizze(conn);
  cout << endl;

  vector<row_t> rows = conn->exec(
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
       WHERE stock.quantita < 20");

  cout << "\033[1;4;94mID" << setw(30) << "Ingrediente" << setw(30) << "Quantita'"
       << "\033[0m" << endl;
  for (row_t& row : rows) {
    string id = row["id"];
    string ing = row["nome"];
    string qua = row["quantita"];

    cout << id << setw(30) << ing << setw(25) << qua << endl;
  }
}

void refill(connection* conn, string c) {
  print_pizzeria(conn);
  cout << endl;

  print_ingredienti(conn);
  cout << endl;

  string pizzeria;
  string ingrediente;
  unsigned int quantita;

  cout << "Inserisci la pizzeria da rifornire: ";
  cin >> pizzeria;
  cout << "Inserisci l'ingrediente da rifornire: ";
  cin >> ingrediente;
  cout << "Inserisci la quantita': ";
  cin >> quantita;
  cout << endl;

  char query[10000];
  string aux =
      "BEGIN; \
                DO $$ \
                DECLARE \
                	_pizzeria TEXT; \
                	_amministrazione TEXT; \
                	_ingrediente VARCHAR; \
                	_magazzino BIGINT; \
                	_quantita INTEGER; \
                	_rifornimento BIGINT; \
                	_bolla BIGINT; \
                BEGIN  \
                	_pizzeria := '%s'; \
                	_ingrediente := '%s'; \
                	_quantita := %d; \
                	_magazzino := (SELECT id FROM magazzino WHERE magazzino.gestore = _pizzeria); \
                	_amministrazione := (SELECT amministrazione.id \
                						 					 FROM pizzeria \
                						 					 LEFT JOIN amministrazione \
                						 					 ON amministrazione.id = pizzeria.amministrazione \
                						 					 WHERE pizzeria.id = _pizzeria); \
                	INSERT INTO rifornimento (mittente, magazzino, data) VALUES (_amministrazione, _magazzino, NOW()) RETURNING id INTO _rifornimento; \
                	INSERT INTO bolla_carico (rifornimento, ingrediente, quantita) VALUES (_rifornimento, _ingrediente, _quantita); \
                	INSERT INTO stock (magazzino, ingrediente, quantita) VALUES (_magazzino, _ingrediente, _quantita) ON CONFLICT (magazzino, ingrediente) DO \
                		UPDATE SET quantita = stock.quantita + _quantita; \
                END; \
                $$ LANGUAGE 'plpgsql'; \
                COMMIT;";

  sprintf(query, aux.c_str(), pizzeria.c_str(), ingrediente.c_str(), quantita);

  PGconn* con = PQconnectdb(c.c_str());
  PGresult* r = PQexec(con, query);
  if (r) {
    cout << "\033[1;32mRefill completato!\033[0m" << endl;
  } else {
    cout << "\033[1;33mRefill non possibile!\033[0m" << endl;
  }
}

void fatt_prov(connection* conn) {
  cout << endl;
  unsigned int month;
  unsigned int year;

  cout << "Inserisci il mese desiderato(1-12): ";
  cin >> month;
  cout << "Inserisci l'anno desiderato(e.g. 2021): ";
  cin >> year;

  auto stmt = conn->prepare("select_fatt_mens",
                            "SELECT pizzeria.id AS Pizzeria, SUM(scontrino.totale_lordo) AS fatturato \
                             FROM scontrino \
                             LEFT JOIN ordine \
                             ON ordine.id = scontrino.id \
                             LEFT JOIN pizzeria \
                             ON pizzeria.id = ordine.pizzeria \
                             LEFT JOIN amministrazione \
                             ON amministrazione.id = pizzeria.id \
                             WHERE date_part('month', scontrino.data) = $1 AND date_part('year', scontrino.data) = $2 \
                             GROUP BY pizzeria.id",
                            2);

  vector<row_t> rows = conn->exec(stmt, month, year);

  cout << endl;
  cout << "\033[1;4;94mID" << setw(30) << "Fatturato"
       << "\033[0m" << endl;
  for (row_t& row : rows) {
    string id = row["pizzeria"];
    string fat = row["fatturato"];

    cout << id << setw(25) << fat << endl;
  }
  cout << endl;
}