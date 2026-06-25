-- 
-- Generate initial data for the DB Inventory database.
--
drop table scoring_activity_list;
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

-- Remove when all the parameters are settable in application :

insert into scoring_activity_list (
   scoring_type,
   last_scoring_date,
   last_scoring_value,
   scoring_card_class,
   scoring_status,
   status_color,
   scoring_label,
   details_apex_page_number,
   scoring_order
) values ( 'Oracle Compliance',
           current_timestamp,
           100,
           'u-color-4-border',
           'OK',
           'u-color-4',
           'Compliance is 100%, all of the tests, checks and scoring passed.',
           2,
           1 );

insert into scoring_activity_list (
   scoring_type,
   last_scoring_date,
   last_scoring_value,
   scoring_card_class,
   scoring_status,
   status_color,
   scoring_label,
   details_apex_page_number,
   scoring_order
) values ( 'Oracle Licensing',
           current_timestamp,
           85,
           'u-color-7-border',
           'Warning',
           'u-color-7',
           'Compliance is 85%, some configuration items need improvement.',
           2,
           2 );

insert into scoring_activity_list (
   scoring_type,
   last_scoring_date,
   last_scoring_value,
   scoring_card_class,
   scoring_status,
   status_color,
   scoring_label,
   details_apex_page_number,
   scoring_order
) values ( 'MSSQL Compliance',
           current_timestamp,
           80,
           'u-color-7-border',
           'Warning',
           'u-color-7',
           'Compliance is 80%, some configuration items need improvement.',
           3,
           3 );

insert into scoring_activity_list (
   scoring_type,
   last_scoring_date,
   last_scoring_value,
   scoring_card_class,
   scoring_status,
   status_color,
   scoring_label,
   details_apex_page_number,
   scoring_order
) values ( 'MSSQL Licensing',
           current_timestamp,
           30,
           'u-color-9-border',
           'Warning',
           'u-color-9',
           'Compliance is 30%, this is critical, some configuration items need critical review.',
           3,
           4 );

insert into scoring_activity_list (
   scoring_type,
   last_scoring_date,
   last_scoring_value,
   scoring_card_class,
   scoring_status,
   status_color,
   scoring_label,
   details_apex_page_number,
   scoring_order
) values ( 'Postgres Compliance',
           current_timestamp,
           100,
           'u-color-4-border',
           'OK',
           'u-color-4',
           'Compliance is 100%, all of the tests, checks and scoring passed.',
           4,
           5 );

insert into scoring_activity_list (
   scoring_type,
   last_scoring_date,
   last_scoring_value,
   scoring_card_class,
   scoring_status,
   status_color,
   scoring_label,
   details_apex_page_number,
   scoring_order
) values ( 'MySQL Compliance',
           current_timestamp,
           80,
           'u-color-7-border',
           'Warning',
           'u-color-7',
           'Compliance is 80%, some configuration items need improvement.',
           5,
           7 );

insert into scoring_activity_list (
   scoring_type,
   last_scoring_date,
   last_scoring_value,
   scoring_card_class,
   scoring_status,
   status_color,
   scoring_label,
   details_apex_page_number,
   scoring_order
) values ( 'MongoDB Compliance',
           current_timestamp,
           80,
           'u-color-7-border',
           'Warning',
           'u-color-7',
           'Compliance is 80%, some configuration items need improvement.',
           6,
           9 );

insert into scoring_activity_list (
   scoring_type,
   last_scoring_date,
   last_scoring_value,
   scoring_card_class,
   scoring_status,
   status_color,
   scoring_label,
   details_apex_page_number,
   scoring_order
) values ( 'MongoDB Licensing',
           current_timestamp,
           30,
           'u-color-9-border',
           'Warning',
           'u-color-9',
           'Compliance is 30%, this is critical, some configuration items need critical review.',
           6,
           10 );

commit;