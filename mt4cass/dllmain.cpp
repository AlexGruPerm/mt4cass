#include "stdafx.h"
#include <assert.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "cassandra.h"
#include <plog/Log.h>
#include <iostream> 
#include <map>

typedef std::map<std::string, cass_int32_t> MapOfTickerSymbol;
typedef std::map<cass_int32_t, CassStatement*> MapOftickerStatement;

class Mt4Cass
{
private:
	static Mt4Cass* instance;

	Mt4Cass(const char* casshosts);
	~Mt4Cass();

public:
	static Mt4Cass* getInstance(const char* casshosts);
	CassSession*    session = NULL;
	CassCluster*    cluster = NULL;
	CassFuture*     prepared_future    = NULL;
	CassStatement*  savetick_statement = NULL;
	size_t          i = 0;

	const CassPrepared* savetick_prepared = NULL;
	const char*         savetick_query = "insert into mts_src.ticks(ticker_id, ddate, ts, db_tsunx, bid, ask) values(?, ?, ?, toUnixTimestamp(now()), ?, ?);";

	MapOfTickerSymbol    SymbolTickerMap;
	MapOftickerStatement TickerMapStmt;
};

Mt4Cass* Mt4Cass::instance = 0;

Mt4Cass* Mt4Cass::getInstance(const char* casshosts)
{
	if (instance == 0)
	{
		instance = new Mt4Cass(casshosts);
	}
	return instance;
}


Mt4Cass::Mt4Cass(const char* casshosts) {

	session = cass_session_new();
	cluster = cass_cluster_new();
	cass_cluster_set_contact_points(cluster, casshosts); //cass_cluster_set_num_threads_io(cluster, 2);
	CassFuture* connect_future = cass_session_connect(session, cluster);
	cass_future_wait(connect_future);

	prepared_future = cass_session_prepare(session, savetick_query);
	if (cass_future_error_code(prepared_future) != CASS_OK) {
		const char* message;
		size_t message_length;
		cass_future_error_message(prepared_future, &message, &message_length);
		LOGE << message;
		cass_future_free(prepared_future);
	}
	else {
		savetick_prepared = cass_future_get_prepared(prepared_future);
		cass_future_free(prepared_future);
		savetick_statement = cass_prepared_bind(savetick_prepared);
	}


const char*  all_tickers = "select ticker_code,ticker_id from mts_meta.tickers;";
CassStatement* stmt = cass_statement_new(all_tickers, 0);
CassFuture* all_tickers_future = cass_session_execute(session, stmt);
cass_statement_free(stmt);	                                           
const CassResult* result = cass_future_get_result(all_tickers_future); 
CassIterator* row_iterator = cass_iterator_from_result(result);        

const char*   ticker_code;
size_t        ticker_code_length;
cass_int32_t  ticker_id;

while (cass_iterator_next(row_iterator)) {
	const CassRow* row = cass_iterator_get_row(row_iterator);
	const CassValue* value = cass_row_get_column_by_name(row, "ticker_code");
	cass_value_get_string(value, &ticker_code, &ticker_code_length);
	cass_value_get_int32(cass_row_get_column_by_name(row, "ticker_id"), &ticker_id);
	std::string scode = ticker_code;
	SymbolTickerMap[scode] = ticker_id;
	TickerMapStmt[ticker_id] = cass_prepared_bind(savetick_prepared);
}

cass_iterator_free(row_iterator);
}

Mt4Cass::~Mt4Cass() {
	cass_cluster_free(cluster);
	cass_session_free(session);
	cass_future_free(prepared_future);
	cass_statement_free(savetick_statement);
}


BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved) {
	plog::init(plog::error, "C:\\mt4logs\\mt4cass_log.txt"); // https://github.com/SergiusTheBest/plog
	switch (fdwReason)
	{
	case DLL_PROCESS_ATTACH:
		break;
	case DLL_PROCESS_DETACH:
		break;
	case DLL_THREAD_ATTACH:
		break;
	case DLL_THREAD_DETACH:
		break;
	}
  return TRUE;
}


_DLLAPI void savetick(const char* casshosts, const char* csymbol, double bid, double ask, int currdt) {
	LOGI << "savetick begin";
	Mt4Cass* cass = Mt4Cass::getInstance(casshosts);

	cass_statement_bind_int32(cass-> TickerMapStmt[cass->SymbolTickerMap[csymbol]], 0, cass->SymbolTickerMap[csymbol]);
	cass_statement_bind_uint32(cass->TickerMapStmt[cass->SymbolTickerMap[csymbol]], 1, cass_date_from_epoch(currdt));  
	cass_statement_bind_int64(cass-> TickerMapStmt[cass->SymbolTickerMap[csymbol]], 2, currdt);                       
	cass_statement_bind_double(cass->TickerMapStmt[cass->SymbolTickerMap[csymbol]], 3, bid);
	cass_statement_bind_double(cass->TickerMapStmt[cass->SymbolTickerMap[csymbol]], 4, ask);

	CassFuture* future = cass_session_execute(cass->session, cass->TickerMapStmt[cass->SymbolTickerMap[csymbol]]);
	cass_future_wait(future);

	if (cass_future_error_code(future) != CASS_OK) {
		const char* message;
		size_t message_length;
		cass_future_error_message(future, &message, &message_length);
		cass_future_free(future);
		LOGE << message;
	}

	LOGI << "savetick end";
	//return 0;
}