--
-- Install dbInventory artefacts (tablespace, schema, objects ... )
--

-- standard tablespace creation
create tablespace dbinventory_tbs;

-- standard user creation
create user dbinventory identified by "change_on_first_use"
   default tablespace dbinventory_tbs
   quota unlimited on dbinventory_tbs
   password expire;

-- grant the required privileges to the dbInventory user
grant
   create session,resource to dbinventory;