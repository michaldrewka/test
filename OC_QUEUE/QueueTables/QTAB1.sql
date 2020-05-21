BEGIN DBMS_AQADM.CREATE_QUEUE_TABLE(
   Queue_table        =>'oc_queue.qtab1',
   Queue_payload_type =>'RAW',
   Sort_list          =>'PRIORITY,ENQ_TIME',
   multiple_consumers => False,
   message_grouping   => 0,
   comment            =>'',
   primary_instance   => 0,
   secondary_instance => 0,
   compatible         =>'10.0.0',
   secure             => False);
END;
/