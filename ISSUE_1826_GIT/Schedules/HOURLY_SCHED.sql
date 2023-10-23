BEGIN DBMS_SCHEDULER.CREATE_SCHEDULE(
    schedule_name      => 'issue_1826_git.hourly_sched'
   ,start_date         => TO_DATE('2023-10-23 9:12:33', 'yyyy-mm-dd hh24:mi:ss')
   ,end_date           => TO_DATE('2023-10-24 9:12:33', 'yyyy-mm-dd hh24:mi:ss')
   ,repeat_interval    => 'freq=hourly; byminute=0'
   ,comments           => 'Run every hour at 00 minutes everyday'
);
END;
/