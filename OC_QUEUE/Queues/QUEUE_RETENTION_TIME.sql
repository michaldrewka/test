BEGIN DBMS_AQADM.CREATE_QUEUE(
   Queue_name        =>'oc_queue.queue_retention_time',
   Queue_table       =>'oc_queue.qtab',
   Queue_type        => 0,
   Max_retries       => 6,
   Retry_delay       => 1,
   Retention_time    => 0,
   Comment           =>'');
END;
/