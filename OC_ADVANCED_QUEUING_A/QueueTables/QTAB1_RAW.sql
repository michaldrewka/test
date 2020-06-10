BEGIN DBMS_AQADM.CREATE_QUEUE_TABLE(
   Queue_table        =>'oc_advanced_queuing_a.qtab1_raw',
   Queue_payload_type =>'RAW',
   Sort_list          =>'ENQ_TIME',
   multiple_consumers => False,
   message_grouping   => 0,
   comment            =>'',
   primary_instance   => 0,
   secondary_instance => 0,
   compatible         =>'10.0.0',
   secure             => False);
END;
/