BEGIN DBMS_SCHEDULER.CREATE_SCHEDULE(
    schedule_name      => 'issue_1826_git.hourly_sched2'
   ,start_date         => TO_DATE('2023-9-27 13:16:43', 'yyyy-mm-dd hh24:mi:ss')
   ,end_date           => TO_DATE('2023-9-28 13:16:43', 'yyyy-mm-dd hh24:mi:ss')
   ,repeat_interval    => 'freq=hourly; byminute=0'
   ,comments           => 'Run every hour at 00 minutes everyday'
);
END;
/