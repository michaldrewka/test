BEGIN DBMS_SCHEDULER.CREATE_JOB(
   job_name		=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,job_action		=> 'dbms_refresh.refresh(''"OC_MICHAEL_B"."COMPLEX_NEXT_INTERVAL"'');'
   ,job_type		=> 'PLSQL_BLOCK'
   ,repeat_interval	=> 'cast(trunc(sysdate,''HH'') as timestamp) + interval''1''hour  '
   ,start_date		=> TO_DATE('2030-1-1 13:0:0', 'yyyy-mm-dd hh24:mi:ss')
   ,job_class		=> 'DEFAULT_JOB_CLASS'
   ,comments		=> 'dbms_refresh: submit_sch_job'
   ,auto_drop		=> TRUE
   ,enabled		=> TRUE
);
-- Altering

DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'job_priority'
   ,value		=> 3);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'job_weight'
   ,value		=> 1);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'schedule_limit'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'max_run_duration'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'max_runs'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'max_failures'
);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'logging_level'
   ,value		=> DBMS_SCHEDULER.LOGGING_OFF);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'restartable'
   ,value		=> FALSE);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'stop_on_window_close'
   ,value		=> FALSE);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'raise_events'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'instance_id'
);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'oc_michael_b.mv_rf$j_0_s_5750'
   ,attribute		=> 'allow_runs_in_restricted_mode'
   ,value		=> FALSE);

END;
/