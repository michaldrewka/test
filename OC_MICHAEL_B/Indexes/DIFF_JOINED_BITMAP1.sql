CREATE BITMAP INDEX diff_joined_bitmap1 ON bitmap_src_a(bitmap_src_b.col1,bitmap_src_a.col2)
FROM bitmap_src_a,bitmap_src_c,bitmap_src_b
WHERE bitmap_src_a.col1 = bitmap_src_c.col1
    AND bitmap_src_c.col1 = bitmap_src_b.col1
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSTEM";