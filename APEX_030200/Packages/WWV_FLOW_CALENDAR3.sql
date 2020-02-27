CREATE OR REPLACE package wwv_flow_calendar3 as

--  Copyright (c) Oracle Corporation 1999 - 2004. All Rights Reserved.
--
--    DESCRIPTION
--      Calendar rendering engine package specification.
--
--    NOTES
--      This program shows regions of type CALENDAR and EASY_CALENDAR.
--
--    RUNTIME DEPLOYMENT: YES
--

procedure create_wizard_elements(p_flow_id          number,
                                  p_page_id         number,
                                  p_region_id       number,
                                  p_date_item_name  varchar2,
                                  p_display_item_name  varchar2,
                                  p_buttons         varchar2,
                                  p_button_template varchar2,
                                  p_date_item_type_name varchar2 default null,
                                  p_is_ajax_calendar varchar2 default null);

procedure loadCols(p_sql         varchar2        default null,
                    p_owner      varchar2        default null,
                    p_table      varchar2        default null,
                    p_collection varchar2);

 /*  made public for testing performace */
function mySubsDates(p_text  varchar2,
                      p_date date) return varchar2;

 /*  made public for testing performace */
function checkDateSub(p_text    varchar2,
                       p_format varchar2,
                       p_date   date) return varchar2;


procedure set_Attributes(p_flow_id                     number,
                         p_template_id                 number,
                         p_plug_id                     number,
                         p_start_date                  varchar2    default null,
                         p_end_date                    varchar2    default null,
                         p_begin_at_Start_of_interval  varchar2    default 'Y',
                         p_date_item                   varchar2    default null,
                         p_date_type_item              varchar2    default null,
                         p_interval                    varchar2    default 'M',
                         p_display_item                varchar2    default null,
                         p_display_type                varchar2    default null,
                         p_item_format                 varchar2    default null,
                         p_easy_sql_owner              varchar2    default null,
                         p_easy_sql_table              varchar2    default null,
                         p_date_col                    varchar2    default null,
                         p_display_col                 varchar2    default null,
                         p_start_of_week               number      default null,
                         p_day_link                    varchar2    default null,
                         p_item_link                   varchar2    default null,
                         p_start_time                  in varchar2 default null,
                         p_end_time                    in varchar2 default null,
                         p_time_format                 in varchar2 default null,
                         p_week_start_day              in varchar2 default null,
                         p_week_end_day                in varchar2 default null,
                         p_calendar_type               in varchar2 default null,
                         p_SECURITY_GROUP_ID           number      default wwv_flow_security.g_security_group_id ,
                         p_LAST_UPDATED_BY             varchar2    default wwv_flow.g_user,
                         p_LAST_UPDATED_ON             date        default sysdate);

procedure show(p_plug_id number,p_cal_type varchar2 default 'M',p_cal_action varchar2 default null,p_date_value varchar2 default null);

procedure printMonthCal( p_sql                         varchar2,
                    p_start                       date     := null,
                    p_date_col                    varchar2 := null,
                    p_display_col                 varchar2 := null,

                    p_begin_at_Start_of_interval  varchar2 := 'Y',
                    p_start_of_week               number   := null,
                    p_end                         date     := null,
                    --p_display_as                  varchar2 := 'M', SATHIKUM F30 Commented
		    p_display_as                  varchar2 := null, --SATHIKUM F30 Added to support weekly and Daily
                    p_item_format                 varchar2 := null,
                    p_separator                   varchar2 := null,
                    p_item_link                   varchar2 := null,
                    p_day_link                    varchar2 := null,
                    p_link_all_days               boolean  := true,

                    p_month_title_format          varchar2 := null,
                    p_day_of_week_format          varchar2 := null,
                    p_month_open_format           varchar2 := null,
                    p_month_close_format          varchar2 := null,

                    p_day_title_format            varchar2 := null,
                    p_day_open_format             varchar2 := null,
                    p_day_close_format            varchar2 := null,

                    p_today_open_format           varchar2 := null,

                    p_weekend_title_format        varchar2 := null,
                    p_weekend_open_format         varchar2 := null,
                    p_weekend_close_format        varchar2 := null,

                    p_nonday_title_format         varchar2 := null,
                    p_nonday_open_format          varchar2 := null,
                    p_nonday_close_format         varchar2 := null,

                    p_week_title_format           varchar2 := null,
                    p_week_open_format            varchar2 := null,
                    p_week_close_format           varchar2 := null,

                    p_daily_title_format          varchar2 := null,
                    p_daily_open_format           varchar2 := null,
                    p_daily_close_format          varchar2 := null
          );

procedure printDayCal( p_sql                         varchar2,
                    p_start                       date     := null,
                    p_date_col                    varchar2 := null,
                    p_display_col                 varchar2 := null,

                    p_begin_at_Start_of_interval  varchar2 := 'Y',
                    p_start_of_week               number   := null,
                    p_end                         date     := null,
                    p_display_as                  varchar2 := 'D',
                    p_item_format                 varchar2 := null,
                    p_separator                   varchar2 := null,
                    p_item_link                   varchar2 := null,
                    p_day_link                    varchar2 := null,
                    p_link_all_days               boolean  := true,

		p_start_time			  number := null,
		p_end_time			  number := null,
		p_time_format			  varchar2 := null,
		p_week_start_day		  number := null,
		p_week_end_day			  number := null,

     		p_daily_title_format 	       varchar2 := null,
		p_daily_day_of_week_format   varchar2 := null,

		p_daily_month_open_format    varchar2 := null,
		p_daily_month_close_format   varchar2 := null,

		p_daily_day_title_format     varchar2 := null,
		p_daily_day_open_format      varchar2 := null,
		p_daily_day_close_format     varchar2 := null,
		p_daily_today_open_format    varchar2 := null,

		p_daily_time_open_format     varchar2 := null,
		p_daily_time_close_format    varchar2 := null,
		p_daily_time_title_format    varchar2 := null,

		p_daily_hour_open_format     varchar2 := null,
		p_daily_hour_close_format    varchar2 := null

          );

procedure printWeekCal( p_sql                         varchar2,
                    p_start                       date     := null,
                    p_date_col                    varchar2 := null,
                    p_display_col                 varchar2 := null,
                    p_begin_at_Start_of_interval  varchar2 := 'Y',
                    p_start_of_week               number   := null,
                    p_end                         date     := null,
                    p_display_as                  varchar2 := 'M',
                    p_item_format                 varchar2 := null,
                    p_separator                   varchar2 := null,
                    p_item_link                   varchar2 := null,
                    p_day_link                    varchar2 := null,
                    p_link_all_days               boolean  := true,

		p_start_time			  number := null,
		p_end_time			  number := null,
		p_time_format			  varchar2 := null,
		p_week_start_day		  number := null,
		p_week_end_day			  number := null,

     		p_weekly_title_format 	       varchar2 := null,
		p_weekly_day_of_week_format   varchar2 := null,

		p_weekly_month_open_format    varchar2 := null,
		p_weekly_month_close_format   varchar2 := null,

		p_weekly_day_title_format     varchar2 := null,
		p_weekly_day_open_format      varchar2 := null,
		p_weekly_day_close_format     varchar2 := null,
		p_weekly_today_open_format    varchar2 := null,

		p_weekly_weekend_title_format varchar2 := null,
		p_weekly_weekend_open_format  varchar2 := null,
		p_weekly_weekend_close_format varchar2 := null,

		p_weekly_time_open_format     varchar2 := null,
		p_weekly_time_close_format    varchar2 := null,
		p_weekly_time_title_format    varchar2 := null,

		p_weekly_hour_open_format     varchar2 := null,
		p_weekly_hour_close_format    varchar2 := null

          );

function  is_valid_query(p_query  varchar2,
                         p_owner  varchar2) return varchar2;


procedure  process_calendar_date( p_request varchar2,
    p_date    varchar2,
    p_type    varchar2,
    p_date_item varchar2
    ) ;

end wwv_flow_calendar3;
/