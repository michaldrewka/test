CREATE OR REPLACE FORCE VIEW apex_workspace_developers (workspace_id,workspace_name,first_schema_provisioned,user_name,email,date_created,date_last_updated,available_schemas,is_admin,is_application_developer) AS
select "WORKSPACE_ID","WORKSPACE_NAME","FIRST_SCHEMA_PROVISIONED","USER_NAME","EMAIL","DATE_CREATED","DATE_LAST_UPDATED","AVAILABLE_SCHEMAS","IS_ADMIN","IS_APPLICATION_DEVELOPER"
from apex_workspace_apex_users
where is_application_developer = 'Yes';
COMMENT ON TABLE apex_workspace_developers IS 'Application Express (Apex) developers, Apex users with privilege to develop applications';
COMMENT ON COLUMN apex_workspace_developers.workspace_id IS 'Primary key that identifies the workspace';
COMMENT ON COLUMN apex_workspace_developers.workspace_name IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_workspace_developers.first_schema_provisioned IS 'The associated database schema identified when this workspace was created';
COMMENT ON COLUMN apex_workspace_developers.user_name IS 'The Apex user name used to authenticate to an Apex web page or Apex application';
COMMENT ON COLUMN apex_workspace_developers.email IS 'The email associated with this Apex user';
COMMENT ON COLUMN apex_workspace_developers.date_created IS 'The date the Apex user was created';
COMMENT ON COLUMN apex_workspace_developers.date_last_updated IS 'The date the Apex user definition was last updated';
COMMENT ON COLUMN apex_workspace_developers.available_schemas IS 'The number of database schemas available to the workspace developer';
COMMENT ON COLUMN apex_workspace_developers.is_admin IS 'Identifies if the Apex user has Apex workspace administration privilege';
COMMENT ON COLUMN apex_workspace_developers.is_application_developer IS 'Identifies if the Apex user has Apex application development privilege';