
CREATE KEYSPACE IF NOT EXISTS mts_src
  WITH REPLICATION = {
   'class' : 'SimpleStrategy',
   'replication_factor' : 1
  };

CREATE KEYSPACE IF NOT EXISTS mts_meta
  WITH REPLICATION = {
   'class' : 'SimpleStrategy',
   'replication_factor' : 1
  };

CREATE KEYSPACE IF NOT EXISTS mts_bars
  WITH REPLICATION = {
   'class' : 'SimpleStrategy',
   'replication_factor' : 1
  };

CREATE TABLE mts_src.ticks (
    ticker_id int,
    ddate date,
    ts bigint,
    db_tsunx bigint,
    ask double,
    bid double,
    PRIMARY KEY ((ticker_id, ddate), ts, db_tsunx)
) WITH CLUSTERING ORDER BY (ts DESC, db_tsunx DESC);

CREATE TABLE mts_meta.trade_advisers_ticker (
    adviser_id int,
    ticker_id int,
    is_enabled int,
    func_name text,
    s_desc text,
    PRIMARY KEY (adviser_id, ticker_id, is_enabled, func_name)
) WITH CLUSTERING ORDER BY (ticker_id ASC, is_enabled ASC, func_name ASC);

CREATE TABLE mts_meta.trade_advisers_results (
    adviser_id int,
    ts bigint,
    main_way text,
    PRIMARY KEY (adviser_id, ts)
) WITH CLUSTERING ORDER BY (ts DESC);

CREATE TABLE mts_meta.bars_property_last_deeps (
    ticker_id int,
    bar_width_sec int,
    is_enabled int,
    deep_count int,
    PRIMARY KEY (ticker_id, bar_width_sec, is_enabled, deep_count)
) WITH CLUSTERING ORDER BY (bar_width_sec ASC, is_enabled ASC, deep_count ASC);

CREATE TABLE mts_meta.bars_property (
    ticker_id int,
    bar_width_sec int,
    is_enabled int,
    PRIMARY KEY (ticker_id, bar_width_sec, is_enabled)
) WITH CLUSTERING ORDER BY (bar_width_sec ASC, is_enabled ASC);

CREATE TABLE mts_meta.way_adviser_n_hours (
    ticker_id int,
    bar_width_sec int,
    ts_res bigint,
    adv_bars_in_part int,
    deep_sec int,
    p1_cnt int,
    p1_logco double,
    p1_size_bars int,
    p2_cnt int,
    p2_logco double,
    p2_size_bars int,
    p3_cnt int,
    p3_logco double,
    p3_size_bars int,
    way text,
    PRIMARY KEY ((ticker_id, bar_width_sec), ts_res)
) WITH CLUSTERING ORDER BY (ts_res DESC);

CREATE TABLE mts_meta.tickers (
    ticker_id int,
    ticker_code text,
    ticker_first text,
    ticker_seconds text,
    PRIMARY KEY ((ticker_id, ticker_code, ticker_first))
);

CREATE TABLE mts_meta.bar_price_distrib (
    ticker_id int,
    bar_width_sec int,
    price double,
    cnt int,
    PRIMARY KEY ((ticker_id, bar_width_sec), price)
) WITH CLUSTERING ORDER BY (price ASC);

CREATE TABLE mts_bars.bars (
    ticker_id int,
    ddate date,
    bar_width_sec int,
    ts_end bigint,
    btype text,
    c double,
    disp double,
    h double,
    h_body double,
    h_shad double,
    l double,
    log_co double,
    o double,
    ticks_cnt int,
    ts_begin bigint,
    PRIMARY KEY ((ticker_id, ddate, bar_width_sec), ts_end)
) WITH CLUSTERING ORDER BY (ts_end DESC);

CREATE TABLE mts_bars.bars_future (
    ticker_id int,
    bar_width_sec int,
    ts_end bigint,
    c double,
    ft_log_0017_cls_price double,
    ft_log_0017_res text,
    ft_log_0017_ts_end bigint,
    ft_log_0034_cls_price double,
    ft_log_0034_res text,
    ft_log_0034_ts_end bigint,
    ft_log_0051_cls_price double,
    ft_log_0051_res text,
    ft_log_0051_ts_end bigint,
    PRIMARY KEY ((ticker_id, bar_width_sec), ts_end)
) WITH CLUSTERING ORDER BY (ts_end DESC);

CREATE TABLE mts_bars.bars_test (
    ticker_id int,
    bar_width_sec int,
    ddate date,
    ts_end bigint,
    btype text,
    c double,
    disp double,
    h double,
    h_body double,
    h_shad double,
    l double,
    log_co double,
    o double,
    ticks_cnt int,
    ts_begin bigint,
    PRIMARY KEY ((ticker_id, bar_width_sec), ddate, ts_end)
) WITH CLUSTERING ORDER BY (ddate DESC, ts_end DESC);

CREATE TABLE mts_bars.trade_advisers_results_bars (
    adviser_id int,
    ts timestamp,
    ticker_id int,
    ts_end timestamp,
    bar_width_sec int,
    btype text,
    c double,
    ddate date,
    disp double,
    h double,
    h_body double,
    h_shad double,
    l double,
    o double,
    ticks_cnt int,
    ts_begin timestamp,
    PRIMARY KEY ((adviser_id, ts), ticker_id, ts_end)
) WITH CLUSTERING ORDER BY (ticker_id DESC, ts_end DESC);

CREATE TABLE mts_bars.lastbars (
    ticker_id int,
    bar_width_sec int,
    btype text,
    c double,
    disp double,
    h double,
    h_body double,
    h_shad double,
    l double,
    o double,
    ticks_cnt int,
    ts_begin bigint,
    ts_end bigint,
    PRIMARY KEY ((ticker_id, bar_width_sec))
);

CREATE TABLE mts_bars.pattern_search_results (
    ticker_id int,
    bar_width_sec int,
    patt_ts_end bigint,
    ft_log_0017_res_d int,
    ft_log_0017_res_n int,
    ft_log_0017_res_u int,
    ft_log_0034_res_d int,
    ft_log_0034_res_n int,
    ft_log_0034_res_u int,
    ft_log_0051_res_d int,
    ft_log_0051_res_n int,
    ft_log_0051_res_u int,
    ft_log_sum_d int,
    ft_log_sum_n int,
    ft_log_sum_u int,
    history_found_tsends list<bigint>,
    patt_bars_count int,
    patt_end_c double,
    patt_ts_begin bigint,
    PRIMARY KEY ((ticker_id, bar_width_sec), patt_ts_end)
) WITH CLUSTERING ORDER BY (patt_ts_end DESC);



















