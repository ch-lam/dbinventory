# Installation of PDB DBINVENTORY

Prerequisites :

Standard container (CDB) must be available.

```bash
# create new PDB for the dbInventory and dbMonitoring tools
# 
create_PDB.sh -m create -d <target_database> -p PDBD_DBINVENTORY -s DEV_ALL
```

Install APEX
```bash
# Connectected on the newly created PDB as SYS, and on the root dir apex installation
SQL> @apexins.sql SYSAUX SYSAUX TEMP /i/i26.1.0/
SQL> exit;

# re-connectected on the newly created PDB as SYS, and on the root dir apex installation
SQL> @apxchpwd.sql            # pwd : Apex-DBINVENTORY-001
SQL> exit;
```


```bash
# Connectected on the newly created PDB as SYS, and on the root dir of the dbInventory repository

SQL> cd setup/pdb_dbinventory

SQL> @001_create_db_artefacts.sql

SQL> @002_create_apex_artefacts.sql

SQL> exit;
```

Configure access to Openrouter for AI models

```sql

-- Connectected on the newly created PDB as SYS
-- Create Openrouter ACL Access for APEX applications

SQL> 

begin
   dbms_network_acl_admin.append_host_ace(
      host       => 'openrouter.ai',
      lower_port => 443,
      upper_port => 443,
      ace        => xs$ace_type(
         privilege_list => xs$name_list('connect'),
         principal_name => 'DBINVENTORY',
         principal_type => xs_acl.ptype_db
      )
   );
   dbms_network_acl_admin.append_host_ace(
      host       => 'openrouter.ai',
      lower_port => 443,
      upper_port => 443,
      ace        => xs$ace_type(
         privilege_list => xs$name_list('connect'),
         principal_name => 'APEX_PUBLIC_USER',
         principal_type => xs_acl.ptype_db
      )
   );
  -- mandatory for APEX "developer" mode testing and configuration, needs to be adapted if APEX version changes
   dbms_network_acl_admin.append_host_ace(
      host       => 'openrouter.ai',
      lower_port => 443,
      upper_port => 443,
      ace        => xs$ace_type(
         privilege_list => xs$name_list('connect'),
         principal_name => 'APEX_260100',
         principal_type => xs_acl.ptype_db
      )
   );
end;
/

SQL> exit;
```

