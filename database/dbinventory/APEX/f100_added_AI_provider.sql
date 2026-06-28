prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2026.03.30'
,p_release=>'26.1.0'
,p_default_workspace_id=>1499207224227107
,p_default_application_id=>100
,p_default_id_offset=>0
,p_default_owner=>'DBINVENTORY'
);
end;
/
 
prompt APPLICATION 100 - Databases Inventory
--
-- Application Export:
--   Application:     100
--   Name:            Databases Inventory
--   Date and Time:   22:13 Sunday June 28, 2026
--   Exported By:     DBINVENTORY
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     17
--       Items:                   13
--       Processes:                5
--       Regions:                 22
--       Buttons:                 10
--       Dynamic Actions:          5
--     Shared Components:
--       Logic:
--         Build Options:          2
--       Navigation:
--         Lists:                  3
--         Breadcrumbs:            1
--           Entries:              4
--       Security:
--         Authentication:         1
--         Authorization:          1
--       User Interface:
--         Themes:                 1
--         Templates:
--         LOVs:                   2
--       PWA:
--       Globalization:
--       Reports:
--       E-Mail:
--     Supporting Objects:  Included
--   Version:         26.1.0
--   Instance ID:     746049380173819
--

prompt --application/delete_application
begin
wwv_flow_imp.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/create_application
begin
wwv_imp_workspace.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'DBINVENTORY')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Databases Inventory')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'DB-INV')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'BC72674FEB83934BF4C48B36DA78DDA7A10714B639EFA632CA2F6077C2F6300D'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'21.2'
,p_accessible_read_only=>'N'
,p_session_state_commits=>'IMMEDIATE'
,p_flow_language=>'en'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'Y'
,p_date_format=>'DS'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix=>nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication_id=>wwv_flow_imp.id(1922888328368124)
,p_application_tab_set=>1
,p_logo_type=>'T'
,p_logo_text=>'Databases Inventory'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>' Version 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_pass_ecid=>'N'
,p_authorize_batch_job=>'N'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'Databases Inventory'
,p_last_updated_on=>wwv_flow_imp.dz('20260623193121Z')
,p_last_updated_by=>'CHRIS'
,p_file_prefix=>nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>7
,p_version_scn=>'5706243'
,p_print_server_type=>'NATIVE'
,p_file_storage=>'DB'
,p_is_pwa=>'Y'
,p_pwa_is_installable=>'Y'
,p_pwa_manifest_display=>'standalone'
,p_pwa_manifest_orientation=>'any'
,p_pwa_is_push_enabled=>'N'
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.'
,p_login_url=>'f?p=&APP_ID.:LOGIN:&APP_SESSION.::&DEBUG.:::'
,p_theme_style_by_user_pref=>false
,p_built_with_love=>false
,p_global_page_id=>0
,p_navigation_list_id=>wwv_flow_imp.id(1923624748368125)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>2469215554099805162
,p_nav_list_template_options=>'js-navCollapsed--hidden:t-TreeNav--styleA'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_imp.id(2117855042368192)
,p_nav_bar_list_template_id=>2849019392706229583
,p_nav_bar_template_options=>'#DEFAULT#:js-menu-callout'
);
end;
/
prompt --application/plugin_settings
begin
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(5370468906070369)
,p_plugin_type=>'DYNAMIC ACTION'
,p_plugin=>'NATIVE_OPEN_AI_ASSISTANT'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1919562612368123)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'mode', 'FULL')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(5370551392070369)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_DATE_PICKER_APEX'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'show_on', 'FOCUS',
  'time_increment', '15')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1920139874368123)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_GEOCODED_ADDRESS'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'background', 'default',
  'display_as', 'LIST',
  'map_preview', 'POPUP:ITEM',
  'match_mode', 'RELAX_HOUSE_NUMBER')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(5371371467070371)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SELECT_MANY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_values_as', 'separated')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1920714924368124)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'checked_value', 'Y',
  'unchecked_value', 'N')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1921070859368124)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'default_icon', 'fa-star',
  'tooltip', '#VALUE#')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1921396610368124)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_style', 'SWITCH_CB',
  'off_value', 'N',
  'on_value', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(5371016372070370)
,p_plugin_type=>'PROCESS TYPE'
,p_plugin=>'NATIVE_GEOCODING'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'match_mode', 'RELAX_HOUSE_NUMBER')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1921933785368124)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'include_slider', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1922290720368124)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'actions_menu_structure', 'IG')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(5370718577070370)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_MAP_REGION'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_vector_tile_layers', 'Y')).to_clob
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(5370950587070370)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_ADFBC'
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(5370815587070370)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_BOSS'
);
end;
/
prompt --application/shared_components/navigation/lists/activity_reports
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(2211744440368282)
,p_name=>'Activity Reports'
,p_static_id=>'activity-reports'
,p_required_patch=>wwv_flow_imp.id(2120137423368195)
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2212907463368282)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Application Error Log'
,p_static_id=>'application-error-log'
,p_list_item_link_target=>'f?p=&APP_ID.:10012:&SESSION.::&DEBUG.:10012:::'
,p_list_item_icon=>'fa-exclamation'
,p_list_text_01=>'Report of errors logged by this application'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2214100312368283)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'Automations Log'
,p_static_id=>'automations-log'
,p_list_item_link_target=>'f?p=&APP_ID.:10015:&SESSION.::&DEBUG.:RR,10015:::'
,p_list_item_icon=>'fa-gears'
,p_list_item_disp_cond_type=>'EXISTS'
,p_list_item_disp_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from apex_appl_automations a, apex_automation_log l',
'where a.automation_id = l.automation_id',
'and l.application_id = :APP_ID'))
,p_list_text_01=>'Report of automation executions and messages logged by this application'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2212107372368282)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Dashboard'
,p_static_id=>'dashboard'
,p_list_item_link_target=>'f?p=&APP_ID.:10010:&SESSION.::&DEBUG.:10010:::'
,p_list_item_icon=>'fa-area-chart'
,p_list_text_01=>'View application activity metrics'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2213367849368283)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Page Performance'
,p_static_id=>'page-performance'
,p_list_item_link_target=>'f?p=&APP_ID.:10013:&SESSION.::&DEBUG.:10013:::'
,p_list_item_icon=>'fa-file-chart'
,p_list_text_01=>'Report of activity and performance by application page'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2213775789368283)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Page Views'
,p_static_id=>'page-views'
,p_list_item_link_target=>'f?p=&APP_ID.:10014:&SESSION.::&DEBUG.:RR,10014:::'
,p_list_item_icon=>'fa-file-search'
,p_list_text_01=>'Report of each page view by user including date of access and elapsed time'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2212569666368282)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Top Users'
,p_static_id=>'top-users'
,p_list_item_link_target=>'f?p=&APP_ID.:10011:&SESSION.::&DEBUG.:10011:::'
,p_list_item_icon=>'fa-user-chart'
,p_list_text_01=>'Report of page views aggregated by user'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_bar
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(2117855042368192)
,p_name=>'Navigation Bar'
,p_static_id=>'navigation-bar'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2209170210368281)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'&APP_USER.'
,p_static_id=>'app-user'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2208885080368281)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Install App'
,p_static_id=>'install-app'
,p_list_item_link_target=>'#action$a-pwa-install'
,p_list_item_icon=>'fa-cloud-download'
,p_list_text_02=>'a-pwaInstall'
,p_list_item_current_type=>'NEVER'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2209656262368281)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'---'
,p_static_id=>'list_item'
,p_list_item_link_target=>'separator'
,p_parent_list_item_id=>wwv_flow_imp.id(2209170210368281)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2210065300368281)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Sign Out'
,p_static_id=>'sign-out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_icon=>'fa-sign-out'
,p_parent_list_item_id=>wwv_flow_imp.id(2209170210368281)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_menu
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(1923624748368125)
,p_name=>'Navigation Menu'
,p_static_id=>'navigation-menu'
,p_version_scn=>'SH256:nV6fTiTGxcuVgAJLiWLWMppBG1Uga4O3-PqBHjNyZ88'
,p_updated_on=>wwv_flow_imp.dz('20260623193121Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2603464013078500)
,p_list_item_display_sequence=>10010
,p_list_item_link_text=>'Activity Reports'
,p_static_id=>'activity-reports'
,p_list_item_link_target=>'f?p=&APP_ID.:10001:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-analytics'
,p_parent_list_item_id=>wwv_flow_imp.id(2210683771368281)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2210683771368281)
,p_list_item_display_sequence=>10000
,p_list_item_link_text=>'Administration'
,p_static_id=>'administration'
,p_list_item_link_target=>'f?p=&APP_ID.:10000:&APP_SESSION.::&DEBUG.:'
,p_list_item_icon=>'fa-user-wrench'
,p_security_scheme=>wwv_flow_imp.id(2121312219368195)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2602094002055580)
,p_list_item_display_sequence=>29
,p_list_item_link_text=>'Capacity Planning'
,p_static_id=>'capacity-planning'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-line-chart'
,p_parent_list_item_id=>wwv_flow_imp.id(2218446672509933)
,p_list_item_current_type=>'TARGET_PAGE'
,p_updated_on=>wwv_flow_imp.dz('20260623122153Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2602344054057467)
,p_list_item_display_sequence=>39
,p_list_item_link_text=>'Capacity Planning'
,p_static_id=>'capacity-planning-2'
,p_list_item_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-line-chart'
,p_parent_list_item_id=>wwv_flow_imp.id(2219942796512349)
,p_list_item_current_type=>'TARGET_PAGE'
,p_updated_on=>wwv_flow_imp.dz('20260623122211Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2602693240059589)
,p_list_item_display_sequence=>49
,p_list_item_link_text=>'Capacity Planning'
,p_static_id=>'capacity-planning-3'
,p_list_item_link_target=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-line-chart'
,p_parent_list_item_id=>wwv_flow_imp.id(2221490159519834)
,p_list_item_current_type=>'TARGET_PAGE'
,p_updated_on=>wwv_flow_imp.dz('20260623122142Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2602975961061807)
,p_list_item_display_sequence=>59
,p_list_item_link_text=>'Capacity Planning'
,p_static_id=>'capacity-planning-4'
,p_list_item_link_target=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-line-chart'
,p_parent_list_item_id=>wwv_flow_imp.id(2222053922532657)
,p_list_item_current_type=>'TARGET_PAGE'
,p_updated_on=>wwv_flow_imp.dz('20260623122258Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2600287566028639)
,p_list_item_display_sequence=>21
,p_list_item_link_text=>'Compliance & Security'
,p_static_id=>'compliance-security'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-lock'
,p_parent_list_item_id=>wwv_flow_imp.id(2218446672509933)
,p_list_item_current_type=>'TARGET_PAGE'
,p_updated_on=>wwv_flow_imp.dz('20260623122235Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2600974622034722)
,p_list_item_display_sequence=>31
,p_list_item_link_text=>'Compliance & Security'
,p_static_id=>'compliance-security-2'
,p_list_item_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-lock'
,p_parent_list_item_id=>wwv_flow_imp.id(2219942796512349)
,p_list_item_current_type=>'TARGET_PAGE'
,p_updated_on=>wwv_flow_imp.dz('20260623122248Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2601487410045236)
,p_list_item_display_sequence=>41
,p_list_item_link_text=>'Compliance & Security'
,p_static_id=>'compliance-security-3'
,p_list_item_link_target=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-lock'
,p_parent_list_item_id=>wwv_flow_imp.id(2221490159519834)
,p_list_item_current_type=>'TARGET_PAGE'
,p_updated_on=>wwv_flow_imp.dz('20260623122226Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2601771985048937)
,p_list_item_display_sequence=>51
,p_list_item_link_text=>'Compliance & Security'
,p_static_id=>'compliance-security-4'
,p_list_item_link_target=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-lock'
,p_parent_list_item_id=>wwv_flow_imp.id(2222053922532657)
,p_list_item_current_type=>'TARGET_PAGE'
,p_updated_on=>wwv_flow_imp.dz('20260623122322Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2126354370368198)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Dashboard'
,p_static_id=>'dashboard'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-chart'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5622823187473235)
,p_list_item_display_sequence=>33
,p_list_item_link_text=>'Databases'
,p_static_id=>'databases'
,p_list_item_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database'
,p_parent_list_item_id=>wwv_flow_imp.id(2219942796512349)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623124238Z')
,p_updated_on=>wwv_flow_imp.dz('20260623124238Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5620876611366090)
,p_list_item_display_sequence=>22
,p_list_item_link_text=>'Databases (CDB)'
,p_static_id=>'databases-cdb'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-application'
,p_parent_list_item_id=>wwv_flow_imp.id(2218446672509933)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623122446Z')
,p_updated_on=>wwv_flow_imp.dz('20260623122548Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5676107176909526)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'MongoDB'
,p_static_id=>'mongodb'
,p_list_item_link_target=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-tint'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'6'
,p_created_on=>wwv_flow_imp.dz('20260623192841Z')
,p_updated_on=>wwv_flow_imp.dz('20260623193121Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5623139926491329)
,p_list_item_display_sequence=>37
,p_list_item_link_text=>'Patching'
,p_static_id=>'ms-patching'
,p_list_item_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-server-wrench'
,p_parent_list_item_id=>wwv_flow_imp.id(2219942796512349)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623124539Z')
,p_updated_on=>wwv_flow_imp.dz('20260623124703Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2219942796512349)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'MS SQL'
,p_static_id=>'ms-sql'
,p_list_item_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-tiles-2x2'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'3'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2222053922532657)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'MySQL'
,p_static_id=>'mysql'
,p_list_item_link_target=>'f?p=&APP_ID.:5:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-file-sql-o'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'5'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5626882676716960)
,p_list_item_display_sequence=>53
,p_list_item_link_text=>'Databases'
,p_static_id=>'mysql-databases'
,p_list_item_link_target=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database'
,p_parent_list_item_id=>wwv_flow_imp.id(2222053922532657)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623132315Z')
,p_updated_on=>wwv_flow_imp.dz('20260623132315Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5626372148712366)
,p_list_item_display_sequence=>52
,p_list_item_link_text=>'Servers'
,p_static_id=>'mysql-servers'
,p_list_item_link_target=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-application'
,p_parent_list_item_id=>wwv_flow_imp.id(2222053922532657)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623132229Z')
,p_updated_on=>wwv_flow_imp.dz('20260623132242Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2218446672509933)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Oracle'
,p_static_id=>'oracle'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-button'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'2'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5621990240444742)
,p_list_item_display_sequence=>27
,p_list_item_link_text=>'Patching'
,p_static_id=>'oracle-patching'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-server-wrench'
,p_parent_list_item_id=>wwv_flow_imp.id(2218446672509933)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623123753Z')
,p_updated_on=>wwv_flow_imp.dz('20260623124908Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5624574347580332)
,p_list_item_display_sequence=>43
,p_list_item_link_text=>'Databases'
,p_static_id=>'pg-databases'
,p_list_item_link_target=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database'
,p_parent_list_item_id=>wwv_flow_imp.id(2221490159519834)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623130029Z')
,p_updated_on=>wwv_flow_imp.dz('20260623130138Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5624086858572948)
,p_list_item_display_sequence=>42
,p_list_item_link_text=>'Servers'
,p_static_id=>'pg-servers'
,p_list_item_link_target=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-application'
,p_parent_list_item_id=>wwv_flow_imp.id(2221490159519834)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623125915Z')
,p_updated_on=>wwv_flow_imp.dz('20260623130115Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5621379159406030)
,p_list_item_display_sequence=>23
,p_list_item_link_text=>'Pluggable Databases (PDB)'
,p_static_id=>'pluggable-databases-pdb'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database'
,p_parent_list_item_id=>wwv_flow_imp.id(2218446672509933)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623123126Z')
,p_updated_on=>wwv_flow_imp.dz('20260623123126Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2221490159519834)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Postgres'
,p_static_id=>'postgres'
,p_list_item_link_target=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'menu/db_tools_64.gif'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'4'
,p_updated_on=>wwv_flow_imp.dz('20260623130743Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5622506647470972)
,p_list_item_display_sequence=>32
,p_list_item_link_text=>'Servers'
,p_static_id=>'servers'
,p_list_item_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-database-application'
,p_parent_list_item_id=>wwv_flow_imp.id(2219942796512349)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623124215Z')
,p_updated_on=>wwv_flow_imp.dz('20260623124215Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(5621612107413145)
,p_list_item_display_sequence=>23
,p_list_item_link_text=>'Services'
,p_static_id=>'services'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-accessor-more'
,p_parent_list_item_id=>wwv_flow_imp.id(2218446672509933)
,p_list_item_current_type=>'TARGET_PAGE'
,p_created_on=>wwv_flow_imp.dz('20260623123237Z')
,p_updated_on=>wwv_flow_imp.dz('20260623123237Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
end;
/
prompt --application/shared_components/navigation/listentry
begin
null;
end;
/
prompt --application/shared_components/files/icons_app_icon_192_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000C0000000C0080600000052DC6C0700000A4049444154785EED9DE96F147518C79FEDB5AD8880864045082952093788F5027DA72F25202246C5035E688C31D1FFC2574631F14A3C231063221E6F40C02BA0';
wwv_flow_imp.g_varchar2_table(2) := '829408B45830A14539E4AA26B6DBAE5D6776DB656969E7DC99DFECF39977E2EF7ABEDFE733CFCCECCCAFA985BB76E4840305942A900200A5CE13765E01002011542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B00';
wwv_flow_imp.g_varchar2_table(3) := '00AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000';
wwv_flow_imp.g_varchar2_table(4) := 'AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AAED2778002007542B0000AA';
wwv_flow_imp.g_varchar2_table(5) := 'ED2778002007542B0000AAED2778BD00E47292EDEE96EC858B92CBF6273613AAAFBD566A6EB841AAD2E9C4C610E7C2550290CB662573F2A4E4FAFAE2D43ED4B96B264D92DAC993431D53C3602A01C89CE894814C6FC5F95B7DDD755237756AC5C555CE80';
wwv_flow_imp.g_varchar2_table(6) := 'D40190BDD42DFD67CF14357DB2A54556CE6C92EBEB6ACBA9736863AFF8F083E2582BEFB853F67674C8E9F3E78AFF0604DEA4560740EF891392CB64F22A3DBF7C85AC9939D39B6231B72E05E0D17BEE95FFAC7B99DDEDED72EAAFB340E0C31B7500F45867';
wwv_flow_imp.g_varchar2_table(7) := '4CB192C63EBE58BB4E26D4D6F8902DBE2EC301B0579287A0AD4D4E9DFBEB3204E3ADCBA1462E879C9CD207C06FBF1535F9EED1C79CF431EEFF5F0D805121B09E10D5DD78A3713198B4200030C90D176B190D8021087EB000EF3C73FA7225008231550500';
wwv_flow_imp.g_varchar2_table(8) := '1749675293B100B0D739605D0E7D0F04AE2D0300D75299D1D0090020F0E6130078D32BF6D66E000002F73601807BAD8C68E9168022041DD63DC1E9927B8271E3A46EDA3423623161110060820B1ED6E0050020701616009C3532AA85570080606CFB00C0';
wwv_flow_imp.g_varchar2_table(9) := 'A8F4765E8C1F00C684C0FE9D2095729EB8425B0040C28CF50BC06810545D334ED2D3F44200008A00188260EFF1E3F2FB9F7F1423D70C01002803C00ED77E156ACFF1635740503D6182D44D99923035822F1700826B18E908F76DD9223DFD850F7956DFBD';
wwv_flow_imp.g_varchar2_table(10) := '5C1AAAAB7DCD7F3508D2336648557DBDAFF192DA090012E6DCC6AFB74BFBA9C273FDC5B39B657E63A3EF086C08BE3DDA265D670BAF52DB9F576A7B790E007CA74F3C1DB77575C9CBDFEC2E4EBE60D62C699E32551A6AFCBDD67DB1A747BEFCF9A7FC7829';
wwv_flow_imp.g_varchar2_table(11) := '6B8CFAA6A678028B6956008849F820D36ED8B15D8E96FCBA1B64ACE17D1B9A9BC31CCEF8B100C0788B462EF0746FAFBCB873A7745E381FFAEA01207449CD1AB027E11FC40CA9991918906D9D9DB2F9E04139FBCFDFA1890C00A14969E64095024098EA96';
wwv_flow_imp.g_varchar2_table(12) := 'FEB80600612A6BE0580030D21400303051CBB5240000805205B8092E1769091A970A9020B3822E950A4005A0020C2A90C46D51829E00AED69F0A500E550D1D930A4005A0025001AEA0800A60E8D9BA1CCBA2025001A800315780570F1D92ADAD0764E3ED';
wwv_flow_imp.g_varchar2_table(13) := '77CAE3B36F2E07E79EC6A40278922BD98DE3AE009B0E1F96CD077EC98B38D1FA1CF1F355AB6217140062B720BA05C409C0EB478EC8C7BFEC2F066BFF6D82A79A6F892EF851660280D82D886E017101303CF9D72E5E2ACFCD9F376AE06F597BFEBFBFEFE7';
wwv_flow_imp.g_varchar2_table(14) := '40C23C6101F6B40BC0002090CCC9EA1C07005E93DF56F4FEAD5BE5DFBEC21FF2F07B8C4FD7CB576BD63876070047892AA741D400F8497E5BED37DADBE4C37DFB0209FF54CBEDF2A48B0F5C002090CCC9EA1C25009BACA73D9BADA73D43C7030B16C84B8B';
wwv_flow_imp.g_varchar2_table(15) := '161B271800186749F91614150049497E5B6900285FBE1937721400BCD566DDC0EEBF7C036BEA997FC81C00302E4DCBB720AF00BC6B7D42F9CE4F3F8AD3539BA115BFDD7E54DEDB57D865C13E562F5A242F2C5858BE804218190042103129437805A03439';
wwv_flow_imp.g_varchar2_table(16) := 'D62DBD559E9D3B77D4509398FC5C02EDDA51F89BA14A0EAF000C4FEAD120486AF203000038A2FFDAA1C3B2A5B5F0FA827D3CBEEC36D938674EF1BFCB91FCFC10E6684B280DF824D2A58CC32158BFAC4536CCB945DE3E6A5DF30FEEAC16E6353F3F84B934';
wwv_flow_imp.g_varchar2_table(17) := '26603300F020E0A6C347AC17D92EBFCBB378FA0C69EDEA2C8EB066C912797EDE7C0F238EDE348C1FC2DCBE6BC44D702896256310AFF700C3A37AE5D0AFF2496BEB88604D7FD439963B00908CDC0D65954101B017311C8224273F37C1DC04FB02EB8363C7';
wwv_flow_imp.g_varchar2_table(18) := 'E453EB55879573E7C9FAE6D9BEC630A51315C014272258471815208265463A0500442A77BC9301C048FD0120DE9C8C74760000805205780C1A297E664E460530D397B2AC8A0A4005A0020C2AC0D6880521A8006539D79A392815800A4005A0025C410115';
wwv_flow_imp.g_varchar2_table(19) := 'C0CC937559564505A0025001A80054804105780C5A963A93AC41B9044A965F8156CB251097405C02C57C09C4EED081CE61A176E6122854399D07637768678DA26C010011AACDEED0118AED722A00702954D0665EF708E5A3F8A08ABBEB0F00EE740AD4CA';
wwv_flow_imp.g_varchar2_table(20) := '6BF2DB93F1517C20C95D770600D752F96BE827F9ED99C2F8289EDDA19D3D0300678D7CB748CA06B9FC0EE0DBE2E4758CEA7780A424BFED2000242F8F7DAF380A00D81DDAB73D9177E412C8417276878E3C27239D10001CE46677E848F331F2C900C04172';
wwv_flow_imp.g_varchar2_table(21) := '76878E3C27239D10005CC8CDEED02E444A68130070691CBB43BB142A61CD00C08361EC0EED41AC843405008F46B13BB447C10C6F0E003E0C6277681FA219DA05007C1AC3EED03E8533AC1B001866481CCBE1558838548F69CE285E85882934DFD302806F';
wwv_flow_imp.g_varchar2_table(22) := 'E992D71100467A0600C9CB63DF2B0600002855807B00DF28554E472A40E578E9180915800A4005185480EDD10B4250011CCF9B95D3800A4005A0025001AEA0800A50392778C7487A3A8E89E406F2ED3E7BE861B9BEAED6B14F253738DFD72F2BB76E2E84';
wwv_flow_imp.g_varchar2_table(23) := '98AA9286D9375772B8236253F7142873A2530632BD79219EB9EB2E79A469962AC387076BBFD2F1E6DE3DF97FAEAA6F90F48CE9AAF4500740B6BB5BFACF9C299ABCFEB61679B0A94926D6EAAA04E7AC33FF27C73BE4A3FDFB8B5AD435364AF5F8F10050E9';
wwv_flow_imp.g_varchar2_table(24) := '0A9456814A8FD56D7C550DD6D97FBAAEB37FFEAA6FE1AE1D39B722554ABB5C362B99AE9392EBEFAB949002C5914AA7257DD34D92AAAE0E344E123BAB04206F542E27D94B97247BF1A2D840683C52B57552336992D44C9CA031FC7CCC7A01506B3981972A';
wwv_flow_imp.g_varchar2_table(25) := '0000E4836A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F';
wwv_flow_imp.g_varchar2_table(26) := '00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00';
wwv_flow_imp.g_varchar2_table(27) := 'E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A050040B5FD040F00E4806A05FE07D3D77B1BAA12882600000010646542473634343045353344383944393336433432120B72000000';
wwv_flow_imp.g_varchar2_table(28) := '0049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(2119527424368194)
,p_file_name=>'icons/app-icon-192.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_32_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7AF40000010F49444154584763D4DBBFE73FC30002C651078C86C068080C991010FDF889C1555E1E6789B1FAEA5586EF3CDC0C2CFCFC24952A4497035102820CF16AEA380D';
wwv_flow_imp.g_varchar2_table(2) := 'CF3E769481838585E1C2C70F2439827A0E387A84414F4696E1D6CB170C17DEBF63601114242A24A8E78083071818802100020F5EBD62F8232D455F0720DBB6F0D64D86651FDED3DE01C75EBF62B01215C3B0882E0ED8FDEC19C3F73FBF18FCE4141896DC';
wwv_flow_imp.g_varchar2_table(3) := 'BECDF0F7FF3F0626264686581535069A3AA0FDEC19064B1919868F3F7F30F8032D0701BA3AE0E3EF5F0CE7DFBD63701097C019C7340D01625216DD1C309A08471321AE0449934448A83A4676CCEE870F195EF3F31193611888AE8C88328D0C45A30E180D';
wwv_flow_imp.g_varchar2_table(4) := '81D11018F01000005B9FFB21121D5893000000106465424736303546303546343933354432304337EF84B8740000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(2119284624368194)
,p_file_name=>'icons/app-icon-32.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_512_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000200000002000806000000F478D4FA0000200049444154785EEDDD69CC66E5791FF07B987716661F86E298D510DB511C331048ABA849DA24AA996133A54AB3298D1557CA87068305984855AB7E71E4C824B6';
wwv_flow_imp.g_varchar2_table(2) := 'C1CE87A66A68E2284A22BB266118189CA459A426329E01CCA6180C36CB0C3103CCBEBCCB4CCFF3629701F3BECF72CE799EFB3ED7EF9150A470CE7DEEEB775DF8FC9FF55DB2F9FFFCC5C9E441800001020408841258220084EAB7620910204080C0BC8000';
wwv_flow_imp.g_varchar2_table(3) := '60100810204080404001012060D3954C8000010204040033408000010204020A0800019BAE6402040810202000980102040810201050400008D8742513204080000101C00C10204080008180020240C0A62B990001020408080066800001020408041410';
wwv_flow_imp.g_varchar2_table(4) := '0002365DC9040810204040003003040810204020A0800010B0E94A26408000010202801920408000010201050480804D573201020408101000CC00010204081008282000046CBA920910204080800060060810204080404001012060D3954C8000010204';
wwv_flow_imp.g_varchar2_table(5) := '040033408000010204020A0800019BAE6402040810202000980102040810201050400008D8742513204080000101C00C10204080008180020240C0A62B9900010204080800668000010204080414100002365DC9040810204040003003040810204020A0';
wwv_flow_imp.g_varchar2_table(6) := '800010B0E94A26408000010202801920408000010201050480804D573201020408101000CC00010204081008282000046CBA920910204080800060060810204080404001012060D3954C8000010204040033408000010204020A0800019BAE6402040810';
wwv_flow_imp.g_varchar2_table(7) := '202000980102040810201050400008D8742513204080000101C00C10204080008180020240C0A62B9900010204080800668000010204080414100002365DC9040810204040003003040810204020A0800010B0E94A264080000102028019204080000102';
wwv_flow_imp.g_varchar2_table(8) := '01050480804D573201020408101000CC00010204081008282000046CBA920910204080800060060810204080404001012060D3954C8000010204040033408000010204020A0800019BAE6402040810202000980102040810201050400008D87425132040';
wwv_flow_imp.g_varchar2_table(9) := '80000101C00C10204080008180020240C0A62B9900010204080800668000010204080414100002365DC9040810204040003003040810204020A0800010B0E94A26408000010202801920408000010201050480804D573201020408101000CC0001020408';
wwv_flow_imp.g_varchar2_table(10) := '1008282000046CBA920910204080800060060810204080404001012060D3954C8000010204040033408000010204020A0800019BAE6402040810202000980102040810201050400008D8742513204080000101C00C10204080008180020240C0A62B9900';
wwv_flow_imp.g_varchar2_table(11) := '010204080800668000010204080414100002365DC9040810204040003003040810204020A0800010B0E94A26408000010202801920408000010201050480804D573201020408101000CC00010204081008282000046CBA92091020408080006006081020';
wwv_flow_imp.g_varchar2_table(12) := '4080404001012060D3954C8000010204040033408000010204020A0800019BAE6402040810202000980102040810201050400008D8742513204080000101C00C10204080008180020240C0A62B9900010204080800668000010204080414100002365DC9';
wwv_flow_imp.g_varchar2_table(13) := '040810204040003003040810204020A0800010B0E94A26408000010202801920408000010201050480804D573201020408101000CC00010204081008282000046CBA920910204080800060060810204080404001012060D3954C80000102040400334080';
wwv_flow_imp.g_varchar2_table(14) := '00010204020A0800019BAE6402040810202000980102040810201050400008D8742513204080000101C00C10204080008180020240C0A62B9900010204080800668000010204080414100002365DC9040810204040003003040810204020A0800010B0E9';
wwv_flow_imp.g_varchar2_table(15) := '4A26408000010202801920408000010201050480804D573201020408101000CC00010204081008282000046CBA920910204080800060060810204080404001012060D3954C8000010204040033408000010204020A0800019BAE64020408102020009801';
wwv_flow_imp.g_varchar2_table(16) := '02040810201050400008D8742513204080000101C00C10204080008180020240C0A62B9900010204080800668000010204080414100002365DC9040810204040003003040810204020A0800010B0E94A2640800001020280192040800001020105048080';
wwv_flow_imp.g_varchar2_table(17) := '4D573201020408101000CC401902274FA6B94387AA7F0EA713D3C7539A9B4B27AB7F52F5FFF7E8A8C0922569C9D2A9EA9FA569C98AE569E9DAB569E9EAD51D2D565904C62F20008CDFDC158710E8DDE467F6EE4D73070E5637FB13439CE9D04E0A2C392D';
wwv_flow_imp.g_varchar2_table(18) := '4D6D589FA6366D4A4B4E3BAD93252A8AC0B80404807149BBCED00233AFBC92665F7DD5B3FCA1E5029C70DAD2B46CD319696AE3C600C52A91403B0202403BAE56AD2170F2C48934FDFC0BE9C4F1633556716A0481D34E3F3D2D3FE71CAF064468B61A1B17';
wwv_flow_imp.g_varchar2_table(19) := '10001A27B5601D8193D3D3E9F80B2FA693B3337596716E20812553CBD28AF3CE4D4B962D0B54B55209D4171000EA1B5AA1218193B3B3E9F873CF5537FFD98656B44C1481DE0705579C775E5AB27C799492D549A0B68000509BD0028D08549FE63FD6BBF9';
wwv_flow_imp.g_varchar2_table(20) := '1FAF3EE1EF4160040121600434A78416100042B73F9FE267BEFDED34BB6F5F3E1BB2932205848022DB66D3131210002604EFB26F08F45EF23FF6CC3303917CDFFA0DE903EF794FFAD1EF7B67BA68CD9AB4666AE940E739284F819FF8C3CF2FBAB19FB878';
wwv_flow_imp.g_varchar2_table(21) := '73FA76150CBFB17B779A9D1BECAD212120CF5EDB557E0202407E3D09B7A3E93D2FA5B9830716AD7BCDCA95E9BFFCE44FA51F3BF3CC703E5D2EB85F00F8A57FF5AFE7CB9FA97E0FE21B2FBF9C763DF5543A31C0EF4108015D9E1AB5352520003425699DD1';
wwv_flow_imp.g_varchar2_table(22) := '04AAF7FE8F56FFA3BED863E5B2E5E9BF5F734DBAC8AFC08D669CF159830680EF96B0FFD8B1F4B78F3E9AF61F3DD2B72A21A02F9103820B0800C10760D2E5CF1D3C98A6F7EC59741BFFF5A7FF4DBAE2EC774E7AABAEDF82C0B001A0B78503550878E0E187';
wwv_flow_imp.g_varchar2_table(23) := 'D2B1EA2BA3FD1E42403F21FF3EB2800010B9FB19D4DEEFE5FF8BAA97FCFFD7962B53F5B3F01E1D1418250008011D1C04254D4440009808BB8B7E57E0F8B79E5BF417FF6EA9DE03FEB7E79F0FACA302A3060021A0A303A1ACB10A080063E576B1B70A1C7B';
wwv_flow_imp.g_varchar2_table(24) := 'E6D9457FF5EF8F7FE6DFA773AA0F007A7453A04E001002BA3913AA1A9F8000303E6B577A1B81A34F3DBDE85FF9FB8B5FFCA5B4E234AFFF777578EA060021A0AB93A1AE71080800E350768D05058E7EFDEB8BEAFCDD2FFD077A1D1668220008011D1E10A5';
wwv_flow_imp.g_varchar2_table(25) := 'B52A2000B4CA6BF17E0202403FA16EFFFBA6028010D0ED39515D3B0202403BAE561D5040001810AAA38735190084808E0E89B25A1310005AA3B5F0200202C0204ADD3DA6E900200474775654D6BC8000D0BCA9158710100086C0EAE0A16D040021A08383';
wwv_flow_imp.g_varchar2_table(26) := 'A2A45604048056582D3AA8800030A854378F6B2B000801DD9C1755352B200034EB69B52105048021C13A76789B014008E8D8B028A7710101A071520B0E2320000CA3D5BD63DB0E004240F7664645CD090800CD595A690401016004B40E9D328E00200474';
wwv_flow_imp.g_varchar2_table(27) := '686094D2A88000D028A7C5861510008615EBD6F1E30A004240B7E64635CD080800CD385A654401016044B88E9C36CE00200474646894D1988000D018A585461110004651EBCE39E30E00424077664725F5050480FA8656A8212000D4C0EBC0A993080042';
wwv_flow_imp.g_varchar2_table(28) := '40070647098D0808008D305A645401016054B96E9C37A900200474637E54514F4000A8E7E7EC9A0202404DC0C24F9F640010020A1F1EDBAF2D2000D426B4401D0101A08E5EF9E74E3A000801E5CF900A4617100046B77366030202400388052F91430010';
wwv_flow_imp.g_varchar2_table(29) := '020A1E205BAF252000D4E273725D0101A0AE60D9E7E712008480B2E7C8EE4713100046737356430202404390852E93530010020A1D22DB1E5940001899CE894D0808004D2896BB466E014008287796EC7C7801016078336734282000348859E052390600';
wwv_flow_imp.g_varchar2_table(30) := '21A0C041B2E59104048091D89CD4948000D0946499EBE41A00848032E7C9AE8713100086F37274C3020240C3A0852D97730010020A1B26DB1D5A4000189ACC094D0A08004D6A96B756EE014008286FA6EC7870010160702B47B6202000B4805AD0922504';
wwv_flow_imp.g_varchar2_table(31) := '0021A0A081B2D5A1040480A1B81CDCB48000D0B46859EB9512008480B2E6CA6E07131000067372544B0202404BB0852C5B520010020A192ADB1C5840001898CA816D0808006DA896B366690140082867B6ECB4BF8000D0DFC8112D0A08002DE216B07489';
wwv_flow_imp.g_varchar2_table(32) := '0140082860B06C7120010160202607B5252000B4255BC6BAA506809142C0F9E7A725CB9695D118BB0C212000846873BE450A00F9F6661C3B2B39000C1D02962D4F2BDF75414A4B968C83D63508F4151000FA1239A04D0101A04DDDFCD72E3D000C1B0296';
wwv_flow_imp.g_varchar2_table(33) := 'AE5E9D969F734EFE8DB1C3100202408836E75BA400906F6FC6B1B32D7FFAA7E9C8F4F1052FF5733FF6E369D9D2A5E3D84AAD6B1C38762C3DF0F043E9D8F474DF75969DF58E34B5617DDFE31C40A06D0101A06D61EB2F2A2000C41E905FB8F7DEF4C26BAF';
wwv_flow_imp.g_varchar2_table(34) := '2E8870F58FFCF3B471D5AA2290E643C0230FA763C7170E34BD4296548166E54517792BA088AE767B930240B7FB9B7D750240F62D6A75831FF9EBBF4E0FBFF0FC82D7B8EC3DEF4DEF7BE73B5BDD43938B0FFA4AC0D4A633D3B24D673479696B11185A4000';
wwv_flow_imp.g_varchar2_table(35) := '189ACC094D0A08004D6A96B7D6EDD533E63F7FF4D10537BEB67ACFFCDACB2E4FA715F4C1B9FD478FA61DBB76A5E9B9D905EB5A3235F5FAAB001E04262820004C10DFA5531200624FC1FFDDBB37FDFAFDF72D8AF0A3EF7B5F7AF799FFAC28A8A75F7E39FD';
wwv_flow_imp.g_varchar2_table(36) := 'C3934F2CBAE715175C904E5BB1A2A8BA6CB65B020240B7FA595C350240712D6B74C333274EA6ABFEF44FD2B1D99905D79D5A3A95B65C7659DA78FAE98D5EBBEDC5BEF4E057D2E1EAD580851EDE0668BB03D6EF272000F413F2EF5B1510005AE52D62F1DF';
wwv_flow_imp.g_varchar2_table(37) := 'AC5E2EBFF789C717DDEBF2EA3BF4FFF2077F309DBB61431135F536F9F0F3CFA5C79E7D76C1FDFA4A6031ADECEC460580CEB6B68CC2048032FAD4E62E5FAE3E35FFB35FFC429A3D71A2EF655657DF087857F535BA73366E9CFF7640CE5F11DC7DE040FAAB';
wwv_flow_imp.g_varchar2_table(38) := 'EAAB810B3D96542FFFAFACDE06F020302901016052F2AE3B2F200018849EC0E71E7B3CFDC9C3BB62619CB6349DFEEEEF8F55B36AB3121000B26A47BCCD0800F17AFE76151F9D3B91FED35F7C393DFDF2B743819CFEDEF786AA57B17909080079F523DC6E';
wwv_flow_imp.g_varchar2_table(39) := '0480702D5FB0E0578E4FA75FADBE11F0ED8307C2A00800615A9D65A10240966D89B32901204EAF07A9F45B478EA45BFFF22FD34BFBF70D7278F1C70800C5B7B0E8020480A2DB57FEE60580F27BD87405FB6766D3AFFFDDDFA6C777BFD8F4D2D9AD270064';
wwv_flow_imp.g_varchar2_table(40) := 'D792501B120042B53BBF620580FC7A92CB8EFEE7D7FF31FDD15777A6E91373B96CA9F17D08008D935A7008010160082C87362F2000346FDAA515F74ECFA4DF7DF46BE9BE3EBFAA576ACD0240A99DEBC6BE05806EF4B1D82A0480625B37D68D1FABBE25F0';
wwv_flow_imp.g_varchar2_table(41) := 'F7AFEC4D7FF5CD67D39E03FBD3FE23C7D24BBD0F0B9E3C39D67D347D3101A06951EB0D2320000CA3E5D8C6050480C6492D9891C04FFCE1E717DD8D009051B3026E450008D8F49C4A160072EA86BD342D2000342D6ABD260504802635AD35B48000303499';
wwv_flow_imp.g_varchar2_table(42) := '130A1210000A6A56C0AD0A00019B9E53C902404EDDB097A6050480A645ADD7A48000D0A4A6B586161000862673424102024041CD0AB855012060D3732A5900C8A91BF6D2B48000D0B4A8F59A1410009AD4B4D6D00202C0D0644E2848400028A85901B72A';
wwv_flow_imp.g_varchar2_table(43) := '00046C7A4E250B003975C35E9A1610009A16B55E93020240939AD61A5A4000189ACC090509080005352BE0560580804DCFA9640120A76ED84BD3020240D3A2D66B5240006852D35A430B0800439339A1200101A0A06605DCAA0010B0E939952C00E4D40D';
wwv_flow_imp.g_varchar2_table(44) := '7B695A4000685AD47A4D0A08004D6A5A6B680101606832271424200014D4AC805B150002363DA79205809CBA612F4D0B08004D8B5AAF490101A0494D6B0D2D20000C4DE68482040480829A1570AB0240C0A6E754B200905337ECA5690101A06951EB3529';
wwv_flow_imp.g_varchar2_table(45) := '200034A969ADA1050480A1C99C509080005050B3026E550008D8F49C4A160072EA86BD342D2000342D6ABD260504802635AD35B48000303499130A1210000A6A56C0AD0A00019B9E53C902404EDDB097A6050480A645ADD7A48000D0A4A6B58616100086';
wwv_flow_imp.g_varchar2_table(46) := '2673424102024041CD0AB855012060D3732A5900C8A91BF6D2B48000D0B4A8F59A1410009AD4B4D6D00202C0D0644E2848400028A85901B72A00046C7A4E250B003975C35E9A1610009A16B55E93020240939AD61A5A4000189A6CE8135E9D9E49BFBD6B';
wwv_flow_imp.g_varchar2_table(47) := '677AE8F9E7D3F26553E9B273CF4F1FBDF4D2B46E6AE9D06B396138010160382F478F57400018AFB7ABBD454000687724BE79F848FAE8971F48AF1C3AF8A60B9DB36143FABD2BAF4AAB960A016D7640006853D7DA75050480BA82CEAF252000D4E25BF4E4';
wwv_flow_imp.g_varchar2_table(48) := '67AB9BFF8D3BEE4FFB8E1C7EDBE37EA67A15E0A6F75FDCDE06AC9C04004390B3800090737702EC4D0068A7C9AFDFFCEFAB6EFE4716BCC045679E997E7FEB95ED6CC0AAF302028041C8594000C8B93B01F6260034DFE4DECDFFD7B6DF9B0E1E3FB6E8E217';
wwv_flow_imp.g_varchar2_table(49) := '5601E00F0480E61B70CA8A0240ABBC16AF292000D404747A3D0101A09EDF5BCF7EE6F0E174C3F6ED7D6FFEBDF3AEBF7873BAF9924B9ADD80D5DE24200018889C0504809CBB13606F0240734DEEDDFC3F72DF7DE9C0B1A37D173D63F59AF4F96B3FE89B00';
wwv_flow_imp.g_varchar2_table(50) := '7DA5EA1D2000D4F37376BB020240BBBE56EF23200034332283BEECDFBBDAC655ABD3E7B66C49E7AF5EDDCCC5ADB2A0800060387216100072EE4E80BD0900F59BFC8D43BD67FE83BDECBFB1BAE9DF71C5D674E1EA55F52FFC9D157ABF33F0C99D0FA6C7F7';
wwv_flow_imp.g_varchar2_table(51) := 'BCB4E0370E1ABB58CD853654E167F3D967A7DB2EFF91B4BEFA4D84B61F0240DBC2D6AF232000D4D1736E6D0101A01EE1D3870EA51BAB97FDFB7DE06FFE997F4B37FF0F6FDF56FDCEC0A17A858CF9ECB3D6AD4B775D754DEB6F810800636EACCB0D252000';
wwv_flow_imp.g_varchar2_table(52) := '0CC5E5E0A6050480D1459FAA6EBA370D71F3BFB37AE6FFAE069FF9F776FEF19D5F4D3B9E7C72F4222678E6759B37A75B37B7FB21480160820D76E9BE0202405F2207B42920008CA6FBF4C143E986FBEF4B87FB7CD56FFE997F8BEFF95F7FF7DD69EF5B7E';
wwv_flow_imp.g_varchar2_table(53) := '6570B48AC67FD63BD6AF4F5FA83E08D9E643006853D7DA75050480BA82CEAF2520000CCF97CBCDBFB7F39203C0596BD7A52F5E77DDF00D18E20C0160082C878E5D4000183BB90B9E2A20000C370F5FAF9EF9DF38E833FFEA3DFF365EF63F75C79FD8B52B';
wwv_flow_imp.g_varchar2_table(54) := '6D7FE2F1E18AC8E4E86BAB9F41BEADFA39E4361F02409BBAD6AE2B2000D415747E2D01016070BEDECDFFA6EAB7FD0F0DF03DFFDE07FE3EBB656BBA6055739FF67FBB9DEE9B99491FDAB62DBD7AB8B00F0156CFFEEFBADA8700079F3E4776514000E86257';
wwv_flow_imp.g_varchar2_table(55) := '0BAA490018AC5939DEFCBFBBF3BD5508B8FDC1AFA4C776EF19E8478806ABB89DA37A5F03BCA4FA1AE0CD975D9ECE58BEAC9D8B9CB2AA57005A2776811A0202400D3CA7D6171000FA1BE6F49E7FFFDD3AE2540101C03CE42C2000E4DC9D007B1300166FF2';
wwv_flow_imp.g_varchar2_table(56) := '3F1E3838FFB2FFA43FED1F60145B2951006885D5A20D0908000D415A663401016061B7DECDFFC6FBB7A723D3D37D71DBFCAA5FDF8B3B60410101C070E42C2000E4DC9D007B1300DEBEC96EFEDD187E01A01B7DEC6A150240573B5B485D02C0F736CACDBF';
wwv_flow_imp.g_varchar2_table(57) := '90E11D609B02C000480E9998800030317A17EE0908006F9E0337FF6EFD77210074AB9F5DAB4600E85A470BAB470078A3616EFE850DEF00DB1500064072C8C404048089D1BBB05700DE9881C7F61D48B73C709F0FFC75EC3F0B01A0630DED58390240C71A';
wwv_flow_imp.g_varchar2_table(58) := '5A5A3939BC027060762E7DBAFA49DB8776BF90A66766D365E79D973E36A6BF17DFEBD7A3FBF7A75BEEBF3F1D9D19E0D3FE2DFC49DFD266A6A4FD0A0025752BDE5E0580783DCFAAE2490780237373E957AA3FA9BB7BDF6B6F72D9B4664DFAF407B6A40B1B';
wwv_flow_imp.g_varchar2_table(59) := 'FEF3B96FC5FF5A75F3BFD5CD3FAB996C72330240939AD66A5A4000685AD47A43094C3A007CEA9147D2971EFDDADBEEB9F7B3B1776EE98580D543D534E8C1BD9BFFCD55F8383E3BD3F794DE6FFBB7FD877DFA6EC201430B0800439339618C0202C018B15D';
wwv_flow_imp.g_varchar2_table(60) := 'EA7B05261D007EFEDE6DE9C5D7DEFCECFFD45DAE5DB132FDCE555737FE4A40EF3DFF8F563FF233D0CDBF0A229FAB82C8F92D051173D99E8000D09EAD95EB0B0800F50DAD504360D201E067EFB927EDD9BF6FD10A7A21E0CEAD57A677AF5D53A3D2374E75';
wwv_flow_imp.g_varchar2_table(61) := 'F36F84B18845048022DA1476930240D8D6E751F8A403C06FECDA99EE7FE289BE18ABBF1302DE5B33043CB26FDFFC07FE067AE6EF65FFBE7DC9FD000120F70EC5DE9F0010BBFF13AF7ED201607FF5A9FF5FDE76CF407FCF7EEDCA95E9335BAE4CA3868087';
wwv_flow_imp.g_varchar2_table(62) := 'AAB71A6E7BE081746CC04FFB7F76CBD674C1AA5513EF910D8C2E20008C6EE7CCF6050480F68D5D611181490780DED69E3B7C38DDB063477AEDC8E1BEBDEABD1270477563FE81756BFB1E7BEA010F5737FF5BAABFEA373D3BDBF73C7FD8A72F5131070800';
wwv_flow_imp.g_varchar2_table(63) := 'C5B42AE4460580906DCFA7E81C02404FE35B478EA48F5437E8D7AA30D0EFB17AC58AF4A92A04BC6FDDBA7E87CEFFFBDE33FF8F3DB0231D9F19ECD3FE775CB1B5F10F1D0EB4D1110F7A757A267D72E783E9F13D2FA57D0384A8112FD3C869BD6F766C3EFB';
wwv_flow_imp.g_varchar2_table(64) := 'EC74DB987EE7410068A46D16694940006809D6B28309E41200860D01AB96BF1E027E68FDE22120C2CDFFC3DBB7A5570E1D1AACE1991C755615DEEEBAEA9AB46E6A69AB3B12005AE5B5784D0101A026A0D3EB09E41400460901B7575FCFDBBC7EFDDB22EC';
wwv_flow_imp.g_varchar2_table(65) := '7AF5B5745375731CE451EAF7FC3FBEF3AB69C7934F0E526276C75CB77973BA75F325ADEE4B006895D7E2350504809A804EAF27905B00E85533CC6702564C2D4B9FD97A557AFF8637BF1210E53DFFEBEFBE3BED3D74B0DE104CE8EC7754C1ED0BD77EB0D5';
wwv_flow_imp.g_varchar2_table(66) := 'AB0B00ADF25ABCA680005013D0E9F504720C00A38480DFAA5E09B874E3C6798C2837FF5EAD250780B3D6AE4B5FBCEEBA7A03DCE76C01A0555E8BD71410006A023ABD9E40AE01A05755EF83813756DF0E78F5F060EF6FDF79F53569F6C489EAE77DB70F84';
wwv_flow_imp.g_varchar2_table(67) := '52EACBFEA716F789EA8F286D7FE2F181EACDEDA06BDF7F71BAEDD24B5BDD9600D02AAFC56B0A080035019D5E4F20E70030FF4AC0FCB703060B01BDB70306F9819FDEBABD9B7F17BEE7BFAFFA66C387B66D1B3824D59B96E6CEEE3DFBBFAB0A6C3E04D89C';
wwv_flow_imp.g_varchar2_table(68) := 'A995CA131000CAEB59A7769C7B001836040CD29CAEDCFCBF5BEBDE2A04DCFEE057D263BBF7A403C78E0E4230B1637A5F03BCA4FA1AE0CD975D9ECE58BEACF57D7805A0756217A8212000D4C0736A7D811202C07C0818E2C7821653F1233FF567A6A41504';
wwv_flow_imp.g_varchar2_table(69) := '8092BA156FAF0240BC9E6755712901A08910E0E69FD5E88D653302C058985D64440101604438A73523505200A81302DCFC9B9997D25611004AEB58ACFD0A00B1FA9D5DB5A505805142809B7F766337B60D090063A376A11104048011D09CD29C40890160';
wwv_flow_imp.g_varchar2_table(70) := '9810E0E6DFDCAC94B892005062D7E2EC590088D3EB2C2B2D35000C1202DCFCB31CB9B16E4A00182BB78B0D2920000C09E6F066054A0E00F321A0F76341D55FFA7BEB1FC3D9B4664DBAE38A2DE98255AB9A05B35A5102024051ED0AB75901205CCBF32AB8';
wwv_flow_imp.g_varchar2_table(71) := 'F400D0D3ECFD39DC4FEDDA991EDDB327CDCECDA51F3EF7DCB17DCF3CAF6EDACD5B0504003391B3800090737702ECAD0B0120409B9438A2800030229CD3C62220008C85D94516121000CC46970504802E77B7FCDA0480F27B5874050240D1EDB3F93E0202';
wwv_flow_imp.g_varchar2_table(72) := '8011C9594000C8B93B01F62600046872E0120580C0CD2FA07401A0802675798B024097BBAB3601C00CE42C2000E4DC9D007B130002343970890240E0E61750BA00504093BABC4501A0CBDD559B0060067216100072EE4E80BD0900019A1CB844012070F3';
wwv_flow_imp.g_varchar2_table(73) := '0B285D0028A0495DDEA200D0E5EEAA4D003003390B0800397727C0DE0480004D0E5CA20010B8F905942E0014D0A42E6F5100E87277D5260098819C0504809CBB13606F02408026072E510008DCFC024A17000A685297B7280074B9BB6A1300CC40CE0202';
wwv_flow_imp.g_varchar2_table(74) := '40CEDD09B0370120409303972800046E7E01A50B000534A9CB5B1400BADC5DB50900662067010120E7EE04D89B0010A0C9814B14000237BF80D20580029AD4E52D0A005DEEAEDA04003390B3800090737702EC4D0008D0E4C0250A00819B5F40E9024001';
wwv_flow_imp.g_varchar2_table(75) := '4DEAF21605802E77576D028019C8594000C8B93B01F62600046872E0120580C0CD2FA07401A0802675798B024097BBAB3601C00CE42C2000E4DC9D007B130002343970890240E0E61750BA00504093BABC4501A0CBDD559B0060067216100072EE4E80BD';
wwv_flow_imp.g_varchar2_table(76) := '0900019A1CB844012070F30B285D0028A0495DDEA200D0E5EEAA4D003003390B0800397727C0DE0480004D0E5CA20010B8F905942E0014D0A42E6F5100E87277D5260098819C0504809CBB13606F02408026072E510008DCFC024A17000A685297B72800';
wwv_flow_imp.g_varchar2_table(77) := '74B9BB6A1300CC40CE020240CEDD09B0370120409303972800046E7E01A50B000534A9CB5B1400BADC5DB50900662067010120E7EE04D89B0010A0C9814B14000237BF80D20580029AD4E52D0A00ED77F7D5E999F4DBBB76A6879E7F3E2D5F36952E3BF7';
wwv_flow_imp.g_varchar2_table(78) := 'FCF4D14B2F4DEBA696B67FF1E0571000820F40E6E50B009937A8EBDB1300DAEDF0370F1F491FFDF203E9954307DF74A173366C48BF77E55569D55221A0CD0E08006DEA5ABBAE80005057D0F9B50404805A7C8B9EFC6C75F3BF71C7FD69DF91C36F7BDCCF';
wwv_flow_imp.g_varchar2_table(79) := '54AF02DCF4FE8BDBDB8095930060087216100072EE4E80BD0900ED34F9F59BFF7DD5CDFFC88217B8E8CC33D3EF6FBDB29D0D58755E40003008390B0800397727C0DE0480E69BDCBBF9FFDAF67BD3C1E3C7165DFCC22A00FC8100D07C034E5951006895D7';
wwv_flow_imp.g_varchar2_table(80) := 'E2350504809A804EAF272000D4F37BEBD9CF1C3E9C6ED8BEBDEFCDBF77DEF5176F4E375F7249B31BB0DA9B0404000391B3800090737702EC4D0068AEC9BD9BFF47EEBB2F1D3876B4EFA267AC5E933E7FED077D13A0AF54BD0304807A7ECE6E57400068D7';
wwv_flow_imp.g_varchar2_table(81) := 'D7EA7D040480664664D097FD7B57DBB86A75FADC962DE9FCD5AB9BB9B855161410000C47CE020240CEDD09B03701A07E93BF71A8F7CC7FB097FD375637FD3BAED89A2E5CBDAAFE85BFB342EF77063EB9F3C1F4F89E9716FCC6416317ABB9D0862AFC6C3E';
wwv_flow_imp.g_varchar2_table(82) := 'FBEC74DBE53F92D657BF89D0F64300685BD8FA750404803A7ACEAD2D2000D4237CFAD0A17463F5B27FBF0FFCCD3FF36FE9E6FFE1EDDBAADF193854AF90319F7DD6BA75E9AEABAE69FD2D100160CC8D75B9A1040480A1B81CDCB4800030BAE853D54DF7A6';
wwv_flow_imp.g_varchar2_table(83) := '216EFE7756CFFCDFD5E033FFDECE3FBEF3AB69C7934F8E5EC404CFBC6EF3E674EBDFFAE3E80000129449444154E6763F0429004CB0C12EDD574000E84BE48036050480D1749F3E7828DD70FF7DE9709FAFFACD3FF36FF13DFFEBEFBE3BED7DCBAF0C8E56';
wwv_flow_imp.g_varchar2_table(84) := 'D1F8CF7AC7FAF5E90BD50721DB7C08006DEA5ABBAE80005057D0F9B5040480E1F972B9F9F7765E7200386BEDBAF4C5EBAE1BBE01439C21000C81E5D0B10B0800632777C153050480E1E6E1EBD533FF1B077DE65FBDE7DFC6CBFEA7EEF813BB76A5ED4F3C';
wwv_flow_imp.g_varchar2_table(85) := '3E5C11991C7D6DF533C8B7553F87DCE643006853D7DA75050480BA82CEAF2520000CCED7BBF9DF54FDB6FFA101BEE7DFFBC0DF67B76C4D17AC6AEED3FE6FB7D37D3333E943DBB6A5570F17F621C0EAD9FF5D57FB10E0E0D3E7C82E0A08005DEC6A413509';
wwv_flow_imp.g_varchar2_table(86) := '0083352BC79BFF7777BEB70A01B73FF895F4D8EE3D03FD08D16015B77354EF6B8097545F03BCF9B2CBD319CB97B573915356F50A40EBC42E50434000A881E7D4FA0202407FC39CDEF3EFBF5B479C2A200098879C0504809CBB13606F02C0E24DFEC70307';
wwv_flow_imp.g_varchar2_table(87) := 'E75FF69FF4A7FD038C622B250A00ADB05AB4210101A02148CB8C2620002CECD6BBF9DF78FFF674647ABA2F6E9B5FF5EB7B71072C282000188E9C0504809CBB13606F02C0DB37D9CDBF1BC32F0074A38F5DAD4200E86A670BA94B00F8DE46B9F91732BC03';
wwv_flow_imp.g_varchar2_table(88) := '6C53001800C921131310002646EFC23D0101E0CD73E0E6DFADFF2E04806EF5B36BD508005DEB6861F508006F34CCCDBFB0E11D60BB02C000480E9998800030317A17F60AC01B33F0D8BE03E99607EEF381BF8EFD67210074ACA11D2B4700E858434B2B27';
wwv_flow_imp.g_varchar2_table(89) := '8757000ECCCEA54F573F69FBD0EE17D2F4CC6CBAECBCF3D2C7C6F4F7E27BFD7A74FFFE74CBFDF7A7A333037CDABF853FE95BDACC94B45F01A0A46EC5DBAB0010AFE759553CE90070646E2EFD4AF5277577EF7BED4D2E9BD6AC499FFEC0967461C37F3EF7';
wwv_flow_imp.g_varchar2_table(90) := 'ADF85FAB6EFEB7BAF96735934D6E46006852D35A4D0B08004D8B5A6F28814907804F3DF248FAD2A35F7BDB3DF77E36F6CE2DBD10B07AA89A063DB877F3BFB90A1FC76767FA9ED2FB6DFFB6FFB04FDF4D3860680101606832278C5140001823B64B7DAFC0';
wwv_flow_imp.g_varchar2_table(91) := 'A403C0CFDFBB2DBDF8DA9B9FFD9FBACBB52B56A6DFB9EAEAC65F09E8BDE7FFD1EA477E06BAF95741E473551039BFA520622EDB131000DAB3B5727D0101A0BEA1156A084C3A00FCEC3DF7A43DFBF72D5A412F04DCB9F5CAF4EEB56B6A54FAC6A96EFE8D30';
wwv_flow_imp.g_varchar2_table(92) := '16B1880050449BC26E520008DBFA3C0A9F7400F88D5D3BD3FD4F3CD11763F57742C07B6B868047F6ED9BFFC0DF40CFFCBDECDFB72FB91F2000E4DEA1D8FB130062F77FE2D54F3A00ECAF3EF5FFCBDBEE19E8EFD9AF5DB9327D66CB9569D410F050F556C3';
wwv_flow_imp.g_varchar2_table(93) := '6D0F3C908E0DF869FFCF6ED99A2E58B56AE23DB281D1050480D1ED9CD9BE8000D0BEB12B2C2230E900D0DBDA73870FA71B76EC48AF1D39DCB757BD5702EEA86ECC3FB06E6DDF634F3DE0E1EAE67F4BF557FDA66767FB9EE70FFBF4252AE60001A0985685';
wwv_flow_imp.g_varchar2_table(94) := 'DCA80010B2EDF9149D4300E8697CEBC891F491EA06FD5A1506FA3D56AF58913E558580F7AD5BD7EFD0F97FDF7BE6FFB10776A4E333837DDAFF8E2BB636FEA1C381363AE241AF4ECFA44FEE7C303DBEE7A5B46F801035E2651A39ADF7CD8ECD679F9D6E1B';
wwv_flow_imp.g_varchar2_table(95) := 'D3EF3C08008DB4CD222D0908002DC15A7630815C02C0B02160D5F2D743C00FAD5F3C0444B8F97F78FBB6F4CAA14383353C93A3CEAAC2DB5D575D93D64D2D6D75470240ABBC16AF292000D404747A3D819C02C02821E0F6EAEB799BD7AF7F5B845DAFBE96';
wwv_flow_imp.g_varchar2_table(96) := '6EAA6E8E833C4AFD9EFFC7777E35ED78F2C9414ACCEE98EB366F4EB76EBEA4D57D0900ADF25ABCA680005013D0E9F504720B00BD6A86F94CC08AA965E9335BAF4AEFDFF0E65702A2BCE77FFDDD77A7BD870ED61B82099DFD8E2AB87DE1DA0FB67A7501A0';
wwv_flow_imp.g_varchar2_table(97) := '555E8BD71410006A023ABD9E408E01609410F05BD52B01976EDC388F11E5E6DFABB5E40070D6DA75E98BD75D576F80FB9C2D00B4CA6BF19A0202404D40A7D713C83500F4AAEA7D30F0C6EADB01AF1E1EECFDED3BAFBE26CD9E3851FDBCEFF681504A7DD9';
wwv_flow_imp.g_varchar2_table(98) := 'FFD4E23E51FD11A5ED4F3C3E50BDB91D74EDFB2F4EB75D7A69ABDB12005AE5B5784D0101A026A0D3EB09E41C00E65F0998FF76C06021A0F776C0203FF0D35BB777F3EFC2F7FCF755DF6CF8D0B66D0387A47AD3D2DCD9BD67FF775581CD87009B33B55279';
wwv_flow_imp.g_varchar2_table(99) := '020240793DEBD48E730F00C38680419AD3959BFF776BDD5B8580DB1FFC4A7A6CF79E74E0D8D1410826764CEF6B8097545F03BCF9B2CBD319CB97B5BE0FAF00B44EEC02350404801A784EAD2F504200980F0143FC58D0622A7EE4A7FECC94B482005052B7';
wwv_flow_imp.g_varchar2_table(100) := 'E2ED550088D7F3AC2A2E2500341102DCFCB31ABDB16C4600180BB38B8C2820008C08E7B466044A0A007542809B7F33F352DA2A0240691D8BB55F012056BFB3ABB6B400304A0870F3CF6EECC6B62101606CD42E3482800030029A539A132831000C1302DC';
wwv_flow_imp.g_varchar2_table(101) := 'FC9B9B95125712004AEC5A9C3D0B00717A9D65A5A506804142809B7F962337D64D090063E576B12105048021C11CDEAC40C901603E04F47E2CA8FA4B7F6FFD63389BD6AC49775CB1255DB06A55B360562B4A400028AA5DE1362B00846B795E05971E007A';
wwv_flow_imp.g_varchar2_table(102) := '9ABD3F87FBA95D3BD3A37BF6A4D9B9B9F4C3E79E3BB6EF99E7D54DBB79AB800060267216100072EE4E80BD7521000468931247141000468473DA58040480B130BBC842020280D9E8B28000D0E5EE965F9B00507E0F8BAE400028BA7D36DF474000302239';
wwv_flow_imp.g_varchar2_table(103) := '0B0800397727C0DE0480004D0E5CA20010B8F905942E0014D0A42E6F5100E87277D5260098819C0504809CBB13606F02408026072E510008DCFC024A17000A685297B7280074B9BB6A1300CC40CE020240CEDD09B0370120409303972800046E7E01A50B';
wwv_flow_imp.g_varchar2_table(104) := '000534A9CB5B1400BADC5DB50900662067010120E7EE04D89B0010A0C9814B14000237BF80D20580029AD4E52D0A005DEEAEDA04003390B3800090737702EC4D0008D0E4C0250A00819B5F40E90240014DEAF21605802E77576D028019C8594000C8B93B';
wwv_flow_imp.g_varchar2_table(105) := '01F62600046872E0120580C0CD2FA07401A0802675798B024097BBAB3601C00CE42C2000E4DC9D007B130002343970890240E0E61750BA00504093BABC4501A0CBDD559B0060067216100072EE4E80BD0900019A1CB844012070F30B285D0028A0495DDE';
wwv_flow_imp.g_varchar2_table(106) := 'A200D0E5EEAA4D003003390B0800397727C0DE0480004D0E5CA20010B8F905942E0014D0A42E6F5100E87277D5260098819C0504809CBB13606F02408026072E510008DCFC024A17000A685297B7280074B9BB6A1300CC40CE020240CEDD09B037012040';
wwv_flow_imp.g_varchar2_table(107) := '9303972800046E7E01A50B000534A9CB5B3CFAD4D3299D3CB160893B7EE117D3AAA54BBB4CA0B68E0A1C9E9D4B5BFFF88F16AE6EC969E9F4F7BCBBA3D52BAB040101A0842E75788FC79EFD663A3933BD6085BF7FFDBF4B17AD5EDD6101A57555E0EB070F';
wwv_flow_imp.g_varchar2_table(108) := 'A5FFF8675F5AB0BC25CB97A795EF7A5757CB575701020240014DEAF2168F3FFF7C3A71F4E88225DEF0633F9E7EEEC20BBB4CA0B68E0A7CFEE9A7D3EFFEC3DF2F58DD69AB56A515E79EDBD1EA95558280005042973ABCC7E97FFAA734B77FFF82159E77C6';
wwv_flow_imp.g_varchar2_table(109) := 'A6F487575E954E5BD26104A5754E60F6E4C9F40BF7DC935E3AB0F06C4F6DD890969D7556E76A57503902024039BDEAE44EE70E1F4ED32FBEB8686DFFF9A77F3A5D79F6399DAC5F51DD14F8DFDFFA56FAF4DFFDEDA2C52DAF9EFD2FAD5E05F02030290101';
wwv_flow_imp.g_varchar2_table(110) := '6052F2AEFBBA40F54CE968F55269EFFF2EF4387DD9F2F43FAEBD365DE07F2C4D4D01024F1E38907EF5CFFF6CF19DFA0060019DECFE160580EEF738FB0AA75F7A29CD55FFA3B9D863CDCAD3D37FFBC99F4A3F7AE6A6ECEBB1C1B8027F55CDF26FFECDDFA4';
wwv_flow_imp.g_varchar2_table(111) := 'A38B7CB0B5A7E3E5FFB8339253E502404EDD08BA9793B3B3E9D833CF0C54FDD91B36A60FBCFB3DE95FBCF3FBD2F7AF5E93564FF98AE040700E6A45E040F555BF6F1C3C90FE7EF7EEF4E5A79E4A7B0F1DEC7F9DEAD9FFCA8B2E4C4B7CBDB5BF95235A1510';
wwv_flow_imp.g_varchar2_table(112) := '005AE5B5F8A00233DF7E39CDEE7B6DD0C31D47A05881A933CE48CBCE3CB3D8FDDB7877040480EEF4B2EC4AAACF001C7BEEB974F2F8F1B2EBB07B028B089CB662655A71FE79292DF1B516833279010160F23DB083EF089C9C9B4BC7AB4F4FF7DE12F020D0';
wwv_flow_imp.g_varchar2_table(113) := '35812553CBD28A0BCEF7D27FD71A5B703D0240C1CDEBE2D64F4E4FA7E32FBC588580992E96A7A6A002BD5FFDEBFDE8CF92A9A9A002CACE514000C8B12BC1F7D47B2560FAC5DDE9C4B1857F21303891F20B1238EDF4D35FFFC53F2FFB17D4B5185B150062';
wwv_flow_imp.g_varchar2_table(114) := 'F4B9C82A675E7925CD56FF78102852A0FAB4FFB24D67A4DE87FE3C08E4282000E4D8157BFAFF02BDCF03CCBCBC37CD555FB5F22050844075E39F5ABF2E4D6DDAE4FDFE221A1677930240DCDE975579F52D81B94387AA2070309D98A93E1F50BD4DD07BAB';
wwv_flow_imp.g_varchar2_table(115) := '60B15F102CAB40BB2D52A0BAD9F7BECF3FFF4FF53EFFD2756BD3527FBDB2C85646DCB40010B1EB6A2640800081F0020240F81100408000010211050480885D57330102040884171000C28F0000020408108828200044ECBA9A0910204020BC8000107E04';
wwv_flow_imp.g_varchar2_table(116) := '0010204080404401012062D7D54C80000102E1050480F023008000010204220A080011BBAE6602040810082F2000841F0100040810201051400088D87535132040804078010120FC0800204080008188020240C4AEAB9900010204C20B0800E147000001';
wwv_flow_imp.g_varchar2_table(117) := '0204084414100022765DCD04081020105E4000083F02000810204020A2800010B1EB6A2640800081F0020240F81100408000010211050480885D57330102040884171000C28F0000020408108828200044ECBA9A0910204020BC8000107E040010204080';
wwv_flow_imp.g_varchar2_table(118) := '404401012062D7D54C80000102E1050480F023008000010204220A080011BBAE6602040810082F2000841F0100040810201051400088D87535132040804078010120FC0800204080008188020240C4AEAB9900010204C20B0800E1470000010204084414';
wwv_flow_imp.g_varchar2_table(119) := '100022765DCD04081020105E4000083F02000810204020A2800010B1EB6A2640800081F0020240F81100408000010211050480885D57330102040884171000C28F0000020408108828200044ECBA9A0910204020BC8000107E0400102040804044010120';
wwv_flow_imp.g_varchar2_table(120) := '62D7D54C80000102E1050480F023008000010204220A080011BBAE6602040810082F2000841F0100040810201051400088D87535132040804078010120FC0800204080008188020240C4AEAB9900010204C20B0800E1470000010204084414100022765D';
wwv_flow_imp.g_varchar2_table(121) := 'CD04081020105E4000083F02000810204020A2800010B1EB6A2640800081F0020240F81100408000010211050480885D57330102040884171000C28F0000020408108828200044ECBA9A0910204020BC8000107E040010204080404401012062D7D54C80';
wwv_flow_imp.g_varchar2_table(122) := '000102E1050480F023008000010204220A080011BBAE6602040810082F2000841F0100040810201051400088D87535132040804078010120FC0800204080008188020240C4AEAB9900010204C20B0800E1470000010204084414100022765DCD04081020';
wwv_flow_imp.g_varchar2_table(123) := '105E4000083F02000810204020A2800010B1EB6A2640800081F0020240F81100408000010211050480885D57330102040884171000C28F0000020408108828200044ECBA9A0910204020BC8000107E040010204080404401012062D7D54C80000102E105';
wwv_flow_imp.g_varchar2_table(124) := '0480F023008000010204220A080011BBAE6602040810082F2000841F0100040810201051400088D87535132040804078010120FC0800204080008188020240C4AEAB9900010204C20B0800E1470000010204084414100022765DCD04081020105E400008';
wwv_flow_imp.g_varchar2_table(125) := '3F02000810204020A2800010B1EB6A2640800081F0020240F81100408000010211050480885D57330102040884171000C28F0000020408108828200044ECBA9A0910204020BC8000107E040010204080404401012062D7D54C80000102E1050480F02300';
wwv_flow_imp.g_varchar2_table(126) := '8000010204220A080011BBAE6602040810082F2000841F0100040810201051400088D87535132040804078010120FC0800204080008188020240C4AEAB9900010204C20B0800E1470000010204084414100022765DCD04081020105E4000083F02000810';
wwv_flow_imp.g_varchar2_table(127) := '204020A2800010B1EB6A2640800081F0020240F81100408000010211050480885D57330102040884171000C28F0000020408108828200044ECBA9A0910204020BC8000107E040010204080404401012062D7D54C80000102E1050480F023008000010204';
wwv_flow_imp.g_varchar2_table(128) := '220A080011BBAE6602040810082F2000841F0100040810201051400088D87535132040804078010120FC0800204080008188020240C4AEAB9900010204C20B0800E1470000010204084414100022765DCD04081020105E4000083F02000810204020A280';
wwv_flow_imp.g_varchar2_table(129) := '0010B1EB6A2640800081F0020240F81100408000010211050480885D57330102040884171000C28F0000020408108828200044ECBA9A0910204020BC8000107E040010204080404401012062D7D54C80000102E1050480F023008000010204220A080011';
wwv_flow_imp.g_varchar2_table(130) := 'BBAE6602040810082F2000841F0100040810201051400088D87535132040804078010120FC0800204080008188020240C4AEAB9900010204C20B0800E1470000010204084414100022765DCD04081020105E4000083F02000810204020A2C0FF0337342F';
wwv_flow_imp.g_varchar2_table(131) := '1ECC72C5570000001064654247363533353034444641374434304138315015E6D40000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(2119895239368194)
,p_file_name=>'icons/app-icon-512.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/security/authorizations/administration_rights
begin
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(2121312219368195)
,p_name=>'Administration Rights'
,p_static_id=>'administration-rights'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'plsql_function_body', 'return true;')).to_clob
,p_error_message=>'Insufficient privileges, user is not an Administrator'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_settings
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs/timeframe_4_weeks
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(2144941522368224)
,p_lov_name=>'TIMEFRAME (4 WEEKS)'
,p_static_id=>'timeframe-4-weeks'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val as seconds',
'  from table( apex_util.get_timeframe_lov_data )',
' order by insert_order'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_return_column_name=>'SECONDS'
,p_display_column_name=>'DISP'
);
end;
/
prompt --application/shared_components/user_interface/lovs/view_as_report_chart
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(2191483086368267)
,p_lov_name=>'VIEW_AS_REPORT_CHART'
,p_static_id=>'view-as-report-chart'
,p_lov_query=>'.'||wwv_flow_imp.id(2191483086368267)||'.'
,p_location=>'STATIC'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(2192178071368268)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Add Chart Page'
,p_lov_return_value=>'CHART'
,p_static_id=>'add-chart-page'
,p_lov_template=>'<span class="fa fa-pie-chart" aria-hidden="true"></span><span class="u-VisuallyHidden">#DISPLAY_VALUE#</span>'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(2191796370368268)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Add Report Page'
,p_lov_return_value=>'REPORT'
,p_static_id=>'add-report-page'
,p_lov_template=>'<span class="fa fa-table" aria-hidden="true"></span><span class="u-VisuallyHidden">#DISPLAY_VALUE#</span>'
);
end;
/
prompt --application/pages/page_groups
begin
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(2121619235368195)
,p_group_name=>'Administration'
,p_static_id=>'administration'
);
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_imp_shared.create_menu(
 p_id=>wwv_flow_imp.id(1923178413368125)
,p_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(2211578417368282)
,p_short_name=>'Administration'
,p_static_id=>'administration'
,p_link=>'f?p=&APP_ID.:10000:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10000
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(1923309847368125)
,p_short_name=>'Home'
,p_static_id=>'home'
,p_link=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.'
,p_page_id=>1
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(2220807616512350)
,p_short_name=>'MS SQL'
,p_static_id=>'ms-sql'
,p_link=>'f?p=&APP_ID.:3:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>3
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(2219374172509940)
,p_short_name=>'Oracle'
,p_static_id=>'oracle'
,p_link=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>2
);
end;
/
prompt --application/shared_components/navigation/breadcrumbentry
begin
null;
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(2096117208368185)
,p_theme_id=>42
,p_static_id=>'universal-theme'
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_version_identifier=>'26.1'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_is_locked=>false
,p_current_theme_style_id=>3546271551760430036
,p_default_page_template=>4073832297226169690
,p_default_dialog_template=>2101883943284197310
,p_error_template=>2102634289808461002
,p_printer_friendly_template=>4073832297226169690
,p_login_template=>2102634289808461002
,p_default_button_template=>4073839297780169708
,p_default_region_template=>4073835273271169698
,p_default_chart_template=>4073835273271169698
,p_default_form_template=>4073835273271169698
,p_default_reportr_template=>4073835273271169698
,p_default_wizard_template=>4073835273271169698
,p_default_menur_template=>2532939663579242476
,p_default_listr_template=>4073835273271169698
,p_default_irr_template=>2102002977963900996
,p_default_report_template=>2540130677583398057
,p_default_label_template=>1610598304472262251
,p_default_menu_template=>4073839682315169711
,p_default_list_template=>4073837480889169704
,p_default_top_nav_list_temp=>2528231041045349458
,p_default_side_nav_list_temp=>2469215554099805162
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>2127905476394690047
,p_default_dialogr_template=>4502917002193490937
,p_default_option_label=>1610598304472262251
,p_default_header_template=>2042159785845301134
,p_default_footer_template=>2042159785845301134
,p_default_required_label=>1610598484065263269
,p_default_navbar_list_template=>2849019392706229583
,p_file_prefix=>nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#APEX_FILES#themes/theme_42/26.1/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_FILES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_FILES#css/Core#MIN#.css?v=#APEX_VERSION#'
,p_reference_id=>wwv_imp_util.get_subscription_id(4073840274158169736,2000,'universal-theme',8842.261)
,p_version_scn=>'SH256:CllwusWU1ZAQekggXaBA4XIqoUUt9hnAaPg9P9xpZ6A'
,p_version_scn_master=>'SH256:WOPVC8vP1TPWUxczh2dJ4mCZcNGSTzA1cn8DjR2oQjY'
,p_updated_on=>wwv_flow_imp.dz('20260623152934Z')
,p_updated_by=>'CHRIS'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
null;
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_options
begin
null;
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/globalization/translations
begin
null;
end;
/
prompt --application/shared_components/logic/build_options
begin
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(1922566708368124)
,p_build_option_name=>'Commented Out'
,p_static_id=>'commented-out'
,p_build_option_status=>'EXCLUDE'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(2120137423368195)
,p_build_option_name=>'Feature: Activity Reporting'
,p_static_id=>'feature-activity-reporting'
,p_build_option_status=>'INCLUDE'
,p_feature_identifier=>'APPLICATION_ACTIVITY_REPORTING'
,p_build_option_comment=>'Include numerous reports and charts on end user activity.'
);
end;
/
prompt --application/shared_components/globalization/messages
begin
null;
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/security/authentications/oracle_apex_accounts
begin
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(1922888328368124)
,p_name=>'Oracle APEX Accounts'
,p_static_id=>'oracle-apex-accounts'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
,p_created_on=>wwv_flow_imp.dz('20260623113532Z')
,p_updated_on=>wwv_flow_imp.dz('20260623113532Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00000
begin
wwv_flow_imp_page.create_page(
 p_id=>0
,p_name=>'Global Page'
,p_reload_on_submit=>null
,p_warn_on_unsaved_changes=>null
,p_autocomplete_on_off=>'OFF'
,p_protection_level=>'D'
,p_page_component_map=>'14'
,p_last_updated_on=>wwv_flow_imp.dz('20260615223335Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(2626264133213301)
,p_name=>'Hide footer on all pages'
,p_static_id=>'hide-footer-on-all-pages'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2626380032213302)
,p_event_id=>wwv_flow_imp.id(2626264133213301)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_static_id=>'native-javascript-code'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'js_code', '$(".t-Footer").hide()')).to_clob
);
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_imp_page.create_page(
 p_id=>1
,p_name=>'DB Inv. - Dashboard'
,p_alias=>'DB-INV-DASHBOARD'
,p_step_title=>'DB Inv. -  Dashboard'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'13'
,p_last_updated_on=>wwv_flow_imp.dz('20260623192647Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2627892261213317)
,p_plug_name=>'Scoring Activity'
,p_static_id=>'compliance'
,p_title=>'Scoring Activity'
,p_region_template_options=>'#DEFAULT#:t-CardsRegion--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2074200852440250129
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select scoring_type,',
'       to_char(last_scoring_date, ''DD/MM/YYYY HH24:MI:SS'') last_scoring_date,',
'       last_scoring_value||''%'' last_scoring_value,',
'       scoring_card_class,',
'       ''fa fa-user'' SCORING_ICON,',
'       scoring_status,',
'       status_color,',
'       scoring_label,',
'       apex_page.get_url( p_page => details_apex_page_number ) details_apex_page_number, scoring_order',
'  from scoring_activity_list;',
''))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'scoring_order asc'
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CARDS'
,p_plug_query_num_rows_type=>'SCROLL'
,p_show_total_row_count=>false
,p_created_on=>wwv_flow_imp.dz('20260623164853Z')
,p_updated_on=>wwv_flow_imp.dz('20260623192647Z')
,p_created_by=>'CHRIS'
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_card(
 p_id=>wwv_flow_imp.id(2627952034213318)
,p_region_id=>wwv_flow_imp.id(2627892261213317)
,p_layout_type=>'GRID'
,p_grid_column_count=>4
,p_card_css_classes=>'&SCORING_CARD_CLASS.'
,p_title_adv_formatting=>false
,p_title_column_name=>'SCORING_TYPE'
,p_sub_title_adv_formatting=>false
,p_body_adv_formatting=>false
,p_body_column_name=>'SCORING_LABEL'
,p_second_body_adv_formatting=>false
,p_second_body_column_name=>'LAST_SCORING_DATE'
,p_badge_column_name=>'LAST_SCORING_VALUE'
,p_badge_label=>'&SCORING_STATUS.'
,p_badge_css_classes=>'&STATUS_COLOR.'
,p_media_adv_formatting=>false
,p_pk1_column_name=>'SCORING_TYPE'
,p_updated_on=>wwv_flow_imp.dz('20260623192647Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_card_action(
 p_id=>wwv_flow_imp.id(2628055860213319)
,p_card_id=>wwv_flow_imp.id(2627952034213318)
,p_action_type=>'FULL_CARD'
,p_display_sequence=>10
,p_static_id=>'action'
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'&DETAILS_APEX_PAGE_NUMBER.'
,p_updated_on=>wwv_flow_imp.dz('20260623192647Z')
,p_updated_by=>'CHRIS'
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_imp_page.create_page(
 p_id=>2
,p_name=>'DB Inv. - Oracle'
,p_alias=>'DB-INV-ORACLE'
,p_step_title=>'DB Inv. - Oracle'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
,p_last_updated_on=>wwv_flow_imp.dz('20260623121725Z')
,p_last_updated_by=>'CHRIS'
);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_imp_page.create_page(
 p_id=>3
,p_name=>'DB Inv. - MSSQL'
,p_alias=>'DB-INV-MSSQL'
,p_step_title=>'DB Inv. - MSSQL'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
,p_last_updated_on=>wwv_flow_imp.dz('20260623121322Z')
,p_last_updated_by=>'CHRIS'
);
end;
/
prompt --application/pages/page_00004
begin
wwv_flow_imp_page.create_page(
 p_id=>4
,p_name=>'DB Inv. - Postgres'
,p_alias=>'DB-INV-POSTGRES'
,p_step_title=>'DB Inv. - Postgres'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
,p_last_updated_on=>wwv_flow_imp.dz('20260623121350Z')
,p_last_updated_by=>'CHRIS'
);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_imp_page.create_page(
 p_id=>5
,p_name=>'DB Inv. - MySQL'
,p_alias=>'DB-INV-MYSQL'
,p_step_title=>'DB Inv. - MySQL'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
,p_last_updated_on=>wwv_flow_imp.dz('20260623121433Z')
,p_last_updated_by=>'CHRIS'
);
end;
/
prompt --application/pages/page_00006
begin
wwv_flow_imp_page.create_page(
 p_id=>6
,p_name=>'DB Inv. - MongoDB'
,p_alias=>'DB-INV-MONGODB'
,p_step_title=>'DB Inv. - MongoDB'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
,p_created_on=>wwv_flow_imp.dz('20260623192841Z')
,p_last_updated_on=>wwv_flow_imp.dz('20260623192841Z')
,p_created_by=>'CHRIS'
,p_last_updated_by=>'CHRIS'
);
end;
/
prompt --application/pages/page_09999
begin
wwv_flow_imp_page.create_page(
 p_id=>9999
,p_name=>'DB Inv. - Login Page'
,p_alias=>'LOGIN'
,p_step_title=>'Databases Inventory - Log In'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>2102634289808461002
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'12'
,p_last_updated_on=>wwv_flow_imp.dz('20260623152624Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2122336227368196)
,p_plug_name=>'Databases Inventory'
,p_static_id=>'databases-inventory'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2675634334296186762
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_region_image=>'#APP_FILES#icons/app-icon-512.png'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2124426377368198)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(2122336227368196)
,p_button_name=>'LOGIN'
,p_static_id=>'login'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Sign In'
,p_button_position=>'NEXT'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2123254171368197)
,p_name=>'P9999_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(2122336227368196)
,p_prompt=>'Password'
,p_placeholder=>'Password'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>2042262243893469891
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'submit_when_enter_pressed', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2124024642368197)
,p_name=>'P9999_PERSISTENT_AUTH'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(2122336227368196)
,p_prompt=>'Remember me'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_label_alignment=>'RIGHT'
,p_display_when=>'apex_authentication.persistent_auth_enabled'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>2042262243893469891
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2123630658368197)
,p_name=>'P9999_REMEMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(2122336227368196)
,p_prompt=>'Remember username'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_label_alignment=>'RIGHT'
,p_display_when=>'apex_authentication.persistent_cookies_enabled and not apex_authentication.persistent_auth_enabled'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>2042262243893469891
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2122818745368197)
,p_name=>'P9999_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(2122336227368196)
,p_prompt=>'Username'
,p_placeholder=>'Username'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>2042262243893469891
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(2126081847368198)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_static_id=>'clear-page-s-cache'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'type', 'CLEAR_CACHE_CURRENT_PAGE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>2126081847368198
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(2125638205368198)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_static_id=>'get-username-cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P9999_USERNAME := apex_authentication.get_login_username_cookie;',
':P9999_REMEMBER := case when :P9999_USERNAME is not null then ''Y'' end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>2125638205368198
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(2124800146368198)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_static_id=>'login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P9999_USERNAME,',
'    p_password => :P9999_PASSWORD,',
'    p_set_persistent_auth => nvl(:P9999_PERSISTENT_AUTH, ''N'') = ''Y'' );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>2124800146368198
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(2125261495368198)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_static_id=>'set-username-cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P9999_USERNAME),',
'    p_consent  => :P9999_REMEMBER = ''Y'' );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>2125261495368198
);
end;
/
prompt --application/pages/page_10000
begin
wwv_flow_imp_page.create_page(
 p_id=>10000
,p_name=>'DB Inv. - Administration'
,p_alias=>'DB-INV-ADMIN'
,p_step_title=>'DB Inv. - Administration'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(2121619235368195)
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(2121312219368195)
,p_protection_level=>'C'
,p_deep_linking=>'N'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The administration page allows application owners (Administrators) to configure the application and maintain common data used across the application.',
'By selecting one of the available settings, administrators can potentially change how the application is displayed and/or features available to the end users.</p>',
'<p>Access to this page should be limited to Administrators only.</p>'))
,p_page_component_map=>'11'
,p_last_updated_on=>wwv_flow_imp.dz('20260623121512Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2214452784368283)
,p_plug_name=>'Parameters'
,p_static_id=>'parameters'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3372714138756020509
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
end;
/
prompt --application/pages/page_10001
begin
wwv_flow_imp_page.create_page(
 p_id=>10001
,p_name=>'DB Inv. - Activity Reports'
,p_alias=>'DB-INV-ACTIVITY-REPORTS'
,p_step_title=>'DB Inv. - Activity Reports'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(2121619235368195)
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(2121312219368195)
,p_protection_level=>'C'
,p_deep_linking=>'N'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The administration page allows application owners (Administrators) to configure the application and maintain common data used across the application.',
'By selecting one of the available settings, administrators can potentially change how the application is displayed and/or features available to the end users.</p>',
'<p>Access to this page should be limited to Administrators only.</p>'))
,p_page_component_map=>'06'
,p_last_updated_on=>wwv_flow_imp.dz('20260623121835Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(4820833566483037)
,p_plug_name=>'Activity Reports'
,p_static_id=>'activity-reports'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3372714138756020509
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(4821183498483037)
,p_plug_name=>'Activity Reports'
,p_static_id=>'activity-reports-2'
,p_parent_plug_id=>wwv_flow_imp.id(4820833566483037)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>60
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_list_id=>wwv_flow_imp.id(2211744440368282)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>2069471208528591807
,p_required_patch=>wwv_flow_imp.id(2120137423368195)
);
end;
/
prompt --application/pages/page_10010
begin
wwv_flow_imp_page.create_page(
 p_id=>10010
,p_name=>'Activity Dashboard'
,p_alias=>'ACTIVITY-DASHBOARD'
,p_page_mode=>'MODAL'
,p_step_title=>'Activity Dashboard'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(2121619235368195)
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_required_role=>wwv_flow_imp.id(2121312219368195)
,p_required_patch=>wwv_flow_imp.id(2120137423368195)
,p_protection_level=>'C'
,p_page_component_map=>'03'
,p_last_updated_on=>wwv_flow_imp.dz('20260614162351Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2128676811368200)
,p_plug_name=>'Filters'
,p_static_id=>'filters'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noUI:t-Form--large'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2127877352368200)
,p_plug_name=>'Hourly Page Events'
,p_static_id=>'hourly-page-events'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h320:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(2127962494368200)
,p_region_id=>wwv_flow_imp.id(2127877352368200)
,p_chart_type=>'bar'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>false
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_time_axis_type=>'enabled'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(2130013428368201)
,p_chart_id=>wwv_flow_imp.id(2127962494368200)
,p_static_id=>'series'
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with nw as (',
'    -- APEX_ACTIVITY_LOG uses dates; convert system time to local time zone.',
'    select from_tz( cast( sysdate as timestamp ), to_char( systimestamp, ''TZR'' ) ) at local as tm from dual',
'),',
'window as (',
'    select',
'         trunc(nw.tm - ((level-1)/24),''HH'') start_tm,',
'         trunc(nw.tm - ((level-2)/24),''HH'') end_tm,',
'         trunc(sysdate-((level-1)/24),''HH'') log_start_tm,',
'         trunc(sysdate-((level-2)/24),''HH'') log_end_tm',
'    from nw',
'    connect by level <= round( 24 * ( 1/24/60/60 * nvl(:P10010_TIMEFRAME,1) ) )',
')',
'select w.start_tm log_time,',
'       ( select count(*)',
'           from apex_activity_log l',
'          where l.flow_id = :app_id',
'            and l.time_stamp between w.log_start_tm and w.log_end_tm ) as value',
'from window w',
'order by 1'))
,p_max_row_count=>350
,p_ajax_items_to_submit=>'P10010_TIMEFRAME'
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LOG_TIME'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(2131230535368201)
,p_chart_id=>wwv_flow_imp.id(2127962494368200)
,p_static_id=>'x'
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_type=>'datetime-short'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'on'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(2130629723368201)
,p_chart_id=>wwv_flow_imp.id(2127962494368200)
,p_static_id=>'y'
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(2128562745368200)
,p_name=>'Latest Activity'
,p_static_id=>'latest-activity'
,p_template=>4073835273271169698
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--inline'
,p_new_grid_row=>false
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select userid_lc       as username,',
'       max(time_stamp) as last_activity',
'  from apex_activity_log',
' where flow_id     = :app_id',
'   and time_stamp >= sysdate - ( 1/24/60/60 * :P10010_TIMEFRAME )',
'   and userid_lc  is not null',
' group by userid_lc',
' order by 2 desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P10010_TIMEFRAME'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>20
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No activities found'
,p_query_row_count_max=>500
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2140853251368218)
,p_query_column_id=>2
,p_column_alias=>'LAST_ACTIVITY'
,p_column_display_sequence=>2
,p_column_heading=>'Last Activity'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2140459532368218)
,p_query_column_id=>1
,p_column_alias=>'USERNAME'
,p_column_display_sequence=>1
,p_column_heading=>'Username'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2128064089368200)
,p_plug_name=>'Most Active Pages'
,p_static_id=>'most-active-pages'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h320:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(2128127213368200)
,p_region_id=>wwv_flow_imp.id(2128064089368200)
,p_chart_type=>'bar'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>false
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(2135064828368203)
,p_chart_id=>wwv_flow_imp.id(2128127213368200)
,p_static_id=>'series'
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.step_id||''. ''||(select page_name from apex_application_pages p where p.application_id = :app_id and page_id = x.step_id) label, ',
'        value',
'from ( select step_id,',
'              count(*) as value',
'         from apex_activity_log',
'        where flow_id = :app_id',
'          and time_stamp >= sysdate - ( 1/24/60/60 * :P10010_TIMEFRAME )',
'          and step_id is not null',
'        group by step_id',
'        order by 2 desc',
'     ) x'))
,p_max_row_count=>10
,p_ajax_items_to_submit=>'P10010_TIMEFRAME'
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(2135690862368203)
,p_chart_id=>wwv_flow_imp.id(2128127213368200)
,p_static_id=>'x'
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(2136224154368203)
,p_chart_id=>wwv_flow_imp.id(2128127213368200)
,p_static_id=>'y'
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(2128413106368200)
,p_name=>'Recent Errors'
,p_static_id=>'recent-errors'
,p_template=>4073835273271169698
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--inline'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sqlerrm    label,',
'       time_stamp value',
'  from apex_activity_log',
' where flow_id    = :app_id',
'   and time_stamp >= sysdate - ( 1/24/60/60 * :P10010_TIMEFRAME )',
'   and sqlerrm    is not null',
' order by 2 desc, 1'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P10010_TIMEFRAME'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>20
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No data found.'
,p_query_row_count_max=>500
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2137336695368206)
,p_query_column_id=>1
,p_column_alias=>'LABEL'
,p_column_display_sequence=>1
,p_column_heading=>'Label'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2137675469368206)
,p_query_column_id=>2
,p_column_alias=>'VALUE'
,p_column_display_sequence=>2
,p_column_heading=>'Value'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2128210750368200)
,p_plug_name=>'Top Users'
,p_static_id=>'top-users'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h320:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(2128371979368200)
,p_region_id=>wwv_flow_imp.id(2128210750368200)
,p_chart_type=>'bar'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>false
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(2132573716368202)
,p_chart_id=>wwv_flow_imp.id(2128371979368200)
,p_static_id=>'series'
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl( userid_lc, apex_lang.message(''APEX.FEATURE.TOP_USERS.USERNAME.NOT_IDENTIFIED'') ) as label,',
'       count(*) as value',
'from apex_activity_log',
'where flow_id = :app_id',
'and time_stamp >= sysdate - ( 1/24/60/60 * :P10010_TIMEFRAME )',
'group by nvl( userid_lc, apex_lang.message(''APEX.FEATURE.TOP_USERS.USERNAME.NOT_IDENTIFIED'') )',
'order by 2 desc'))
,p_max_row_count=>10
,p_ajax_items_to_submit=>'P10010_TIMEFRAME'
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(2133186267368202)
,p_chart_id=>wwv_flow_imp.id(2128371979368200)
,p_static_id=>'x'
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(2133797945368202)
,p_chart_id=>wwv_flow_imp.id(2128371979368200)
,p_static_id=>'y'
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2143111489368223)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(2127877352368200)
,p_button_name=>'VIEW_ACTIVITY_BY_USER'
,p_static_id=>'view-activity-by-user'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2350584059425431644
,p_button_image_alt=>'View Details'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10011:&SESSION.::&DEBUG.:RP,10011::'
,p_icon_css_classes=>'fa-angle-right'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2143994135368223)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(2128210750368200)
,p_button_name=>'VIEW_ACTIVITY_BY_USER'
,p_static_id=>'view-activity-by-user-2'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2350584059425431644
,p_button_image_alt=>'View Details'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10011:&SESSION.::&DEBUG.:RP,10011::'
,p_icon_css_classes=>'fa-angle-right'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2143554675368223)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(2128064089368200)
,p_button_name=>'VIEW_ACTIVITY_DETAILS'
,p_static_id=>'view-activity-details'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2350584059425431644
,p_button_image_alt=>'View Details'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10014:&SESSION.::&DEBUG.:RP,10014::'
,p_icon_css_classes=>'fa-angle-right'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2144306902368223)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(2128413106368200)
,p_button_name=>'VIEW_RECENT_ERRORS'
,p_static_id=>'view-recent-errors'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2350584059425431644
,p_button_image_alt=>'View Details'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:10012:&SESSION.::&DEBUG.:RP,10012::'
,p_icon_css_classes=>'fa-angle-right'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2128789967368200)
,p_name=>'P10010_TIMEFRAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(2128676811368200)
,p_item_default=>'900'
,p_prompt=>'Timeframe'
,p_source=>'900'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'TIMEFRAME (4 WEEKS)'
,p_cHeight=>1
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(2128896693368200)
,p_name=>'Change Filters'
,p_static_id=>'change-filters'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10010_TIMEFRAME'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2145958778368225)
,p_event_id=>wwv_flow_imp.id(2128896693368200)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(2127877352368200)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2146481738368225)
,p_event_id=>wwv_flow_imp.id(2128896693368200)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh-2'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(2128210750368200)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2146924925368225)
,p_event_id=>wwv_flow_imp.id(2128896693368200)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh-3'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(2128064089368200)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2147414451368225)
,p_event_id=>wwv_flow_imp.id(2128896693368200)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh-4'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(2128413106368200)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2147919873368225)
,p_event_id=>wwv_flow_imp.id(2128896693368200)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh-5'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(2128562745368200)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
end;
/
prompt --application/pages/page_10011
begin
wwv_flow_imp_page.create_page(
 p_id=>10011
,p_name=>'Top Users'
,p_alias=>'TOP-USERS'
,p_page_mode=>'MODAL'
,p_step_title=>'Top Users'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(2121619235368195)
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.hour-graph { display: table; width: 100%; }',
'span.hour { display: table-cell; padding: 0; font-size: 11px; text-align: center; min-width: 32px; }',
'span.hour-label { opacity: 0.5; }',
'span.hour-value { display: block; }',
'span.hour { background-color: var(--ut-palette-success); color:  var(--ut-palette-success-contrast); }',
'span.hour.is-null { background-color: var(--ut-component-highlight-background-color); color: var(--ut-component-text-default-color); }',
'span.hour.is-over1k { background-color: var(--ut-palette-primary); color:  var(--ut-palette-primary-contrast); }'))
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_imp.id(2121312219368195)
,p_required_patch=>wwv_flow_imp.id(2120137423368195)
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Use this report and chart to see the users with the most page views for the specified timeframe.</p>',
'<p>Select the reporting timeframe (Default = 1 day) and choose between the report and chart icons at the top of the page.</p>',
'<p>For the interactive report, use the search field, or select the <strong>User</strong> column heading, to select a specific user. You can perform numerous functions by clicking the <strong>Actions</strong> button, such as columns displayed / hidden'
||', rows per page, filter, and so forth. Click the <strong>Reset</strong> button to reset the interactive report back to the default settings.</p>'))
,p_page_component_map=>'18'
,p_last_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2180058125368252)
,p_plug_name=>'Buttons'
,p_static_id=>'buttons'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noUI:t-Form--large'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2179938950368252)
,p_plug_name=>'Top Users'
,p_static_id=>'top-users'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select the_user,',
'    ''<div class="hour-graph">''||',
'        ''<span class="hour''|| case when h00 = 0 then '' is-null'' when h00 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 0</span> <span class="hour-value">''|| ',
'        case when h00 > 999 then to_char((h00/1000),''99999999D0'') ||''k'' else to_char(h00) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h01 = 0 then '' is-null'' when h01 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 1</span> <span class="hour-value">''|| ',
'        case when h01 > 999 then to_char((h01/1000),''99999999D0'') ||''k'' else to_char(h01) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h02 = 0 then '' is-null'' when h02 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 2</span> <span class="hour-value">''|| ',
'        case when h02 > 999 then to_char((h02/1000),''99999999D0'') ||''k'' else to_char(h02) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h03 = 0 then '' is-null'' when h03 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 3</span> <span class="hour-value">''|| ',
'        case when h03 > 999 then to_char((h03/1000),''99999999D0'') ||''k'' else to_char(h03) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h04 = 0 then '' is-null'' when h04 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 4</span> <span class="hour-value">''|| ',
'        case when h04 > 999 then to_char((h04/1000),''99999999D0'') ||''k'' else to_char(h04) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h05 = 0 then '' is-null'' when h05 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 5</span> <span class="hour-value">''|| ',
'        case when h05 > 999 then to_char((h05/1000),''99999999D0'') ||''k'' else to_char(h05) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h06 = 0 then '' is-null'' when h06 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 6</span> <span class="hour-value">''|| ',
'        case when h06 > 999 then to_char((h06/1000),''99999999D0'') ||''k'' else to_char(h06) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h07 = 0 then '' is-null'' when h07 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 7</span> <span class="hour-value">''|| ',
'        case when h07 > 999 then to_char((h07/1000),''99999999D0'') ||''k'' else to_char(h07) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h08 = 0 then '' is-null'' when h08 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 8</span> <span class="hour-value">''|| ',
'        case when h08 > 999 then to_char((h08/1000),''99999999D0'') ||''k'' else to_char(h08) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h09 = 0 then '' is-null'' when h09 > 999 then '' is-over1k'' end ||''"><span class="hour-label"> 9</span> <span class="hour-value">''|| ',
'        case when h09 > 999 then to_char((h09/1000),''99999999D0'') ||''k'' else to_char(h09) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h10 = 0 then '' is-null'' when h10 > 999 then '' is-over1k'' end ||''"><span class="hour-label">10</span> <span class="hour-value">''|| ',
'        case when h10 > 999 then to_char((h10/1000),''99999999D0'') ||''k'' else to_char(h10) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h11 = 0 then '' is-null'' when h11 > 999 then '' is-over1k'' end ||''"><span class="hour-label">11</span> <span class="hour-value">''|| ',
'        case when h11 > 999 then to_char((h11/1000),''99999999D0'') ||''k'' else to_char(h11) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h12 = 0 then '' is-null'' when h12 > 999 then '' is-over1k'' end ||''"><span class="hour-label">12</span> <span class="hour-value">''|| ',
'        case when h12 > 999 then to_char((h12/1000),''99999999D0'') ||''k'' else to_char(h12) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h13 = 0 then '' is-null'' when h13 > 999 then '' is-over1k'' end ||''"><span class="hour-label">13</span> <span class="hour-value">''|| ',
'        case when h13 > 999 then to_char((h13/1000),''99999999D0'') ||''k'' else to_char(h13) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h14 = 0 then '' is-null'' when h14 > 999 then '' is-over1k'' end ||''"><span class="hour-label">14</span> <span class="hour-value">''|| ',
'        case when h14 > 999 then to_char((h14/1000),''99999999D0'') ||''k'' else to_char(h14) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h15 = 0 then '' is-null'' when h15 > 999 then '' is-over1k'' end ||''"><span class="hour-label">15</span> <span class="hour-value">''|| ',
'        case when h15 > 999 then to_char((h15/1000),''99999999D0'') ||''k'' else to_char(h15) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h16 = 0 then '' is-null'' when h16 > 999 then '' is-over1k'' end ||''"><span class="hour-label">16</span> <span class="hour-value">''|| ',
'        case when h16 > 999 then to_char((h16/1000),''99999999D0'') ||''k'' else to_char(h16) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h17 = 0 then '' is-null'' when h17 > 999 then '' is-over1k'' end ||''"><span class="hour-label">17</span> <span class="hour-value">''|| ',
'        case when h17 > 999 then to_char((h17/1000),''99999999D0'') ||''k'' else to_char(h17) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h18 = 0 then '' is-null'' when h18 > 999 then '' is-over1k'' end ||''"><span class="hour-label">18</span> <span class="hour-value">''|| ',
'        case when h18 > 999 then to_char((h18/1000),''99999999D0'') ||''k'' else to_char(h18) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h19 = 0 then '' is-null'' when h19 > 999 then '' is-over1k'' end ||''"><span class="hour-label">19</span> <span class="hour-value">''|| ',
'        case when h19 > 999 then to_char((h19/1000),''99999999D0'') ||''k'' else to_char(h19) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h20 = 0 then '' is-null'' when h20 > 999 then '' is-over1k'' end ||''"><span class="hour-label">20</span> <span class="hour-value">''|| ',
'        case when h20 > 999 then to_char((h20/1000),''99999999D0'') ||''k'' else to_char(h20) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h21 = 0 then '' is-null'' when h21 > 999 then '' is-over1k'' end ||''"><span class="hour-label">21</span> <span class="hour-value">''|| ',
'        case when h21 > 999 then to_char((h21/1000),''99999999D0'') ||''k'' else to_char(h21) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h22 = 0 then '' is-null'' when h22 > 999 then '' is-over1k'' end ||''"><span class="hour-label">22</span> <span class="hour-value">''|| ',
'        case when h22 > 999 then to_char((h22/1000),''99999999D0'') ||''k'' else to_char(h22) end ||''</span></span>''||',
'        ''<span class="hour''|| case when h23 = 0 then '' is-null'' when h23 > 999 then '' is-over1k'' end ||''"><span class="hour-label">23</span> <span class="hour-value">''|| ',
'        case when h23 > 999 then to_char((h23/1000),''99999999D0'') ||''k'' else to_char(h23) end ||''</span></span>''||',
'        ''</div>'' hours,',
'        page_events,',
'    median_elapsed,',
'    rows_fetched,',
'    ir_searches,',
'    errors,',
'    most_recent',
'    from (  ',
'    select userid_lc                    as the_user,',
'        count(*)                        as page_events,',
'        median(elap)                    as median_elapsed,',
'        sum(num_rows)                   as rows_fetched,',
'        sum(decode(ir_search,null,0,1)) as ir_searches,',
'        sum(decode(sqlerrm,null,0,1))   as errors,',
'        max(time_stamp)                 as most_recent,',
'        sum(decode(to_char(time_stamp,''HH24''),0,1,0)) h00,',
'        sum(decode(to_char(time_stamp,''HH24''),1,1,0)) h01,',
'        sum(decode(to_char(time_stamp,''HH24''),2,1,0)) h02,',
'        sum(decode(to_char(time_stamp,''HH24''),3,1,0)) h03,',
'        sum(decode(to_char(time_stamp,''HH24''),4,1,0)) h04,',
'        sum(decode(to_char(time_stamp,''HH24''),5,1,0)) h05,',
'        sum(decode(to_char(time_stamp,''HH24''),6,1,0)) h06,',
'        sum(decode(to_char(time_stamp,''HH24''),7,1,0)) h07,',
'        sum(decode(to_char(time_stamp,''HH24''),8,1,0)) h08,',
'        sum(decode(to_char(time_stamp,''HH24''),9,1,0)) h09,',
'        sum(decode(to_char(time_stamp,''HH24''),10,1,0)) h10,',
'        sum(decode(to_char(time_stamp,''HH24''),11,1,0)) h11,',
'        sum(decode(to_char(time_stamp,''HH24''),12,1,0)) h12,',
'        sum(decode(to_char(time_stamp,''HH24''),13,1,0)) h13,',
'        sum(decode(to_char(time_stamp,''HH24''),14,1,0)) h14,',
'        sum(decode(to_char(time_stamp,''HH24''),15,1,0)) h15,',
'        sum(decode(to_char(time_stamp,''HH24''),16,1,0)) h16,',
'        sum(decode(to_char(time_stamp,''HH24''),17,1,0)) h17,',
'        sum(decode(to_char(time_stamp,''HH24''),18,1,0)) h18,',
'        sum(decode(to_char(time_stamp,''HH24''),19,1,0)) h19,',
'        sum(decode(to_char(time_stamp,''HH24''),20,1,0)) h20,',
'        sum(decode(to_char(time_stamp,''HH24''),21,1,0)) h21,',
'        sum(decode(to_char(time_stamp,''HH24''),22,1,0)) h22,',
'        sum(decode(to_char(time_stamp,''HH24''),23,1,0)) h23',
'    from apex_activity_log l',
'    where flow_id = :APP_ID',
'        and time_stamp >= sysdate - ( 1/24/60/60 * :P10011_TIMEFRAME )',
'        and userid is not null',
'    group by userid_lc) x'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P10011_TIMEFRAME'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P10011_VIEW_AS'
,p_plug_display_when_cond2=>'REPORT'
,p_prn_page_header=>'Top Users'
,p_ai_enabled=>false
,p_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(2181060179368252)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>2181060179368252
,p_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2183846821368258)
,p_db_column_name=>'ERRORS'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Errors'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2181869902368257)
,p_db_column_name=>'HOURS'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Activity by Hour'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2183424879368258)
,p_db_column_name=>'IR_SEARCHES'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'IR Search'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2182658826368257)
,p_db_column_name=>'MEDIAN_ELAPSED'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Median Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D0000'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2184292522368259)
,p_db_column_name=>'MOST_RECENT'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Most_Recent'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2182212771368257)
,p_db_column_name=>'PAGE_EVENTS'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Page Events'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2183060007368258)
,p_db_column_name=>'ROWS_FETCHED'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Rows Fetched'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2181467179368256)
,p_db_column_name=>'THE_USER'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'User'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(2187369608368265)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'21874'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'THE_USER:HOURS:PAGE_EVENTS'
,p_sort_column_1=>'PAGE_EVENTS'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'MOST_RECENT'
,p_sort_direction_2=>'DESC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2180219265368252)
,p_plug_name=>'Top Users Chart'
,p_static_id=>'top-users-chart'
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--hiddenOverflow'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>30
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P10011_VIEW_AS'
,p_plug_display_when_cond2=>'CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(2180326729368252)
,p_region_id=>wwv_flow_imp.id(2180219265368252)
,p_chart_type=>'donut'
,p_height=>'600'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_format_type=>'decimal'
,p_value_decimal_places=>0
,p_value_format_scaling=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_pie_other_threshold=>.02
,p_pie_selection_effect=>'highlight'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function( options ){ ',
'',
'    this.pieSliceLabel = function(dataContext) {',
'        var series_name,',
'            percent = Math.round(dataContext.value/dataContext.totalValue*100);',
'        ',
'        if ( dataContext.seriesData ) {',
'            series_name = dataContext.seriesData.name;',
'        } else {',
'            series_name = ''Other'';',
'        }',
'        return series_name + " " + percent + "% ( " + dataContext.value + " )";',
'    }',
'    ',
'    // Set chart initialization options ',
'    options.dataLabel = pieSliceLabel; ',
'    return options; ',
'}'))
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(2190927943368267)
,p_chart_id=>wwv_flow_imp.id(2180326729368252)
,p_static_id=>'series'
,p_seq=>10
,p_name=>'Series 1'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select userid_lc as userid,',
'       count(*) as page_views',
'  from apex_activity_log',
' where flow_id     = :app_id',
'   and time_stamp >= sysdate - ( 1/24/60/60 * :P10011_TIMEFRAME )',
'   and userid     is not null',
' group by userid_lc',
' order by 2'))
,p_ajax_items_to_submit=>'P10011_TIMEFRAME'
,p_series_type=>'donut'
,p_items_value_column_name=>'PAGE_VIEWS'
,p_items_label_column_name=>'USERID'
,p_items_label_rendered=>true
,p_items_label_position=>'outsideSlice'
,p_items_label_display_as=>'LABEL'
,p_threshold_display=>'onIndicator'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2188267685368266)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(2179938950368252)
,p_button_name=>'RESET_REPORT'
,p_static_id=>'reset-report'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2180629488368252)
,p_name=>'P10011_TIMEFRAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(2180058125368252)
,p_item_default=>'900'
,p_prompt=>'Timeframe'
,p_source=>'900'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'TIMEFRAME (4 WEEKS)'
,p_cHeight=>1
,p_field_template=>2320077351817916916
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2180418949368252)
,p_name=>'P10011_VIEW_AS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(2180058125368252)
,p_item_default=>'REPORT'
,p_prompt=>'View As'
,p_source=>'REPORT'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'VIEW_AS_REPORT_CHART'
,p_field_template=>2042262243893469891
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_escape_on_http_output=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'number_of_columns', '2',
  'page_action_on_selection', 'SUBMIT')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(2180107283368252)
,p_name=>'Refresh Report'
,p_static_id=>'refresh-report'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10011_TIMEFRAME'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2189514879368267)
,p_event_id=>wwv_flow_imp.id(2180107283368252)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(2179938950368252)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2192964398368268)
,p_event_id=>wwv_flow_imp.id(2180107283368252)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh-2'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(2179938950368252)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
end;
/
prompt --application/pages/page_10012
begin
wwv_flow_imp_page.create_page(
 p_id=>10012
,p_name=>'Application Error Log'
,p_alias=>'APPLICATION-ERROR-LOG'
,p_page_mode=>'MODAL'
,p_step_title=>'Application Error Log'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(2121619235368195)
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_imp.id(2121312219368195)
,p_required_patch=>wwv_flow_imp.id(2120137423368195)
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page provides an interactive report of all unexpected errors logged by this application.</p>',
'<p>Click on the column headings to sort and filter data, or click on the <strong>Actions</strong> button to customize column display and many additional advanced features. Click the <strong>Reset</strong> button to reset the interactive report back t'
||'o the default settings.</p>'))
,p_page_component_map=>'18'
,p_last_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2173218888368248)
,p_plug_name=>'Application Error Log'
,p_static_id=>'application-error-log'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select step_id,',
'       userid,',
'       time_stamp err_time,',
'       sqlerrm,',
'       sqlerrm_component_type,',
'       sqlerrm_component_name',
'  from apex_activity_log',
' where flow_id = :app_id',
'   and sqlerrm is not null'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Application Error Log'
,p_ai_enabled=>false
,p_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(2173804807368248)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>2173804807368248
,p_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2175011262368249)
,p_db_column_name=>'ERR_TIME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Err Time'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2175439132368249)
,p_db_column_name=>'SQLERRM'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Error'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2176271215368250)
,p_db_column_name=>'SQLERRM_COMPONENT_NAME'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Component Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2175810837368249)
,p_db_column_name=>'SQLERRM_COMPONENT_TYPE'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Context'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2174293104368249)
,p_db_column_name=>'STEP_ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Page'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2174644742368249)
,p_db_column_name=>'USERID'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'User'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(2178793718368251)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'21788'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'STEP_ID:USERID:ERR_TIME:SQLERRM:SQLERRM_COMPONENT_TYPE:SQLERRM_COMPONENT_NAME'
,p_sort_column_1=>'ERROR_TIME'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2179634864368252)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(2173218888368248)
,p_button_name=>'RESET_REPORT'
,p_static_id=>'reset-report'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
end;
/
prompt --application/pages/page_10013
begin
wwv_flow_imp_page.create_page(
 p_id=>10013
,p_name=>'Page Performance'
,p_alias=>'PAGE-PERFORMANCE'
,p_page_mode=>'MODAL'
,p_step_title=>'Page Performance'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(2121619235368195)
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_imp.id(2121312219368195)
,p_required_patch=>wwv_flow_imp.id(2120137423368195)
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page provides an interactive report of the page performance and popularity. The report is ordered by <strong>Weighted Performance</strong> which is calculated by multiplying the Median Elapsed time and number of Page Views.</p>',
'<p>Select the reporting timeframe (Default = 1 day) at the top of the page as necessary.<br>',
'Click on the column headings to sort and filter data, or click on the <strong>Actions</strong> button to customize column display and many additional advanced features. Click the <strong>Reset</strong> button to reset the interactive report back to t'
||'he default settings.</p>'))
,p_page_component_map=>'18'
,p_last_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2159515404368237)
,p_plug_name=>'Buttons'
,p_static_id=>'buttons'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noUI:t-Form--large'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2159418509368237)
,p_plug_name=>'Page Performance'
,p_static_id=>'page-performance'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select step_id page,',
'    (   select page_name',
'        from apex_application_pages p',
'        where p.page_id = l.step_id',
'            and p.application_id = :app_id ) page_name,',
'    median(elap)                   median_elapsed,',
'    count(*) * median(elap)        weighted_performance,',
'    sum(decode(sqlerrm,null,0,1))  errors,',
'    count(distinct userid)         distinct_users,',
'    count(distinct session_id)     application_sessions,',
'    count(*)                       page_views,',
'    max(elap)                      max_elapsed,',
'    sum(nvl(num_rows,0))           total_rows,',
'    sum(decode(page_mode,''P'',1,0)) partial_page_views,',
'    sum(decode(page_mode,''D'',1,0)) full_page_views,',
'    min(elap)                      min_elapsed,',
'    avg(elap)                      avg_elapsed',
'from apex_activity_log l',
'where flow_id = :app_id',
'    and time_stamp >= sysdate - ( 1/24/60/60 * :P10013_TIMEFRAME )',
'    and userid is not null',
'group by step_id'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P10013_TIMEFRAME'
,p_prn_page_header=>'Page Performance'
,p_ai_enabled=>false
,p_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(2160057970368237)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>2160057970368237
,p_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2162807424368242)
,p_db_column_name=>'APPLICATION_SESSIONS'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Application Sessions'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2165668168368244)
,p_db_column_name=>'AVG_ELAPSED'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Avg Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D9999'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2162430323368242)
,p_db_column_name=>'DISTINCT_USERS'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Distinct Users'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2162000275368242)
,p_db_column_name=>'ERRORS'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Errors'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2164808749368243)
,p_db_column_name=>'FULL_PAGE_VIEWS'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Full Page Views'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2163664738368243)
,p_db_column_name=>'MAX_ELAPSED'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Max Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D9999'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2161285467368241)
,p_db_column_name=>'MEDIAN_ELAPSED'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Median Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D9999'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2165255136368243)
,p_db_column_name=>'MIN_ELAPSED'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Min Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D9999'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2160414154368241)
,p_db_column_name=>'PAGE'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Page'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2160877480368241)
,p_db_column_name=>'PAGE_NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Page Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2163205070368242)
,p_db_column_name=>'PAGE_VIEWS'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Page Views'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2164412164368243)
,p_db_column_name=>'PARTIAL_PAGE_VIEWS'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Partial Page Views'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2164021800368243)
,p_db_column_name=>'TOTAL_ROWS'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Total Rows'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2161618457368241)
,p_db_column_name=>'WEIGHTED_PERFORMANCE'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Weighted Performance'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D99'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(2170503776368247)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'21706'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PAGE:PAGE_NAME:MEDIAN_ELAPSED:WEIGHTED_PERFORMANCE:ERRORS:DISTINCT_USERS:APPLICATION_SESSIONS:PAGE_VIEWS'
,p_sort_column_1=>'WEIGHTED_PERFORMANCE'
,p_sort_direction_1=>'DESC'
,p_sort_column_2=>'PAGE_VIEWS'
,p_sort_direction_2=>'DESC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2171452013368247)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(2159418509368237)
,p_button_name=>'RESET_REPORT'
,p_static_id=>'reset-report'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2159303993368237)
,p_name=>'P10013_TIMEFRAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(2159515404368237)
,p_item_default=>'900'
,p_prompt=>'Timeframe'
,p_source=>'900'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'TIMEFRAME (4 WEEKS)'
,p_cHeight=>1
,p_field_template=>2320077351817916916
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(2159685349368237)
,p_name=>'Refresh Report'
,p_static_id=>'refresh-report'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10013_TIMEFRAME'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2172723358368248)
,p_event_id=>wwv_flow_imp.id(2159685349368237)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(2159418509368237)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
end;
/
prompt --application/pages/page_10014
begin
wwv_flow_imp_page.create_page(
 p_id=>10014
,p_name=>'Page Views'
,p_alias=>'PAGE-VIEWS'
,p_page_mode=>'MODAL'
,p_step_title=>'Page Views'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(2121619235368195)
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_imp.id(2121312219368195)
,p_required_patch=>wwv_flow_imp.id(2120137423368195)
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page provides an interactive report of the most recent page views.</p>',
'<p>Select the reporting timeframe (Default = 1 day) at the top of the page as necessary.<br>',
'Click on the column headings to sort and filter data, or click on the <strong>Actions</strong> button to customize column display and many additional advanced features. Click the <strong>Reset</strong> button to reset the interactive report back to t'
||'he default settings.</p>'))
,p_page_component_map=>'18'
,p_last_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2148589952368225)
,p_plug_name=>'Buttons'
,p_static_id=>'buttons'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noUI:t-Form--large'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2148423479368225)
,p_plug_name=>'Page Views'
,p_static_id=>'page-views'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    step_id||''. ''||(select page_name',
'                    from apex_application_pages p',
'                    where p.page_id = l.step_id',
'                        and p.application_id = :APP_ID) page_name,',
'    userid_lc     user_id,',
'    time_stamp    timestamp,',
'    elap          elapsed,',
'    step_id       page,',
'    decode(page_mode,''P'',''Partial'',''D'',''Full'',page_mode) page_mode,',
'    component_name,',
'    num_rows,',
'    ir_search,',
'    sqlerrm  error',
'from apex_activity_log l',
'where flow_id = :app_id',
'    and time_stamp >= sysdate - ( 1/24/60/60 * :P10014_TIMEFRAME )',
'    and userid is not null',
'    and step_id is not null',
'order by time_stamp desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P10014_TIMEFRAME'
,p_prn_page_header=>'Page Views'
,p_ai_enabled=>false
,p_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(2149008404368226)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>2149008404368226
,p_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2151886505368232)
,p_db_column_name=>'COMPONENT_NAME'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Component Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2150640900368231)
,p_db_column_name=>'ELAPSED'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Elapsed'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990D0000'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2153060237368232)
,p_db_column_name=>'ERROR'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Error'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2152608264368232)
,p_db_column_name=>'IR_SEARCH'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'IR Search'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2152291112368232)
,p_db_column_name=>'NUM_ROWS'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Num Rows'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G990'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2151019324368231)
,p_db_column_name=>'PAGE'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Page'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2151413298368232)
,p_db_column_name=>'PAGE_MODE'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Mode'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2149472042368230)
,p_db_column_name=>'PAGE_NAME'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Page Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2150281743368231)
,p_db_column_name=>'TIMESTAMP'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Timestamp'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2149858088368231)
,p_db_column_name=>'USER_ID'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'User'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(2156778378368235)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'21568'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PAGE_NAME:USER_ID:TIMESTAMP:ELAPSED:PAGE_MODE'
,p_sort_column_1=>'TIMESTAMP'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2157668588368235)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(2148423479368225)
,p_button_name=>'RESET_REPORT'
,p_static_id=>'reset-report'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2148384481368225)
,p_name=>'P10014_TIMEFRAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(2148589952368225)
,p_item_default=>'900'
,p_prompt=>'Timeframe'
,p_source=>'900'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'TIMEFRAME (4 WEEKS)'
,p_cHeight=>1
,p_field_template=>2320077351817916916
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(2148630791368225)
,p_name=>'Refresh Report'
,p_static_id=>'refresh-report'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10014_TIMEFRAME'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2158986663368236)
,p_event_id=>wwv_flow_imp.id(2148630791368225)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-refresh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(2148423479368225)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
end;
/
prompt --application/pages/page_10015
begin
wwv_flow_imp_page.create_page(
 p_id=>10015
,p_name=>'Automations Log'
,p_alias=>'AUTOMATIONS-LOG'
,p_page_mode=>'MODAL'
,p_step_title=>'Automations Log'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(2121619235368195)
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch:t-Dialog--noPadding'
,p_required_role=>wwv_flow_imp.id(2121312219368195)
,p_required_patch=>wwv_flow_imp.id(2120137423368195)
,p_protection_level=>'C'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This page provides an interactive report of the automations log.</p>',
'<p>Review logged information about previous automation executions. The log contains start and end timestamps as well as details about processed rows (successful and with errors). Drill down into Messages to see individual messages for processed rows.'
||'</p>',
''))
,p_page_component_map=>'18'
,p_last_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2193470601368269)
,p_plug_name=>'Automations Log'
,p_static_id=>'automations-log'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select l.id,',
'       l.start_timestamp,',
'       a.name automation_name,',
'       l.status,',
'       l.successful_row_count,',
'       l.error_row_count,',
'       (select count(1) from apex_automation_msg_log m where m.automation_log_id = l.id) msg_count,',
'       l.is_job,',
'       l.end_timestamp',
'  from apex_appl_automations a, apex_automation_log l',
' where a.automation_id = l.automation_id',
' and l.application_id = :APP_ID'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Automations Log'
,p_ai_enabled=>false
,p_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(2194061146368269)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_save_rpt_public=>'Y'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_display_row_count=>'Y'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_rows_per_page=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>2194061146368269
,p_updated_on=>wwv_flow_imp.dz('20260623113820Z')
,p_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2195244628368270)
,p_db_column_name=>'AUTOMATION_NAME'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Automation'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2197682735368271)
,p_db_column_name=>'END_TIMESTAMP'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Ended'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2196478847368270)
,p_db_column_name=>'ERROR_ROW_COUNT'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Error Rows'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2194457399368269)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2197245519368271)
,p_db_column_name=>'IS_JOB'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Scheduled'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2196810715368270)
,p_db_column_name=>'MSG_COUNT'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Message'
,p_column_link=>'f?p=&APP_ID.:10016:&SESSION.:::RP,10016:P10016_LOG_ID:#ID#'
,p_column_linktext=>'#MSG_COUNT#'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2194894310368269)
,p_db_column_name=>'START_TIMESTAMP'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Started'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2195600348368270)
,p_db_column_name=>'STATUS'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(2196080788368270)
,p_db_column_name=>'SUCCESSFUL_ROW_COUNT'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Successful Rows'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(2201014602368273)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'22011'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'START_TIMESTAMP:AUTOMATION_NAME:STATUS:SUCCESSFUL_ROW_COUNT:ERROR_ROW_COUNT:MSG_COUNT'
,p_sort_column_1=>'START_TIMESTAMP'
,p_sort_direction_1=>'DESC'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2201967442368274)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(2193470601368269)
,p_button_name=>'RESET_REPORT'
,p_static_id=>'reset-report'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'t-Button--iconLeft'
,p_button_template_id=>2084305881903810008
,p_button_image_alt=>'Reset'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:&APP_PAGE_ID.,RR::'
,p_icon_css_classes=>'fa-undo-alt'
);
end;
/
prompt --application/pages/page_10016
begin
wwv_flow_imp_page.create_page(
 p_id=>10016
,p_name=>'Log Messages'
,p_alias=>'LOG-MESSAGES'
,p_page_mode=>'MODAL'
,p_step_title=>'Log Messages'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(2121619235368195)
,p_step_template=>2101883943284197310
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(2121312219368195)
,p_required_patch=>wwv_flow_imp.id(2120137423368195)
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_page_component_map=>'03'
,p_last_updated_on=>wwv_flow_imp.dz('20260614162351Z')
,p_last_updated_by=>'CHRIS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2202573222368274)
,p_plug_name=>'Automation Execution'
,p_static_id=>'automation-execution'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(2204934114368275)
,p_name=>'Messages'
,p_static_id=>'messages'
,p_template=>2102002977963900996
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--inline'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select message_timestamp,',
'       message,',
'       message_type,',
'       pk_value',
'  from apex_automation_msg_log',
' where automation_log_id = :P10016_LOG_ID'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_query_row_count_max=>50
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2205773261368279)
,p_query_column_id=>2
,p_column_alias=>'MESSAGE'
,p_column_display_sequence=>2
,p_column_heading=>'Message'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2205365012368279)
,p_query_column_id=>1
,p_column_alias=>'MESSAGE_TIMESTAMP'
,p_column_display_sequence=>1
,p_column_heading=>'Timestamp'
,p_column_alignment=>'CENTER'
,p_default_sort_column_sequence=>1
,p_default_sort_dir=>'desc'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2206193195368279)
,p_query_column_id=>3
,p_column_alias=>'MESSAGE_TYPE'
,p_column_display_sequence=>3
,p_column_heading=>'Message Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2206559971368279)
,p_query_column_id=>4
,p_column_alias=>'PK_VALUE'
,p_column_display_sequence=>4
,p_column_heading=>'Primary Key Value'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2203308018368274)
,p_name=>'P10016_AUTOMATION_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(2202573222368274)
,p_prompt=>'Automation'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2202925829368274)
,p_name=>'P10016_LOG_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(2202573222368274)
,p_use_cache_before_default=>'NO'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2203761247368275)
,p_name=>'P10016_START_TIMESTAMP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(2202573222368274)
,p_prompt=>'Started'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2204188312368275)
,p_name=>'P10016_STATUS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(2202573222368274)
,p_prompt=>'Status'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'Y',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(2204532846368275)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Log Detail'
,p_static_id=>'get-log-detail'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select automation_name,',
'       start_timestamp,',
'       status',
'  into :P10016_AUTOMATION_NAME,',
'       :P10016_START_TIMESTAMP,',
'       :P10016_STATUS',
'  from apex_automation_log',
' where id = :P10016_LOG_ID;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>2204532846368275
);
end;
/
prompt --application/deployment/definition
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp_shared.create_install(
 p_id=>wwv_flow_imp.id(2900501293236185)
,p_deinstall_script_clob=>wwv_flow_imp.varchar2_to_clob(wwv_flow_imp.g_varchar2_table)
,p_last_updated_on=>wwv_flow_imp.dz('20260627092536Z')
);
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
