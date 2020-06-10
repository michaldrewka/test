BEGIN DBMS_AQADM.CREATE_QUEUE(
   Queue_name        =>'oc_advanced_queuing_a.queue_queue_type',
   Queue_table       =>'oc_advanced_queuing_a.qtab',
   Queue_type        => 0,
   Max_retries       => 5,
   Retry_delay       => 0,
   Retention_time    => 0,
   Comment           =>'');
END;
/