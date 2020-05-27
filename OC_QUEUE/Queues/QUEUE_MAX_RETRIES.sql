BEGIN DBMS_AQADM.CREATE_QUEUE(
   Queue_name        =>'oc_queue.queue_max_retries',
   Queue_table       =>'oc_queue.qtab',
   Queue_type        => 0,
   Max_retries       => 5,
   Retry_delay       => 0,
   Retention_time    => 0,
   Comment           =>'');
END;
/