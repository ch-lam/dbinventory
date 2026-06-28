--
-- Initial creation of the APEX artefacts for dbInventory.
--

-- create DBINVENTORY Apex Workspace
begin
    -- Grant all the needed privileges for an APEX workspace to DBINVENTORY user
   for prv in (
      select privilege
        from sys.dba_sys_privs
       where grantee = 'APEX_GRANTS_FOR_NEW_USERS_ROLE'
   ) loop
      execute immediate 'grant '
                        || prv.privilege
                        || ' to DBINVENTORY';
   end loop;
   apex_instance_admin.add_workspace(
      p_workspace      => 'DBINVENTORY',
      p_primary_schema => 'DBINVENTORY'
   );
   apex_util.set_workspace(p_workspace => 'DBINVENTORY');
   apex_util.create_user(
      p_user_name                    => 'DBINVENTORY',
      p_web_password                 => 'oracle',
      p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
      p_email_address                => 'dbInventory@example.com',
      p_default_schema               => 'DBINVENTORY',
      p_change_password_on_first_use => 'N'
   );
end;
/