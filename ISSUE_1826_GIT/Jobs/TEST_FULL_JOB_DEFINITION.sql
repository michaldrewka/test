BEGIN DBMS_SCHEDULER.CREATE_JOB(
   job_name		=> 'issue_1826_git.test_full_job_definition'
   ,job_action		=> 'BEGIN my_job_procedure; END;'
   ,job_type		=> 'PLSQL_BLOCK'
   ,repeat_interval	=> 'freq=hourly; byminute=0; bysecond=0;'
   ,start_date		=> TO_DATE('2023-10-23 10:3:43', 'yyyy-mm-dd hh24:mi:ss')
   ,job_class		=> 'DEFAULT_JOB_CLASS'
   ,auto_drop		=> TRUE
   ,enabled		=> TRUE
);
-- Altering

DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'job_priority'
   ,value		=> 3);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'job_weight'
   ,value		=> 1);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'schedule_limit'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'max_run_duration'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'max_runs'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'max_failures'
);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'logging_level'
   ,value		=> DBMS_SCHEDULER.LOGGING_OFF);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'restartable'
   ,value		=> FALSE);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'stop_on_window_close'
   ,value		=> FALSE);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'raise_events'
);


DBMS_SCHEDULER.SET_ATTRIBUTE_NULL(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'instance_id'
);


DBMS_SCHEDULER.SET_ATTRIBUTE(
   name			=> 'issue_1826_git.test_full_job_definition'
   ,attribute		=> 'allow_runs_in_restricted_mode'
   ,value		=> FALSE);

END;
/