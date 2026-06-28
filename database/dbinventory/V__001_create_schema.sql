-- Oracle Database Schema for DBInventory

-- ============================================================
-- mssql_backup
-- ============================================================
create table mssql_backup (
   hostname           varchar2(50 char) not null,
   database_name      varchar2(100 char) not null,
   backup_start_date  date not null,
   backup_finish_date date not null,
   backup_type        varchar2(20 char) not null,
   backup_size        number(19) not null
);

create index backup_type_idx on
   mssql_backup (
      backup_type
   );
create index backup_finish_date_idx on
   mssql_backup (
      backup_finish_date
   );
create index backup_start_date_idx on
   mssql_backup (
      backup_start_date
   );

-- ============================================================
-- mssql_backup_info_history
-- ============================================================
create table mssql_backup_info_history (
   scoring_result                  timestamp default on null systimestamp not null,
   environment                     varchar2(20 char) not null,
   cumulative_hours_between_backup number(10) not null
);

-- ============================================================
-- mssql_backup_stats
-- ============================================================
create table mssql_backup_stats (
   hostname                        varchar2(50 char) not null,
   database_name                   varchar2(100 char) not null,
   recovery_model                  varchar2(20 char) not null,
   backup_type                     varchar2(20 char) not null,
   cumulative_hours_between_backup number(10) not null,
   nbrebu                          number(10) not null
);

-- ============================================================
-- mssql_backup_summary
-- ============================================================
create table mssql_backup_summary (
   hostname             varchar2(50 char) not null,
   database_name        varchar2(100 char) not null,
   recovery_model       varchar2(100 char),
   backup_type          varchar2(20 char) not null,
   backup_start_date    date not null,
   previous_backup      date not null,
   hours_between_backup number(10) not null,
   environment          varchar2(20 char)
);

-- ============================================================
-- mssql_backup_temp
-- ============================================================
create table mssql_backup_temp (
   hostname           varchar2(50 char) not null,
   database_name      varchar2(100 char) not null,
   backup_start_date  date not null,
   backup_finish_date date not null,
   backup_type        varchar2(20 char) not null,
   backup_size        number(19) not null
);

-- ============================================================
-- mssql_databases
-- ============================================================
create table mssql_databases (
   hostname              varchar2(100 char),
   database_id           number(5),
   database_name         varchar2(100 char),
   database_state        varchar2(100 char),
   recovery_model        varchar2(100 char),
   compatibility_level   varchar2(100 char),
   collation             varchar2(100 char),
   last_backup_date      varchar2(100 char),
   last_backup_diff_date varchar2(100 char),
   last_backup_log_date  varchar2(100 char),
   create_date           varchar2(100 char),
   is_mirroring_enabled  number(6),
   owner                 varchar2(100 char),
   agtype                varchar2(50 char),
   agname                varchar2(50 char),
   env                   varchar2(10 char) not null
);

-- ============================================================
-- mssql_files
-- ============================================================
create table mssql_files (
   hostname       varchar2(100 char) not null,
   database_name  varchar2(100 char) not null,
   file_id        number(10) not null,
   type_desc      varchar2(20 char) not null,
   name           varchar2(100 char) not null,
   physical_name  varchar2(255 char) not null,
   size_mb        number(10) not null,
   growth_percent number(10) not null,
   growth_mb      number(10) not null,
   max_size       number(10) not null,
   env            varchar2(10 char) not null
);

-- ============================================================
-- mssql_hosts
-- ============================================================
create table mssql_hosts (
   hostname              varchar2(100 char),
   mssql_edition         varchar2(100 char),
   mssql_product_version varchar2(100 char),
   collation             varchar2(100 char),
   is_clustered          number(5),
   activenodename        varchar2(50 char) not null,
   clusternode1          varchar2(50 char),
   clusternode2          varchar2(50 char),
   parallel_threshold    number(10),
   max_dop               number(10),
   min_memory            number(10),
   max_memory            number(10),
   xp_cmdshell_enabled   number(10),
   num_cpus              number(6),
   memory_gb             number(6),
   os_type               varchar2(100 char),
   service_account       varchar2(100 char),
   env                   varchar2(10 char) not null,
   license_type          varchar2(50 char) not null,
   install_date          number(10) default 0 not null
);

-- ============================================================
-- mssql_logins
-- ============================================================
create table mssql_logins (
   instance_name           varchar2(40 char) not null,
   loginname               varchar2(100 char) not null,
   accountcreationdate     varchar2(30 char) not null,
   lasttimeaccountmodified varchar2(30 char) not null,
   passwordlastsettime     varchar2(30 char) not null,
   defaultdatabase         varchar2(100 char) not null,
   defaultlanguage         varchar2(50 char) not null,
   isdisabledchecked       varchar2(30 char) not null,
   ispolicychecked         varchar2(30 char) not null,
   isexpirationchecked     varchar2(30 char) not null,
   isexpired               varchar2(30 char) not null,
   daysuntilexpiration     varchar2(30 char),
   islocked                varchar2(30 char) not null,
   ismustchange            varchar2(30 char) not null,
   lockouttime             varchar2(30 char) not null,
   badpasswordcount        varchar2(30 char) not null,
   badpasswordtime         varchar2(30 char) not null,
   historylength           varchar2(30 char) not null,
   loginsid                varchar2(200 char) not null,
   logintype               varchar2(10 char) not null,
   hasserverrole           varchar2(100 char) not null
);

-- ============================================================
-- mssql_loginwoperm
-- ============================================================
create table mssql_loginwoperm (
   instance_name varchar2(50 char) not null,
   loginname     varchar2(150 char) not null,
   type_desc     varchar2(50 char) not null,
   is_disabled   number(1) not null,
   db_perms      varchar2(150 char) not null,
   srv_perms     varchar2(150 char) not null,
   modify_date   date not null,
   scandate      date not null
);

-- ============================================================
-- mssql_security_auditlevel
-- ============================================================
create table mssql_security_auditlevel (
   servername       varchar2(50 char) not null,
   auditlevel       varchar2(50 char) not null,
   compliance_score number(2) default 0 not null,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_auditlevel_exception
-- ============================================================
create table mssql_security_auditlevel_exception (
   servername varchar2(50 char) not null,
   auditlevel varchar2(50 char) not null,
   comments   varchar2(200 char) default '0' not null,
   date_value timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_configoptions
-- ============================================================
create table mssql_security_configoptions (
   servername       varchar2(50 char) not null,
   name             varchar2(200 char) not null,
   config_value     number(10) not null,
   run_value        number(10) not null,
   compliance_score number(2) default 0 not null,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_configoptions_exception
-- ============================================================
create table mssql_security_configoptions_exception (
   servername   varchar2(50 char) not null,
   name         varchar2(200 char) not null,
   config_value number(10) not null,
   run_value    number(10) not null,
   comments     varchar2(200 char) default '0' not null,
   date_value   timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_dbproperties
-- ============================================================
create table mssql_security_dbproperties (
   servername        varchar2(50 char) not null,
   db_name           varchar2(50 char) not null,
   is_auto_close_on  number(10) not null,
   is_trustworthy_on number(10) not null,
   compliance_score  number(2) default 0 not null,
   date_value        timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_dbproperties_exception
-- ============================================================
create table mssql_security_dbproperties_exception (
   servername        varchar2(50 char) not null,
   db_name           varchar2(50 char) not null,
   is_auto_close_on  number(10) not null,
   is_trustworthy_on number(10) not null,
   comments          varchar2(200 char) default '0' not null,
   date_value        timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_encryption
-- ============================================================
create table mssql_security_encryption (
   servername       varchar2(50 char) not null,
   db_name          varchar2(50 char) not null,
   key_type         varchar2(50 char) not null,
   key_name         varchar2(100 char) not null,
   algorithm_desc   varchar2(50 char) not null,
   compliance_score number(2) default 0 not null,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_encryption_exception
-- ============================================================
create table mssql_security_encryption_exception (
   servername     varchar2(50 char) not null,
   db_name        varchar2(50 char) not null,
   key_type       varchar2(50 char) not null,
   key_name       varchar2(100 char) not null,
   algorithm_desc varchar2(50 char) not null,
   comments       varchar2(200 char) default '0' not null,
   date_value     timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_groups
-- ============================================================
create table mssql_security_groups (
   servername       varchar2(50 char) not null,
   localgroupname   varchar2(50 char) not null,
   permission_name  varchar2(100 char) not null,
   state_desc       varchar2(50 char) not null,
   compliance_score number(2) default 0 not null,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_groups_exception
-- ============================================================
create table mssql_security_groups_exception (
   servername      varchar2(50 char) not null,
   localgroupname  varchar2(50 char) not null,
   permission_name varchar2(100 char) not null,
   state_desc      varchar2(50 char) not null,
   comments        varchar2(200 char) not null,
   date_value      timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_guestconnect
-- ============================================================
create table mssql_security_guestconnect (
   servername       varchar2(50 char) not null,
   db_name          varchar2(50 char) not null,
   permission_name  varchar2(50 char) not null,
   state_desc       varchar2(50 char) not null,
   compliance_score number(2) default 0 not null,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_guestconnect_exception
-- ============================================================
create table mssql_security_guestconnect_exception (
   servername      varchar2(50 char) not null,
   db_name         varchar2(50 char) not null,
   permission_name varchar2(50 char) not null,
   state_desc      varchar2(50 char) not null,
   comments        varchar2(200 char) default '0' not null,
   date_value      timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_history
-- ============================================================
create table mssql_security_history (
   servername             varchar2(50 char) not null,
   environment            varchar2(20 char) not null,
   compliance_score_total number(2),
   date_value             timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_logins
-- Note : ON UPDATE current_timestamp() non supporte en Oracle (supprime)
-- ============================================================
create table mssql_security_logins (
   servername            varchar2(50 char) not null,
   login_name            varchar2(100 char) not null,
   principal_id          varchar2(100 char) not null,
   is_sysadmin           number(2) not null,
   is_policy_checked     number(2) not null,
   access_method         varchar2(50 char) not null,
   is_expiration_checked number(2) not null,
   is_disabled           number(2) not null,
   create_date           date not null,
   compliance_score      number(2) default 0 not null,
   date_value            timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_logins_exception
-- Note : ON UPDATE current_timestamp() non supporte en Oracle (supprime)
-- ============================================================
create table mssql_security_logins_exception (
   servername varchar2(50 char) not null,
   login_name varchar2(100 char) not null,
   comments   varchar2(200 char) default '0' not null,
   date_value timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_orphanedusers
-- ============================================================
create table mssql_security_orphanedusers (
   servername       varchar2(50 char) not null,
   db_name          varchar2(50 char) not null,
   user_name        varchar2(100 char) not null,
   compliance_score number(2) default 0 not null,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_orphanedusers_exception
-- ============================================================
create table mssql_security_orphanedusers_exception (
   servername varchar2(50 char) not null,
   db_name    varchar2(50 char) not null,
   user_name  varchar2(100 char) not null,
   comments   varchar2(200 char) not null,
   date_value timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_publicpermission
-- ============================================================
create table mssql_security_publicpermission (
   servername       varchar2(50 char) not null,
   db_name          varchar2(50 char) not null,
   username         varchar2(100 char) not null,
   permission_name  varchar2(100 char) not null,
   state_desc       varchar2(50 char) not null,
   compliance_score number(2) default 0 not null,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_publicpermission_exception
-- ============================================================
create table mssql_security_publicpermission_exception (
   servername      varchar2(50 char) not null,
   db_name         varchar2(50 char) not null,
   username        varchar2(100 char) not null,
   permission_name varchar2(100 char) not null,
   state_desc      varchar2(50 char) not null,
   comments        varchar2(200 char) default '0' not null,
   date_value      timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_registryinfo
-- ============================================================
create table mssql_security_registryinfo (
   servername       varchar2(50 char) not null,
   name             varchar2(100 char) not null,
   value            number(10) not null,
   compliance_score number(2) default 0 not null,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_registryinfo_exception
-- ============================================================
create table mssql_security_registryinfo_exception (
   servername varchar2(50 char) not null,
   name       varchar2(100 char) not null,
   comments   varchar2(200 char) default '0' not null,
   date_value timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_scoring
-- ============================================================
create table mssql_security_scoring (
   servername             varchar2(50 char) not null,
   environment            varchar2(20 char),
   configoptions          number(2) default 0 not null,
   dbproperties           number(2) default 0 not null,
   auditlevel             number(2) default 0 not null,
   encryption             number(10) default 0 not null,
   groups                 number(10) default 0 not null,
   guestconnect           number(10) default 0 not null,
   logins                 number(10) default 0 not null,
   orphanedusers          number(10) default 0 not null,
   publicpermission       number(10) default 0 not null,
   registryinfo           number(10) default 0 not null,
   sqlserveraudit         number(10) default 0 not null,
   compliance_score_total number(2) default 0 not null,
   exception_detected     number(2) default 0 not null,
   legacy_server          number(2) default 0 not null,
   date_value             timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_sqlserveraudit
-- ============================================================
create table mssql_security_sqlserveraudit (
   servername                varchar2(50 char) not null,
   auditname                 varchar2(50 char) not null,
   auditenabled              number(2) not null,
   writelocation             varchar2(50 char) not null,
   auditspecificationname    varchar2(100 char) not null,
   auditspecificationenabled number(2) not null,
   auditactionname           varchar2(100 char) not null,
   audited_result            varchar2(30 char) not null,
   compliance_score          number(2) default 0 not null,
   date_value                timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_security_sqlserveraudit_exception
-- ============================================================
create table mssql_security_sqlserveraudit_exception (
   servername      varchar2(50 char) not null,
   auditactionname varchar2(100 char) not null,
   comments        varchar2(200 char) default '0' not null,
   date_value      timestamp default on null systimestamp not null
);

-- ============================================================
-- mssql_users
-- ============================================================
create table mssql_users (
   instance_name     varchar2(50 char) not null,
   database_name     varchar2(100 char) not null,
   name              varchar2(100 char) not null,
   groupname         varchar2(100 char) not null,
   loginname         varchar2(100 char) not null,
   defaultdbname     varchar2(100 char) not null,
   defaultschemaname varchar2(100 char) not null,
   principalid       number(10) not null,
   sid               varchar2(100 char) not null
);

-- ============================================================
-- mssql_validatelogin
-- ============================================================
create table mssql_validatelogin (
   servername  varchar2(150 char) not null,
   sid         varchar2(200 char) not null,
   login       varchar2(150 char) not null,
   is_disabled number(1) not null,
   modify_date date not null,
   scandate    date not null
);

-- ============================================================
-- oracle_audit_logon
-- ============================================================
create table oracle_audit_logon (
   db_name        varchar2(50 char) not null,
   logon_time     varchar2(100 char),
   db_username    varchar2(100 char) not null,
   os_username    varchar2(100 char) not null,
   host_client    varchar2(100 char) not null,
   client_name    varchar2(200 char) not null,
   expected_logon number(2) default 0 not null
);

-- ============================================================
-- oracle_audit_logon_history
-- ============================================================
create table oracle_audit_logon_history (
   db_name        varchar2(50 char) not null,
   logon_time     varchar2(100 char),
   db_username    varchar2(100 char) not null,
   os_username    varchar2(100 char) not null,
   host_client    varchar2(100 char) not null,
   client_name    varchar2(200 char) not null,
   expected_logon number(2) default 0 not null,
   date_value     timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_backup
-- ============================================================
create table oracle_backup (
   db_name      varchar2(50 char) not null,
   environment  varchar2(20 char),
   backup_type  varchar2(50 char) not null,
   status       varchar2(50 char) not null,
   start_time   timestamp(6) not null,
   end_time     timestamp(6) not null,
   elapsed_time varchar2(50 char) not null
);

-- ============================================================
-- oracle_backup_archivelog_gap
-- ============================================================
create table oracle_backup_archivelog_gap (
   db_name              varchar2(50 char) not null,
   environment          varchar2(20 char) not null,
   start_time           timestamp(6) not null,
   previous_time        timestamp(6) not null,
   hours_between_backup number(10) not null
);

-- ============================================================
-- oracle_backup_history
-- ============================================================
create table oracle_backup_history (
   scoring_result                  timestamp default on null systimestamp not null,
   environment                     varchar2(20 char) not null,
   count_backup_failed             varchar2(50 char) not null,
   cumulative_hours_between_backup number(10) not null
);

-- ============================================================
-- oracle_backup_summary
-- ============================================================
create table oracle_backup_summary (
   db_name                         varchar2(50 char) not null,
   environment                     varchar2(20 char) not null,
   failed_backup_detected          number(10) default 0 not null,
   avg_archive_elapsed             number(10) not null,
   avg_archive_sla                 number(10) not null,
   backup_archive_sla_result       number(10) default 0 not null,
   avg_inc_elapsed                 number(10) not null,
   avg_inc_sla                     number(10) not null,
   backup_inc_sla_result           number(10) default 0 not null,
   cumulative_hours_between_backup number(10) not null
);

-- ============================================================
-- oracle_client_version
-- ============================================================
create table oracle_client_version (
   db_name         varchar2(50 char) not null,
   db_version      varchar2(50 char) not null,
   environment     varchar2(50 char) not null,
   pdb_name        varchar2(50 char) not null,
   client_version  varchar2(50 char) not null,
   client_driver   varchar2(100 char),
   username        varchar2(50 char) not null,
   client_host     varchar2(50 char) not null,
   service_name    varchar2(50 char) not null,
   failover_type   varchar2(50 char) not null,
   failover_method varchar2(50 char) not null,
   check_client    number(10) default 1
);

-- ============================================================
-- oracle_metrics_cpu_memory
-- ============================================================
create table oracle_metrics_cpu_memory (
   pdb_name            varchar2(50 char) not null,
   cpu_time_minutes    number(10) not null,
   avg_sga_mb          number(10) not null,
   avg_pga_mb          number(10) not null,
   avg_buffer_cache_mb number(10) not null,
   avg_shared_pool_mb  number(10) not null,
   environment         varchar2(20 char),
   date_value          timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_metrics_cpu_memory_history
-- ============================================================
create table oracle_metrics_cpu_memory_history (
   pdb_name            varchar2(50 char) not null,
   cpu_time_minutes    number(10) not null,
   avg_sga_mb          number(10) not null,
   avg_pga_mb          number(10) not null,
   avg_buffer_cache_mb number(10) not null,
   avg_shared_pool_mb  number(10) not null,
   environment         varchar2(20 char),
   date_value          timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_metrics_cpu_service
-- ============================================================
create table oracle_metrics_cpu_service (
   pdb_name           varchar2(50 char) not null,
   service_name       varchar2(100 char) not null,
   dbcpu_time_minutes number(10) not null,
   date_value         timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_metrics_cpu_service_history
-- Note : decimal(50,3) -> NUMBER(38,3) [precision max Oracle = 38]
-- ============================================================
create table oracle_metrics_cpu_service_history (
   pdb_name           varchar2(50 char) not null,
   service_name       varchar2(100 char) not null,
   dbcpu_time_minutes number(10) not null,
   percentage_usage   number(38,3) not null,
   date_value         varchar2(8 char) not null
);

-- ============================================================
-- oracle_size_usage
-- ============================================================
create table oracle_size_usage (
   db_name         varchar2(50 char) not null,
   pdb_name        varchar2(50 char) not null,
   tablespace_name varchar2(200 char) not null,
   size_mb         number(10) not null,
   environment     varchar2(20 char),
   sum_segment_mb  number(10) default 0,
   date_value      timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_size_usage_history
-- ============================================================
create table oracle_size_usage_history (
   db_name         varchar2(50 char) not null,
   pdb_name        varchar2(50 char) not null,
   tablespace_name varchar2(200 char) not null,
   size_mb         number(10) not null,
   environment     varchar2(20 char),
   sum_segment_mb  number(10) default 0,
   date_value      timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_size_usage_seg
-- ============================================================
create table oracle_size_usage_seg (
   db_name         varchar2(50 char) not null,
   pdb_name        varchar2(50 char) not null,
   tablespace_name varchar2(200 char) not null,
   sum_segment_mb  number(10) not null,
   date_value      timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_database_capacity_planning_exacc_usage
-- ============================================================
create table oracle_database_capacity_planning_exacc_usage (
   price         number(10),
   cluster_name  varchar2(30 char) not null,
   date_of_month varchar2(8 char)
);

-- ============================================================
-- oracle_database_capacity_planning_history_app_link
-- Note : DEFAULT '' retire (chaine vide = NULL en Oracle)
-- ============================================================
create table oracle_database_capacity_planning_history_app_link (
   pdb_name         varchar2(50 char) not null,
   env              varchar2(8 char) not null,
   application_name varchar2(30 char) not null,
   app_code         varchar2(30 char) not null
);

-- ============================================================
-- oracle_database_capacity_planning_history_prebuilt
-- Notes : decimal(50,3) -> NUMBER(38,3) [precision max Oracle = 38]
--         float -> BINARY_FLOAT
--         DEFAULT '' retire (chaine vide = NULL en Oracle)
-- ============================================================
create table oracle_database_capacity_planning_history_prebuilt (
   pdb_name                      varchar2(50 char) not null,
   env                           varchar2(8 char) not null,
   application_name              varchar2(30 char) not null,
   cluster_name                  varchar2(30 char) not null,
   size_gb                       number(10),
   cpu_consume_per_month_per_pdb number(10),
   cpu_minutes_price             binary_float,
   global_percentage_consumption number(38,3),
   env_percentage_consumption    number(38,3),
   date_of_month                 varchar2(8 char),
   cost_total                    binary_float not null,
   exacc_cost_usage              binary_float not null,
   exacc_ocpu_usage              binary_float not null,
   zdlra_cost_usage              binary_float not null
);

-- ============================================================
-- oracle_database_capacity_planning_summary
-- ============================================================
create table oracle_database_capacity_planning_summary (
   db_name             varchar2(50 char) not null,
   pdb_name            varchar2(50 char) not null,
   environment         varchar2(20 char) not null,
   size_mb             number(10) not null,
   cpu_time_minutes    number(10) default 0 not null,
   avg_sga_mb          number(10) default 0 not null,
   avg_pga_mb          number(10) default 0 not null,
   avg_buffer_cache_mb number(10) default 0 not null,
   avg_shared_pool_mb  number(10) default 0 not null,
   zdlra_cost_usage    binary_float default 0 not null,
   exacc_ocpu_usage    binary_float default 0 not null,
   exacc_cost_usage    binary_float default 0 not null,
   cost_total          binary_float default 0 not null,
   date_value          timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_databases
-- ============================================================
create table oracle_databases (
   environment      varchar2(20 char) not null,
   license_type     varchar2(50 char) not null,
   hostname         varchar2(100 char) not null,
   instance_name    varchar2(50 char) not null,
   db_version       varchar2(50 char) not null,
   db_name          varchar2(50 char) not null,
   db_log_mode      varchar2(50 char) not null,
   db_role          varchar2(50 char) not null,
   db_unique_name   varchar2(50 char),
   db_charset       varchar2(50 char) not null,
   db_edition       varchar2(50 char) not null,
   rac_state        varchar2(50 char) not null,
   sga              varchar2(50 char),
   pga              varchar2(50 char),
   asm_free         varchar2(50 char),
   asm_total        varchar2(50 char),
   easy_connect_tns varchar2(100 char),
   database_type    varchar2(50 char) not null,
   count_pdb        number(10) default 0
);

-- ============================================================
-- oracle_dataguard
-- ============================================================
create table oracle_dataguard (
   primary_db            varchar2(100 char) not null,
   standby_db            varchar2(100 char) not null,
   pdb_list_impacted     varchar2(2000 char),
   service_list_impacted varchar2(2000 char),
   protection_mode       varchar2(100 char)
);

-- ============================================================
-- oracle_hosts
-- ============================================================
create table oracle_hosts (
   environment  varchar2(20 char) not null,
   license_type varchar2(50 char) not null,
   hostname     varchar2(100 char) not null,
   num_cpus     number(6) not null,
   memory_gb    number(6) not null,
   os_type      varchar2(100 char) not null
);

-- ============================================================
-- oracle_jdbc_tns
-- ============================================================
create table oracle_jdbc_tns (
   service_name     varchar2(100 char) not null,
   easy_connect_tns varchar2(100 char),
   db_name          varchar2(50 char) not null,
   tcp_port         number(5),
   primary_hst      varchar2(50 char),
   standby_hst      varchar2(50 char)
);

-- ============================================================
-- oracle_lms
-- ============================================================
create table oracle_lms (
   grouping_id      number(1),                     -- 0=détail par PDB, 1=agrégé toutes PDBs
   con_id           number(5),                     -- PDB container ID (DBA_FEATURE_USAGE_STATISTICS)
   db_pdb_name      varchar2(50 char) not null,
   product_name     varchar2(150 char) not null,
   usage_detected   varchar2(100 char) not null,
   last_sample_date varchar2(20 char),             -- format YYYYMMDD produit par oracle_lms.sql
   first_usage_date varchar2(100 char),            -- peut valoir 'Never'
   last_usage_date  varchar2(100 char),            -- peut valoir 'Never'
   db_name          varchar2(50 char) not null,
   hostname         varchar2(50 char) not null
);

-- ============================================================
-- oracle_lms_reference
-- ============================================================
create table oracle_lms_reference (
   product_name varchar2(150 char) not null,
   num_core     number(6) not null,
   license_type varchar2(50 char) not null,
   constraint pk_oracle_lms_reference primary key ( product_name )
);

-- ============================================================
-- oracle_pdbs
-- ============================================================
create table oracle_pdbs (
   hostname      varchar2(100 char) not null,
   instance_name varchar2(50 char) not null,
   pdb_name      varchar2(50 char) not null,
   pdb_state     varchar2(50 char) not null
);

-- ============================================================
-- oracle_psu
-- ============================================================
create table oracle_psu (
   db_name     varchar2(50 char) not null,
   db_version  varchar2(50 char) not null,
   psu_applied varchar2(200 char) not null
);

-- ============================================================
-- oracle_sec_admin_high_privs
-- ============================================================
create table oracle_sec_admin_high_privs (
   db_name          varchar2(50 char) not null,
   username         varchar2(50 char) not null,
   compliance_score number(2) default 0,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_admin_high_privs_exception
-- ============================================================
create table oracle_security_admin_high_privs_exception (
   db_name    varchar2(50 char) not null,
   username   varchar2(50 char) not null,
   comments   varchar2(100 char) not null,
   date_value timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_audit_enable
-- ============================================================
create table oracle_security_audit_enable (
   db_name          varchar2(50 char) not null,
   pdb_name         varchar2(50 char) not null,
   audit_parameter  varchar2(50 char) not null,
   audit_activated  number(2),
   compliance_score number(2) default 0,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_sec_default_profile
-- ============================================================
create table oracle_sec_default_profile (
   db_name          varchar2(50 char) not null,
   pdb_name         varchar2(50 char) not null,
   username         varchar2(50 char) not null,
   profile          varchar2(50 char) not null,
   oracle_managed   varchar2(50 char) not null,
   compliance_score number(2) default 0,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_default_profile_exception
-- ============================================================
create table oracle_security_default_profile_exception (
   db_name    varchar2(50 char) not null,
   pdb_name   varchar2(50 char) not null,
   username   varchar2(50 char) not null,
   profile    varchar2(50 char) not null,
   comments   varchar2(100 char) not null,
   date_value timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_sec_default_user_pwd
-- ============================================================
create table oracle_sec_default_user_pwd (
   db_name          varchar2(50 char) not null,
   pdb_name         varchar2(50 char) not null,
   username         varchar2(50 char) not null,
   compliance_score number(2) default 0,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_sec_high_role_privs
-- ============================================================
create table oracle_sec_high_role_privs (
   db_name          varchar2(50 char) not null,
   pdb_name         varchar2(50 char) not null,
   username         varchar2(50 char) not null,
   privilege        varchar2(100 char) not null,
   compliance_score number(2) default 0,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_high_role_privs_exception
-- ============================================================
create table oracle_security_high_role_privs_exception (
   db_name    varchar2(50 char) not null,
   pdb_name   varchar2(50 char) not null,
   username   varchar2(50 char) not null,
   privilege  varchar2(100 char) not null,
   comments   varchar2(100 char) not null,
   date_value timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_high_sys_privs
-- ============================================================
create table oracle_security_high_sys_privs (
   db_name          varchar2(50 char) not null,
   pdb_name         varchar2(50 char) not null,
   username         varchar2(50 char) not null,
   privilege        varchar2(100 char) not null,
   compliance_score number(2) default 0,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_high_sys_privs_exception
-- ============================================================
create table oracle_security_high_sys_privs_exception (
   db_name    varchar2(50 char) not null,
   pdb_name   varchar2(50 char) not null,
   username   varchar2(50 char) not null,
   privilege  varchar2(100 char) not null,
   comments   varchar2(100 char) not null,
   date_value timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_high_tab_privs
-- ============================================================
create table oracle_security_high_tab_privs (
   db_name          varchar2(50 char) not null,
   pdb_name         varchar2(50 char) not null,
   username         varchar2(50 char) not null,
   privilege        varchar2(100 char) not null,
   compliance_score number(2) default 0,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_high_tab_privs_exception
-- ============================================================
create table oracle_security_high_tab_privs_exception (
   db_name    varchar2(50 char) not null,
   pdb_name   varchar2(50 char) not null,
   username   varchar2(50 char) not null,
   privilege  varchar2(100 char) not null,
   comments   varchar2(100 char) not null,
   date_value timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_history
-- ============================================================
create table oracle_security_history (
   db_name                varchar2(50 char) not null,
   environment            varchar2(20 char) not null,
   compliance_score_total number(2),
   date_value             timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_sec_network_encryption
-- ============================================================
create table oracle_sec_network_encryption (
   db_name           varchar2(50 char) not null,
   sqlnet_encryption varchar2(200 char) not null,
   compliance_score  number(2) default 0,
   date_value        timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_parameter
-- ============================================================
create table oracle_security_parameter (
   db_name          varchar2(50 char) not null,
   parameter_value  varchar2(50 char),
   parameter_name   varchar2(50 char) not null,
   compliance_score number(2) default 0,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_parameter_exception
-- ============================================================
create table oracle_security_parameter_exception (
   db_name         varchar2(50 char) not null,
   parameter_value varchar2(50 char),
   parameter_name  varchar2(50 char) not null,
   comments        varchar2(100 char) not null,
   date_value      timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_profile
-- ============================================================
create table oracle_security_profile (
   db_name          varchar2(50 char) not null,
   pdb_name         varchar2(50 char) not null,
   profile          varchar2(50 char) not null,
   resource_name    varchar2(100 char) not null,
   limit_value      varchar2(100 char),
   compliance_score number(2) default 0,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_profile_exception
-- ============================================================
create table oracle_security_profile_exception (
   db_name       varchar2(50 char) not null,
   pdb_name      varchar2(50 char) not null,
   profile       varchar2(50 char) not null,
   resource_name varchar2(100 char) not null,
   limit_value   varchar2(100 char) not null,
   comments      varchar2(100 char) not null,
   date_value    timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_scoring
-- ============================================================
create table oracle_security_scoring (
   db_name                    varchar2(50 char) not null,
   environment                varchar2(20 char),
   admin_high_privs_score     number(2) default 0,
   audit_enable_score         number(2) default 0,
   default_profile_score      number(2) default 0,
   default_user_pwd_score     number(2) default 0,
   high_role_privs_score      number(2) default 0,
   high_sys_privs_score       number(2) default 0,
   high_tab_privs_score       number(2) default 0,
   security_parameter_score   number(2) default 0,
   security_profile_score     number(2) default 0,
   encrypted_tablespace_score number(2) default 0,
   network_encryption_score   number(2) default 0,
   compliance_score_total     number(2) default 0,
   date_value                 timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_security_tablespace
-- ============================================================
create table oracle_security_tablespace (
   db_name          varchar2(50 char) not null,
   pdb_name         varchar2(50 char) not null,
   tablespace_name  varchar2(100 char) not null,
   encrypted        varchar2(100 char) not null,
   license_type     varchar2(50 char),
   compliance_score number(2) default 0,
   date_value       timestamp default on null systimestamp not null
);

-- ============================================================
-- oracle_sec_usermig_tbl_exist
-- SYS.USER$MIG : residus de migration avec hash legacy 10G (DES).
-- ============================================================
create table oracle_sec_usermig_tbl_exist (
   db_name    varchar2(50 char) not null,
   pdb_name   varchar2(50 char) not null,
   owner      varchar2(30 char) not null,
   table_name varchar2(30 char) not null
);

-- ============================================================
-- oracle_services
-- ============================================================
create table oracle_services (
   hostname      varchar2(100 char) not null,
   instance_name varchar2(50 char) not null,
   pdb_name      varchar2(50 char) not null,
   service_name  varchar2(100 char) not null
);

-- ============================================================
-- oracle_users
-- ============================================================
create table oracle_users (
   hostname       varchar2(100 char) not null,
   instance_name  varchar2(50 char) not null,
   pdb_name       varchar2(50 char) not null,
   username       varchar2(50 char) not null,
   account_status varchar2(100 char) not null,
   db_name        varchar2(50 char)
);

-- ============================================================
-- product_support
-- ============================================================
create table product_support (
   type                varchar2(15 char) not null,
   version             varchar2(100 char) not null,
   commercial_name     varchar2(100 char) not null,
   end_of_support_date date not null,
   constraint pk_product_support primary key ( type,
                                               version )
);


-- ============================================================
-- mssql_collect_list
-- ============================================================
create table mssql_collect_list (
   collect_name varchar2(30 char) not null,
   hostname     varchar2(150 char) not null,
   port         number(5) default 1433 not null,
   environment  varchar2(10 char) not null,
   license_type varchar2(50 char) not null,
   active       number(1) default 1 not null,
   constraint pk_mssql_collect_list primary key ( collect_name )
);


-- ============================================================
-- oracle_collect_list
-- ============================================================
create table oracle_collect_list (
   collect_name     varchar2(30 char) not null,
   easy_connect_tns varchar2(150 char) not null,
   environment      varchar2(10 char) not null,
   license_type     varchar2(10 char) not null,
   active           number(1) default 1 not null,
   constraint pk_oracle_collect_list primary key ( collect_name )
);

-- ============================================================
-- scoring_activity_list
-- ============================================================
create table scoring_activity_list (
   scoring_type             varchar2(30 char) not null,
   last_scoring_date        timestamp default current_timestamp not null,
   last_scoring_value       number(3) default 0 not null,
   scoring_card_class       varchar2(100 char) not null,
   scoring_status           varchar2(10 char) not null,
   status_color             varchar2(100 char),
   scoring_label            varchar2(256 char),
   details_apex_page_number number,
   scoring_order            number(2),
   constraint pk_scoring_activity_list primary key ( scoring_type )
);