CREATE OR REPLACE FORCE VIEW apex_application_temp_calendar (workspace,application_id,application_name,template_name,last_updated_by,last_updated_on,theme_number,theme_class,translatable,is_subscribed,subscribed_from,month_title_format,day_of_week_format,month_open_format,month_close_format,day_title_format,day_open_format,day_close_format,today_open_format,weekend_title_format,weekend_open_format,weekend_close_format,nonday_title_format,nonday_open_format,nonday_close_format,week_title_format,week_open_format,week_close_format,daily_title_format,daily_open_format,daily_close_format,weekly_title_format,weekly_day_of_week_format,weekly_month_open_format,weekly_month_close_format,weekly_day_title_format,weekly_day_open_format,weekly_day_close_format,weekly_today_open_format,weekly_weekend_title_format,weekly_weekend_open_format,weekly_weekend_close_format,weekly_time_open_format,weekly_time_close_format,weekly_time_title_format,weekly_hour_open_format,weekly_hour_close_format,daily_day_of_week_format,daily_month_title_format,daily_month_open_format,daily_month_close_format,daily_day_title_format,daily_day_open_format,daily_day_close_format,daily_today_open_format,daily_time_open_format,daily_time_close_format,daily_time_title_format,daily_hour_open_format,daily_hour_close_format,component_comment,calendar_template_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.NAME                           template_name,
    t.LAST_UPDATED_BY                ,
    t.LAST_UPDATED_ON                ,
    t.THEME_ID                       theme_number,
    decode(t.THEME_CLASS_ID,
       '1','Calendar',
       '2','Calendar, Alternative 1',
       '3','Small Calendar',
       '4','Custom 1',
       '5','Custom 2',
       '6','Custom 3',
       '7','Custom 4',
       '8','Custom 5',
       '9','Custom 6',
       '10','Custom 7',
       '11','Custom 8',
       t.THEME_CLASS_ID)             theme_class,
    --
    decode(t.TRANSLATE_THIS_TEMPLATE,
      'Y','Yes','N','No','Yes')      translatable,
    --
    decode(t.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name
     from WWV_FLOW_CAL_TEMPLATES
     where id = t.REFERENCE_ID)      subscribed_from,
    --
    t.MONTH_TITLE_FORMAT             ,
    t.DAY_OF_WEEK_FORMAT             ,
    t.MONTH_OPEN_FORMAT              ,
    t.MONTH_CLOSE_FORMAT             ,
    t.DAY_TITLE_FORMAT               ,
    t.DAY_OPEN_FORMAT                ,
    t.DAY_CLOSE_FORMAT               ,
    t.TODAY_OPEN_FORMAT              ,
    t.WEEKEND_TITLE_FORMAT           ,
    t.WEEKEND_OPEN_FORMAT            ,
    t.WEEKEND_CLOSE_FORMAT           ,
    t.NONDAY_TITLE_FORMAT            ,
    t.NONDAY_OPEN_FORMAT             ,
    t.NONDAY_CLOSE_FORMAT            ,
    t.WEEK_TITLE_FORMAT              ,
    t.WEEK_OPEN_FORMAT               ,
    t.WEEK_CLOSE_FORMAT              ,
    t.DAILY_TITLE_FORMAT             ,
    t.DAILY_OPEN_FORMAT              ,
    t.DAILY_CLOSE_FORMAT             ,
    t.weekly_title_format            ,
    t.weekly_day_of_week_format      ,
    t.weekly_month_open_format       ,
    t.weekly_month_close_format      ,
    t.weekly_day_title_format        ,
    t.weekly_day_open_format         ,
    t.weekly_day_close_format        ,
    t.weekly_today_open_format       ,
    t.weekly_weekend_title_format    ,
    t.weekly_weekend_open_format     ,
    t.weekly_weekend_close_format    ,
    t.weekly_time_open_format        ,
    t.weekly_time_close_format       ,
    t.weekly_time_title_format       ,
    t.weekly_hour_open_format        ,
    t.weekly_hour_close_format       ,
    t.daily_day_of_week_format       ,
    t.daily_month_title_format       ,
    t.daily_month_open_format        ,
    t.daily_month_close_format       ,
    t.daily_day_title_format         ,
    t.daily_day_open_format          ,
    t.daily_day_close_format         ,
    t.daily_today_open_format        ,
    t.daily_time_open_format         ,
    t.daily_time_close_format        ,
    t.daily_time_title_format        ,
    t.daily_hour_open_format         ,
    t.daily_hour_close_format        ,
    t.TEMPLATE_COMMENTS              component_comment,
    t.id                             calendar_template_id,
    --
    t.NAME
    ||' t='||t.THEME_ID
    ||' c='||t.THEME_CLASS_ID
    component_signature
from WWV_FLOW_CAL_TEMPLATES t,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = t.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_temp_calendar IS 'Identifies the HTML template markup used to display a Calendar';
COMMENT ON COLUMN apex_application_temp_calendar.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_temp_calendar.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_temp_calendar.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_temp_calendar.template_name IS 'Identifies the template name';
COMMENT ON COLUMN apex_application_temp_calendar.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_temp_calendar.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_temp_calendar.theme_number IS 'Identifies the numeric identifier of this theme to which this template is associated';
COMMENT ON COLUMN apex_application_temp_calendar.theme_class IS 'Identifies a specific usage for this template';
COMMENT ON COLUMN apex_application_temp_calendar.translatable IS 'Identifies if this component is to be identified as translatable (yes or no)';
COMMENT ON COLUMN apex_application_temp_calendar.is_subscribed IS 'Identifies if this Calendar Template is subscribed from another Calendar Template';
COMMENT ON COLUMN apex_application_temp_calendar.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_temp_calendar.month_title_format IS 'Format for the monthly title that appears at the top of each month';
COMMENT ON COLUMN apex_application_temp_calendar.day_of_week_format IS 'Format for the week day names which display as the column header for that day of the week';
COMMENT ON COLUMN apex_application_temp_calendar.month_open_format IS 'Printed immediately after the "Month Title Format". Usually this would be an HTML tag which is a container such as a table. Include substitution strings to include dynamic content.';
COMMENT ON COLUMN apex_application_temp_calendar.month_close_format IS 'HTML to be used to close a month';
COMMENT ON COLUMN apex_application_temp_calendar.day_title_format IS 'HTML to be used for the day''s title which the first thing printed after the "Day Open Format';
COMMENT ON COLUMN apex_application_temp_calendar.day_open_format IS 'HTML to be used to opening a day. This is printed for each day. Usually this would be an HTML tag which is a container such as a TD.';
COMMENT ON COLUMN apex_application_temp_calendar.day_close_format IS 'HTML to be used to close a day';
COMMENT ON COLUMN apex_application_temp_calendar.today_open_format IS 'HTML to be used to open today. Usually this would be an HTML tag which is a container such as a td and would be different somehow from the "Day Open".';
COMMENT ON COLUMN apex_application_temp_calendar.weekend_title_format IS 'HTML be used to for a day occurring on a weekend';
COMMENT ON COLUMN apex_application_temp_calendar.weekend_open_format IS 'HTML used to open a day which is on a weekend';
COMMENT ON COLUMN apex_application_temp_calendar.weekend_close_format IS 'HTML used to close a day which is on a weekend';
COMMENT ON COLUMN apex_application_temp_calendar.nonday_title_format IS 'HTML used to format a non-day title. For example, suppose the first of a month is a Monday, but the week starts on a Sunday. Since Sunday is not be part of the current month, Sunday would be a non-day.';
COMMENT ON COLUMN apex_application_temp_calendar.nonday_open_format IS 'HTML to open a non-day';
COMMENT ON COLUMN apex_application_temp_calendar.nonday_close_format IS 'HTML which will close a non-day';
COMMENT ON COLUMN apex_application_temp_calendar.week_title_format IS 'HTML be used to for a day occurring on a weekend';
COMMENT ON COLUMN apex_application_temp_calendar.week_open_format IS 'HTML to be used to open a week. This is printed for each week. Usually this would be an HTML tag which is a container such as a TR.';
COMMENT ON COLUMN apex_application_temp_calendar.week_close_format IS 'HTML to be used to close a week.';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_title_format IS 'Format for the weekly title that appears at the top of each week';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_day_of_week_format IS 'Format for the week day names which display as the column header for that day of the Week';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_month_open_format IS 'Printed immediately after the "Week Title Format". Usually this would be an HTML tag which is a container such as a table. Include substitution strings to include dynamic content.';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_month_close_format IS 'HTML to be used to close a Week';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_day_title_format IS 'HTML to be used for the day''s title which the first thing printed after the "Day Open Format';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_day_open_format IS 'HTML to be used to opening a day. This is printed for each day. Usually this would be an HTML tag which is a container such as a TD.';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_day_close_format IS 'HTML to be used to close a day';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_today_open_format IS 'HTML to be used to open today. Usually this would be an HTML tag which is a container such as a td and would be different somehow from the "Day Open".';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_weekend_title_format IS 'HTML be used to for a day occurring on a weekend';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_weekend_open_format IS 'HTML used to open a day which is on a weekend';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_weekend_close_format IS 'HTML used to close a day which is on a weekend';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_time_open_format IS 'HTML to be used to display the Time. This is printed for each Hour for a week. Usually this would be an HTML tag which is a container such as a TD.';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_time_close_format IS 'HTML to be used to close the Time display column';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_time_title_format IS 'HTML be used for displaying the Time';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_hour_open_format IS 'HTML to be used to opening the Hour for the week. This is printed for each Hour. Usually this would be an HTML tag which is a container such as a TR.';
COMMENT ON COLUMN apex_application_temp_calendar.weekly_hour_close_format IS 'HTML to be used to close the Hour';
COMMENT ON COLUMN apex_application_temp_calendar.daily_day_of_week_format IS 'Format for the week day names which display as the column header for that day of the Week';
COMMENT ON COLUMN apex_application_temp_calendar.daily_month_title_format IS 'Title format for the Daily Calendar.';
COMMENT ON COLUMN apex_application_temp_calendar.daily_month_open_format IS 'Printed immediately after the "Day Title Format". Usually this would be an HTML tag which is a container such as a table. Include substitution strings to include dynamic content.';
COMMENT ON COLUMN apex_application_temp_calendar.daily_month_close_format IS 'HTML to be used to close a Day';
COMMENT ON COLUMN apex_application_temp_calendar.daily_day_title_format IS 'HTML to be used for the day''s title which the first thing printed after the "Day Open Format';
COMMENT ON COLUMN apex_application_temp_calendar.daily_day_open_format IS 'HTML to be used to opening a day. This is printed for each day. Usually this would be an HTML tag which is a container such as a TD.';
COMMENT ON COLUMN apex_application_temp_calendar.daily_day_close_format IS 'HTML to be used to close a day';
COMMENT ON COLUMN apex_application_temp_calendar.daily_today_open_format IS 'HTML to be used to open today. Usually this would be an HTML tag which is a container such as a td and would be different somehow from the "Day Open".';
COMMENT ON COLUMN apex_application_temp_calendar.daily_time_open_format IS 'HTML to be used to display the Time. This is printed for each Hour. Usually this would be an HTML tag which is a container such as a TD.';
COMMENT ON COLUMN apex_application_temp_calendar.daily_time_close_format IS 'HTML to be used to close the Time display column';
COMMENT ON COLUMN apex_application_temp_calendar.daily_time_title_format IS 'HTML be used for displaying the Time';
COMMENT ON COLUMN apex_application_temp_calendar.daily_hour_open_format IS 'HTML to be used to opening the Hour for the Day. This is printed for each Hour. Usually this would be an HTML tag which is a container such as a TR.';
COMMENT ON COLUMN apex_application_temp_calendar.daily_hour_close_format IS 'HTML to be used to close the Hour';
COMMENT ON COLUMN apex_application_temp_calendar.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_temp_calendar.calendar_template_id IS 'Identifies the Primary Key of this Calendar Template';
COMMENT ON COLUMN apex_application_temp_calendar.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';