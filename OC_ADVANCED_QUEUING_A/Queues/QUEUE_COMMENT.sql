BEGIN DBMS_AQADM.CREATE_QUEUE(
   Queue_name        =>'oc_advanced_queuing_a.queue_comment',
   Queue_table       =>'oc_advanced_queuing_a.qtab',
   Queue_type        => 0,
   Max_retries       => 6,
   Retry_delay       => 1,
   Retention_time    => 0,
   Comment           =>'test a');
END;
/