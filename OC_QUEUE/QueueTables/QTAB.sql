BEGIN DBMS_AQADM.CREATE_QUEUE_TABLE(
   Queue_table        =>'oc_queue.qtab',
   Queue_payload_type =>'oc_queue.message',
   storage_clause     =>'PCTFREE 10 PCTUSED 40 INITRANS 1
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSTEM"',
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