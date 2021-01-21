#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

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
void piz_rif(connection*);
void insert_order(connection*);
void refill(connection*);
void fatt_prov(connection*);

int main() {
  vector<string> credential = get_credential();
  connection* conn;
  try {
    conn = new connection("host=" + credential[0] + "dbname=" + credential[1] + "user=" + credential[2] + "password=" + credential[3]);
  } catch (std::runtime_error) {
    cout << "\033[1;31mImpossibile connettersi al database!\033[0m" << endl;
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

  switch (op) {
    // case 1:
    //   insert_order(conn);
    //   break;
    case 2:
      stip_tit(conn);
      break;
    case 3:
      stip_dip(conn);
      //   //   break;
      //   // case 4:
      //   //   piz_rif(conn);
      //   //   break;
      //   // case 5:
      //   //   refill(conn);
      //   //   break;
      //   // case 6:
      //   //   fatt_prov(conn);
    default:
      break;
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