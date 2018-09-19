1) export schemas from cassandra

C:\mt4cass\cassandra-scripts>cqlsh -e "DESC KEYSPACE mts_src" > mts_src.cql
C:\mt4cass\cassandra-scripts>cqlsh -e "DESC KEYSPACE mts_meta" > mts_meta.cql
C:\mt4cass\cassandra-scripts>cqlsh -e "DESC KEYSPACE mts_bars" > mts_bars.cql

cqlsh need installed Python 2.7 and env variables, Example:
PythonPath: C:\Python27\Lib;C:\Python27\DLLs;C:\Python27\Lib\lib-tk;

2) export table data into csv

COPY mts_meta.tickers TO 'C:\mt4cass\cassandra-scripts\tickers.csv' WITH HEADER = FALSE;

C:\mt4cass\cassandra-scripts>cqlsh

WARNING: console codepage must be set to cp65001 to support utf-8 encoding on Windows platforms.
If you experience encoding problems, change your console codepage with 'chcp 65001' before starting cqlsh.

Connected to Test Cluster at 127.0.0.1:9042.
[cqlsh 5.0.1 | Cassandra 3.11.2 | CQL spec 3.4.4 | Native protocol v4]
Use HELP for help.
WARNING: pyreadline dependency missing.  Install to enable tab completion.
cqlsh> COPY mts_meta.tickers TO 'C:\mt4cass\cassandra-scripts\tickers.csv' WITH HEADER = FALSE;
Using 3 child processes

Starting copy of mts_meta.tickers with columns [ticker_id, ticker_code, ticker_first, ticker_seconds].
Processed: 28 rows; Rate:      39 rows/s; Avg. rate:      33 rows/s
28 rows exported to 1 files in 0.952 seconds.
cqlsh>

