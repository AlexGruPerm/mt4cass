
CREATE KEYSPACE mts_bars WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}  AND durable_writes = true;

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
) WITH CLUSTERING ORDER BY (ts_end DESC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';

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
) WITH CLUSTERING ORDER BY (ts_end DESC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';

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
) WITH CLUSTERING ORDER BY (ddate DESC, ts_end DESC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';

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
) WITH CLUSTERING ORDER BY (ticker_id DESC, ts_end DESC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';

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
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';

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
) WITH CLUSTERING ORDER BY (patt_ts_end DESC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';

