.. |def_acceptor_sleep_decay| replace::        0.9 
.. |def_acceptor_sleep_incr| replace::         0.001 [seconds] 
.. |def_acceptor_sleep_max| replace::          0.050 [seconds] 
.. |def_auto_restart| replace::                on [bool] 
.. |def_ban_dups| replace::                    on [bool] 
.. |def_ban_lurker_age| replace::              60.000 [seconds] 
.. |def_ban_lurker_batch| replace::            1000 
.. |def_ban_lurker_sleep| replace::            0.010 [seconds] 
.. |def_between_bytes_timeout| replace::       60.000 [seconds] 
.. |def_busyobj_worker_cache| replace::        off [bool] 
.. |def_cc_command| replace::                  "exec gcc -std=gnu99 -g -O2 -Wall -Werror -Wno-error=unused-result -pthread -fpic -shared -Wl,-x -o %o %s" 
.. |def_cli_buffer| replace::                  8k [bytes] 
.. |def_cli_limit| replace::                   48k [bytes] 
.. |def_cli_timeout| replace::                 60.000 [seconds] 
.. |def_clock_skew| replace::                  10 [seconds] 
.. |def_connect_timeout| replace::             3.500 [seconds] 
.. |def_critbit_cooloff| replace::             180.000 [seconds] 
.. |def_debug| replace::                       none 
.. |def_default_grace| replace::               10.000 [seconds] 
.. |def_default_keep| replace::                0.000 [seconds] 
.. |def_default_ttl| replace::                 120.000 [seconds] 
.. |def_feature| replace::                     none 
.. |def_fetch_chunksize| replace::             16k [bytes] 
.. |def_fetch_maxchunksize| replace::          0.25G [bytes] 
.. |def_first_byte_timeout| replace::          60.000 [seconds] 
.. |def_group| replace::                       nogroup (65534) 
.. |def_group_cc| replace::                    <not set> 
.. |def_gzip_buffer| replace::                 32k [bytes] 
.. |def_gzip_level| replace::                  6 
.. |def_gzip_memlevel| replace::               8 
.. |def_http_gzip_support| replace::           on [bool] 
.. |def_http_max_hdr| replace::                64 [header lines] 
.. |def_http_range_support| replace::          on [bool] 
.. |def_http_req_hdr_len| replace::            8k [bytes] 
.. |def_http_req_size| replace::               32k [bytes] 
.. |def_http_resp_hdr_len| replace::           8k [bytes] 
.. |def_http_resp_size| replace::              32k [bytes] 
.. |def_idle_send_timeout| replace::           60.000 [seconds] 
.. |def_listen_address| replace::              listen_address 
.. |def_listen_depth| replace::                1024 [connections] 
.. |def_lru_interval| replace::                2.000 [seconds] 
.. |def_max_esi_depth| replace::               5 [levels] 
.. |def_max_restarts| replace::                4 [restarts] 
.. |def_max_retries| replace::                 4 [retries] 
.. |def_mse_bigalloc| replace::                1M [bytes] 
.. |def_mse_delay_writes| replace::            on [bool] 
.. |def_mse_membuf_size| replace::             4 [pages] 
.. |def_mse_minextfree| replace::              4k [bytes] 
.. |def_mse_nuke_limit| replace::              10 
.. |def_mse_pad_writes| replace::              on [bool] 
.. |def_mse_prune_factor| replace::            2 
.. |def_mse_prune_loop| replace::              10 
.. |def_mse_sendfile_min| replace::            0b [bytes] 
.. |def_nuke_limit| replace::                  50 [allocations] 
.. |def_pcre_match_limit| replace::            10000 
.. |def_pcre_match_limit_recursion| replace::  10000 
.. |def_ping_interval| replace::               3 [seconds] 
.. |def_pipe_timeout| replace::                60.000 [seconds] 
.. |def_pool_req| replace::                    10,100,10 
.. |def_pool_sess| replace::                   10,100,10 
.. |def_pool_vbc| replace::                    10,100,10 
.. |def_pool_vbo| replace::                    10,100,10 
.. |def_prefer_ipv6| replace::                 off [bool] 
.. |def_rush_exponent| replace::               3 [requests per request] 
.. |def_send_timeout| replace::                600.000 [seconds] 
.. |def_session_max| replace::                 100000 [sessions] 
.. |def_shm_reclen| replace::                  255b [bytes] 
.. |def_shortlived| replace::                  10.000 [seconds] 
.. |def_sigsegv_handler| replace::             off [bool] 
.. |def_syslog_cli_traffic| replace::          on [bool] 
.. |def_tcp_keepalive_intvl| replace::         75.000 [seconds] 
.. |def_tcp_keepalive_probes| replace::        9 [probes] 
.. |def_tcp_keepalive_time| replace::          7200.000 [seconds] 
.. |def_thread_pool_add_delay| replace::       0.000 [seconds] 
.. |def_thread_pool_destroy_delay| replace::   1.000 [seconds] 
.. |def_thread_pool_fail_delay| replace::      0.200 [seconds] 
.. |def_thread_pool_max| replace::             5000 [threads] 
.. |def_thread_pool_min| replace::             100 [threads] 
.. |def_thread_pool_stack| replace::           48k [bytes] 
.. |def_thread_pool_timeout| replace::         300.000 [seconds] 
.. |def_thread_pools| replace::                2 [pools] 
.. |def_thread_queue_limit| replace::          20 
.. |def_thread_stats_rate| replace::           10 [requests] 
.. |def_timeout_idle| replace::                5.000 [seconds] 
.. |def_timeout_linger| replace::              0.050 [seconds] 
.. |def_timeout_req| replace::                 2.000 [seconds] 
.. |def_user| replace::                        nobody (65534) 
.. |def_vcc_allow_inline_c| replace::          off [bool] 
.. |def_vcc_err_unref| replace::               on [bool] 
.. |def_vcc_unsafe_path| replace::             on [bool] 
.. |def_vcl_dir| replace::                     /etc/varnish 
.. |def_vmod_dir| replace::                    /usr/lib/varnish-plus/vmods 
.. |def_vsl_buffer| replace::                  4k [bytes] 
.. |def_vsl_mask| replace::                    -VCL_trace,-WorkThread,-Hash 
.. |def_vsl_reclen| replace::                  255b [bytes] 
.. |def_vsl_space| replace::                   80M [bytes] 
.. |def_vsm_space| replace::                   1M [bytes] 
.. |def_waiter| replace::                      epoll (possible values: epoll, poll) 
.. |def_workspace_backend| replace::           64k [bytes] 
.. |def_workspace_client| replace::            64k [bytes] 
.. |def_workspace_session| replace::           384b [bytes] 
.. |def_workspace_thread| replace::            2k [bytes] 
