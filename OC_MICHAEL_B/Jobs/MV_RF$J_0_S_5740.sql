BEGIN DBMS_SCHEDULER.CREATE_JOB(
   job_name		=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,job_action		=> 'dbms_refresh.refresh(''"OC_MICHAEL_A"."NEVER_REFRESH_ALTER_DIFFERENT"'');'
   ,job_type		=> 'PLSQL_BLOCK'
   ,repeat_interval	=> 'SYSDATE+1 '
   ,start_date		=> TO_DATE('2021-12-13 14:24:44', 'yyyy-mm-dd hh24:mi:ss')
   ,job_class		=> 'DEFAULT_JOB_CLASS'
   ,comments		=> 'dbms_refresh: submit_sch_job'
   ,auto_drop		=> TRUE
   ,enabled		=> TRUE
);
-- Altering

DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'job_priority'
   ,value		=> 3);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'job_weight'
   ,value		=> 1);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'schedule_limit'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'max_run_duration'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'max_runs'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'max_failures'
);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'logging_level'
   ,value		=> DBMS_SCHEDULER.LOGGING_OFF);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'restartable'
   ,value		=> FALSE);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'stop_on_window_close'
   ,value		=> FALSE);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'raise_events'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'instance_id'
);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5740'
   ,attribute		=> 'allow_runs_in_restricted_mode'
   ,value		=> FALSE);

END;
/