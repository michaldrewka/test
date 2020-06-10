BEGIN DBMS_AQADM.CREATE_QUEUE_TABLE(
   Queue_table        =>'oc_advanced_queuing_a.qtab_message_grouping',
   Queue_payload_type =>'oc_advanced_queuing_a.message',
   Sort_list          =>'PRIORITY,ENQ_TIME',
   multiple_consumers => False,
   message_grouping   => 1,
   comment            =>'',
   primary_instance   => 0,
   secondary_instance => 0,
   compatible         =>'10.0.0',
   secure             => False);
END;
/