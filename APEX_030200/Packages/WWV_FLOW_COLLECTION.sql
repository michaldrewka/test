CREATE OR REPLACE package wwv_flow_collection as
--  Copyright (c) Oracle Corporation 2001 - 2005. All Rights Reserved.
--
--    DESCRIPTION
--      Flow collection session state management package.
--
--    SECURITY
--      Publicly executable.
--
--    NOTES
--
--    RUNTIME DEPLOYMENT: YES
--



empty_vc_arr wwv_flow_global.vc_arr2;



procedure create_collection(
    --
    -- Create a named collection.  If a collection exists with the same name
    -- for the current user in the same session for the current Application ID, an application
    -- error will be raised.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --
    -- example(s):
    --     wwv_flow_collection.create_collection( p_collection_name => 'Firearm' );
    --
    p_collection_name in varchar2 )
    ;


procedure create_or_truncate_collection(
    --
    -- Create a named collection.  If a collection exists with the same name
    -- for the same user in the same session for the current Flow ID, all members
    -- of this collection will be removed (i.e., the named collection will be truncated).
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --
    -- example(s):
    --     wwv_flow_collection.create_or_truncate_collection( p_collection_name => 'Firearm' );
    --
    p_collection_name in varchar2 )
    ;


procedure create_collection_from_query(
    --
    -- Create a named collection from the supplied query.  The query will be parsed as the
    -- application owner.  If a collection exists with the same name for the current user in the
    -- same session for the current Flow ID, an application error will be raised.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_query             =  Query to be executed which will populate the members of the
    --                            collection.  If p_query is numeric, it is assumed to be
    --                            a DBMS_SQL cursor.
    --     p_generate_md5      =  Flag to compute MD5 checksum for member data (default is 'NO')
    --
    -- example(s):
    --     l_query := 'select make, model, caliber from firearms';
    --     wwv_flow_collection.create_collection_from_query( p_collection_name => 'Firearm', p_query => l_query );
    --
    p_collection_name in varchar2,
    p_query           in varchar2,
    p_generate_md5    in varchar2 default 'NO' )
    ;

procedure create_collection_from_query_b(
    --
    -- Create a named collection from the supplied query using bulk operations.  The query will
    -- be parsed as the application owner.  If a collection exists with the same name for the current
    -- user in the same session for the current Flow ID, an application error will be raised.
    --
    -- This procedure uses bulk dynamic SQL to perform the fetch and insert operations into the named
    -- collection.  Two limitations are imposed by this procedure:
    --
    --   1) The MD5 checksum for the member data will not be computed
    --   2) No column value in query p_query can exceed 2,000 bytes
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_query             =  Query to be executed which will populate the members of the
    --                            collection.  If p_query is numeric, it is assumed to be
    --                            a DBMS_SQL cursor.
    -- example(s):
    --     l_query := 'select make, model, caliber from firearms';
    --     wwv_flow_collection.create_collection_from_query_b( p_collection_name => 'Firearm', p_query => l_query );
    --
    p_collection_name in varchar2,
    p_query           in varchar2 )
    ;



procedure truncate_collection(
    --
    -- Truncate a named collection, thereby removing all members.
    -- If a collection does not exist with the specified name for the current
    -- user in the same session for the current Flow ID, an application error will be raised.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --
    -- example(s):
    --     wwv_flow_collection.truncate_collection( p_collection_name => 'Firearm' );
    --
    p_collection_name in varchar2 )
    ;


procedure delete_collection(
    --
    -- Delete/Drop a named collection, removing all members and dropping
    -- the named collection.  If a collection does not exist with the specified
    -- name for the current user in the same session for the current Flow ID, an application
    -- error will be raised.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --
    -- example(s):
    --     wwv_flow_collection.delete_collection( p_collection_name => 'Firearm' );
    --
    p_collection_name in varchar2 )
    ;

procedure delete_all_collections
    --
    -- Delete all of the collections belonging to the
    -- current user in the current Flow session in the
    -- current Flow
    --
    ;

procedure delete_all_collections_session
    --
    -- Delete all of the collections belonging to the
    -- current user in the current Flow session, regardless of Flow number
    --
    ;


function collection_member_count(
    --
    -- Return the total number of members of the named collection.  Note that this
    -- returns the total member count, which may not be equal to the highest sequence id
    -- in the collection, as gaps could exist.  Note that if the named collection does
    -- not exists for the current user in the current Flow session and for the current
    -- Flow ID, an application error will NOT be raised.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --
    -- example(s):
    --     l_count := wwv_flow_collection.collection_member_count( p_collection_name => 'Firearm' );
    --
    p_collection_name in varchar2 )
    return number
    ;


procedure resequence_collection(
    --
    -- For the given named collection, update the seq_id value of each member such
    -- that no "gaps" will exist in the sequencing.  So a collection with a set of
    -- seq_id's (1,2,3,5,8,9) would become (1,2,3,4,5,6).  If a collection does not exist
    -- with the specified name for the current user in the same session for the current
    -- Flow ID, an application error will be raised.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --
    -- example(s):
    --     wwv_flow_collection.resequence_collection( p_collection_name => 'Firearm' );
    --
    p_collection_name in varchar2 )
    ;


function collection_exists(
    --
    -- Return TRUE or FALSE if the specified named collection exists for the
    -- current user in the current session for the current Flow ID
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --
    -- example(s):
    --     l_exists := wwv_flow_collection.collection_exists( p_collection_name => 'Firearm' );
    --
    p_collection_name in varchar2 )
    return boolean
    ;


procedure add_member(
    --
    -- Add a member to the given named collection.  If a collection does not exist
    -- with the specified name for the current user in the same session for the current
    -- Flow ID, an application error will be raised.  Any attribute value exceeding 4,000 bytes will be truncated
    -- to 4,000 bytes.  Gaps are not used when adding a member, so an existing collection with members
    -- of sequence id's (1,2,5,8) will add the new member with a sequence ID of 9.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_c001              =  Attribute value 1 of the member to be added.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --     p_c0XX              =  Attribute value XX of the member to be added.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --     p_generate_md5      =  Flag to compute MD5 checksum for member data (default is 'NO')
    --
    -- example(s):
    --     wwv_flow_collection.add_member( p_collection_name => 'Firearm', p_c001 => 'Colt', p_c002 => 'AR-15' );
    --
    p_collection_name in varchar2,
    p_c001          in varchar2 default null,
    p_c002          in varchar2 default null,
    p_c003          in varchar2 default null,
    p_c004          in varchar2 default null,
    p_c005          in varchar2 default null,
    p_c006          in varchar2 default null,
    p_c007          in varchar2 default null,
    p_c008          in varchar2 default null,
    p_c009          in varchar2 default null,
    p_c010          in varchar2 default null,
    p_c011          in varchar2 default null,
    p_c012          in varchar2 default null,
    p_c013          in varchar2 default null,
    p_c014          in varchar2 default null,
    p_c015          in varchar2 default null,
    p_c016          in varchar2 default null,
    p_c017          in varchar2 default null,
    p_c018          in varchar2 default null,
    p_c019          in varchar2 default null,
    p_c020          in varchar2 default null,
    p_c021          in varchar2 default null,
    p_c022          in varchar2 default null,
    p_c023          in varchar2 default null,
    p_c024          in varchar2 default null,
    p_c025          in varchar2 default null,
    p_c026          in varchar2 default null,
    p_c027          in varchar2 default null,
    p_c028          in varchar2 default null,
    p_c029          in varchar2 default null,
    p_c030          in varchar2 default null,
    p_c031          in varchar2 default null,
    p_c032          in varchar2 default null,
    p_c033          in varchar2 default null,
    p_c034          in varchar2 default null,
    p_c035          in varchar2 default null,
    p_c036          in varchar2 default null,
    p_c037          in varchar2 default null,
    p_c038          in varchar2 default null,
    p_c039          in varchar2 default null,
    p_c040          in varchar2 default null,
    p_c041          in varchar2 default null,
    p_c042          in varchar2 default null,
    p_c043          in varchar2 default null,
    p_c044          in varchar2 default null,
    p_c045          in varchar2 default null,
    p_c046          in varchar2 default null,
    p_c047          in varchar2 default null,
    p_c048          in varchar2 default null,
    p_c049          in varchar2 default null,
    p_c050          in varchar2 default null,
    p_clob001       in clob default empty_clob(),
    p_generate_md5  in varchar2 default 'NO' )
    ;


function add_member(
    --
    -- Add a member to the given named collection.  If a collection does not exist
    -- with the specified name for the current user in the same session for the current
    -- Flow ID, an application error will be raised.  Any attribute value exceeding 4,000 bytes will
    -- be truncated to 4,000 bytes.  The sequence ID of the newly added member is returned.  Gaps
    -- are not used when adding a member, so an existing collection with members
    -- of sequence id's (1,2,5,8) will return a sequence ID of 9 for the newly added member.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --
    --     p_c001              =  Attribute value 1 of the member to be added.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --     p_c0XX              =  Attribute value XX of the member to be added.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --     p_generate_md5      =  Flag to compute MD5 checksum for member data (default is 'NO')
    --
    -- Returns:                   sequence ID of the newly added member
    --
    -- example(s):
    --     l_new_id := wwv_flow_collection.add_member( p_collection_name => 'Firearm', p_c001 => 'Colt', p_c002 => 'AR-15' );
    --
    p_collection_name in varchar2,
    p_c001          in varchar2 default null,
    p_c002          in varchar2 default null,
    p_c003          in varchar2 default null,
    p_c004          in varchar2 default null,
    p_c005          in varchar2 default null,
    p_c006          in varchar2 default null,
    p_c007          in varchar2 default null,
    p_c008          in varchar2 default null,
    p_c009          in varchar2 default null,
    p_c010          in varchar2 default null,
    p_c011          in varchar2 default null,
    p_c012          in varchar2 default null,
    p_c013          in varchar2 default null,
    p_c014          in varchar2 default null,
    p_c015          in varchar2 default null,
    p_c016          in varchar2 default null,
    p_c017          in varchar2 default null,
    p_c018          in varchar2 default null,
    p_c019          in varchar2 default null,
    p_c020          in varchar2 default null,
    p_c021          in varchar2 default null,
    p_c022          in varchar2 default null,
    p_c023          in varchar2 default null,
    p_c024          in varchar2 default null,
    p_c025          in varchar2 default null,
    p_c026          in varchar2 default null,
    p_c027          in varchar2 default null,
    p_c028          in varchar2 default null,
    p_c029          in varchar2 default null,
    p_c030          in varchar2 default null,
    p_c031          in varchar2 default null,
    p_c032          in varchar2 default null,
    p_c033          in varchar2 default null,
    p_c034          in varchar2 default null,
    p_c035          in varchar2 default null,
    p_c036          in varchar2 default null,
    p_c037          in varchar2 default null,
    p_c038          in varchar2 default null,
    p_c039          in varchar2 default null,
    p_c040          in varchar2 default null,
    p_c041          in varchar2 default null,
    p_c042          in varchar2 default null,
    p_c043          in varchar2 default null,
    p_c044          in varchar2 default null,
    p_c045          in varchar2 default null,
    p_c046          in varchar2 default null,
    p_c047          in varchar2 default null,
    p_c048          in varchar2 default null,
    p_c049          in varchar2 default null,
    p_c050          in varchar2 default null,
    p_clob001       in clob default empty_clob(),
    p_generate_md5  in varchar2 default 'NO' )
    return number
    ;


procedure update_member(
    --
    -- Update the specified member in the given named collection.  If a collection
    -- does not exist with the specified name for the current user in the same session
    -- for the current Flow ID, an application error will be raised.  If the member specified
    -- by sequence ID p_seq does not exist, an application error will be raised.  Any attribute
    -- value exceeding 4,000 bytes will be truncated to 4,000 bytes.
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_seq               =  Sequence ID of the collection member to be updated.
    --     p_c001              =  Attribute value 1 of the member to be updated.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --     p_c0XX              =  Attribute value XX of the member to be updated.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --
    --
    -- example(s):
    --     wwv_flow_collection.update_member( p_collection_name => 'Firearm', p_seq => '2', p_c001 => 'Colt', p_c002 => 'M-16' );
    --
    p_collection_name in varchar2,
    p_seq           in varchar2,
    p_c001          in varchar2 default null,
    p_c002          in varchar2 default null,
    p_c003          in varchar2 default null,
    p_c004          in varchar2 default null,
    p_c005          in varchar2 default null,
    p_c006          in varchar2 default null,
    p_c007          in varchar2 default null,
    p_c008          in varchar2 default null,
    p_c009          in varchar2 default null,
    p_c010          in varchar2 default null,
    p_c011          in varchar2 default null,
    p_c012          in varchar2 default null,
    p_c013          in varchar2 default null,
    p_c014          in varchar2 default null,
    p_c015          in varchar2 default null,
    p_c016          in varchar2 default null,
    p_c017          in varchar2 default null,
    p_c018          in varchar2 default null,
    p_c019          in varchar2 default null,
    p_c020          in varchar2 default null,
    p_c021          in varchar2 default null,
    p_c022          in varchar2 default null,
    p_c023          in varchar2 default null,
    p_c024          in varchar2 default null,
    p_c025          in varchar2 default null,
    p_c026          in varchar2 default null,
    p_c027          in varchar2 default null,
    p_c028          in varchar2 default null,
    p_c029          in varchar2 default null,
    p_c030          in varchar2 default null,
    p_c031          in varchar2 default null,
    p_c032          in varchar2 default null,
    p_c033          in varchar2 default null,
    p_c034          in varchar2 default null,
    p_c035          in varchar2 default null,
    p_c036          in varchar2 default null,
    p_c037          in varchar2 default null,
    p_c038          in varchar2 default null,
    p_c039          in varchar2 default null,
    p_c040          in varchar2 default null,
    p_c041          in varchar2 default null,
    p_c042          in varchar2 default null,
    p_c043          in varchar2 default null,
    p_c044          in varchar2 default null,
    p_c045          in varchar2 default null,
    p_c046          in varchar2 default null,
    p_c047          in varchar2 default null,
    p_c048          in varchar2 default null,
    p_c049          in varchar2 default null,
    p_c050          in varchar2 default null,
    p_clob001       in clob default empty_clob())
    ;


procedure update_member_attribute(
    --
    -- Update the specified member attribute in the given named collection.  If a
    -- collection does not exist with the specified name for the current user in the same
    -- session for the current Flow ID, an application error will be raised.  If the member
    -- specified by sequence ID p_seq does not exist, an application error will be raised.  If the
    -- attribute number specified is invalid or outside the range 1-50, and error will
    -- be raised.  Any attribute value exceeding 4,000 bytes will be truncated to 4,000 bytes.
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_seq               =  Sequence ID of the collection member to be updated.
    --     p_attr_number       =  Attribute number of the member attribute to be updated.
    --                            Valid values are 1 through 50.  Any number outside of this
    --                            range will be ignored.
    --     p_attr_value        =  Attribute value of the member attribute to be updated.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --
    --
    -- example(s):
    --     wwv_flow_collection.update_member_attribute( p_collection_name => 'Firearm', p_seq => '2', p_attr_number => '1', p_attr_value => 'Colt' );
    --
    p_collection_name in varchar2,
    p_seq             in varchar2,
    p_attr_number     in varchar2,
    p_attr_value      in varchar2)
    ;


procedure update_member_attribute(
    --
    -- Update the specified CLOB member attribute in the given named collection.  If a
    -- collection does not exist with the specified name for the current user in the same
    -- session for the current Flow ID, an application error will be raised.  If the member
    -- specified by sequence ID p_seq does not exist, an application error will be raised.  If the
    -- attribute number specified is invalid or outside the range (currently only 1 for CLOB), an error will
    -- be raised.
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_seq               =  Sequence ID of the collection member to be updated.
    --     p_clob_number       =  Attribute number of the CLOB member attribute to be updated.
    --                            Valid values are 1.  Any number outside of this
    --                            range will be ignored.
    --     p_clob_value        =  Attribute value of the CLOB member attribute to be updated.
    --
    --
    -- example(s):
    --     wwv_flow_collection.update_member_attribute( p_collection_name => 'Firearm', p_seq => '2', p_clob_number => '1', p_clob_value => 'Colt' );
    --
    p_collection_name in varchar2,
    p_seq             in varchar2,
    p_clob_number     in varchar2,
    p_clob_value      in clob)
    ;


procedure add_members (
    --
    -- Add the array of members to the given named collection.  If a collection does not exist
    -- with the specified name for the current user in the same session for the current Flow ID,
    -- an application error will be raised.  Any attribute value exceeding 4,000 bytes will be truncated
    -- to 4,000 bytes.  The count of elements in the p_c001 PL/SQL table will be used as
    -- the total number of items across all PL/SQL tables.  Thus, if p_c001.count = 2 and
    -- p_c002.count = 10, only 2 members will be added.  If p_c001 is null, an application
    -- error will be raised.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_c001              =  Array of first attribute values to be added.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.  The count of
    --                            the p_c001 array will be used across all arrays.
    --     p_c0XX              =  Attribute of NN attributes values to be added.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --
    -- example(s):
    --     wwv_flow_collection.add_members( p_collection_name => 'Firearm', p_c001 => l_arr1, p_c002 => l_arr2 );
    --
    p_collection_name in varchar2,
    p_c001            in wwv_flow_global.vc_arr2,
    p_c002            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c003            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c004            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c005            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c006            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c007            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c008            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c009            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c010            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c011            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c012            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c013            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c014            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c015            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c016            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c017            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c018            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c019            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c020            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c021            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c022            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c023            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c024            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c025            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c026            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c027            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c028            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c029            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c030            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c031            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c032            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c033            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c034            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c035            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c036            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c037            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c038            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c039            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c040            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c041            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c042            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c043            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c044            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c045            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c046            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c047            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c048            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c049            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c050            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_generate_md5    in varchar2 default 'NO')
    ;

procedure merge_members (
    -- Merge members of the given named collection with the values passed in the arrays.
    -- If no collection exists one will be created.  If a p_init_query is provided the collection
    -- will be created from the supplied SQL query.  If the collection exists then the following
    -- will occur:
    -- 1. rows in the collection not in the arrays will be deleted
    -- 2. rows in the collection and in the arrays will be updated
    -- 3. rows in the arrays and not in the collection will be inserted
    --
    -- Any attribute value exceeding 4,000 bytes will be truncated to 4,000 bytes.
    -- The count of elements in the p_c001 PL/SQL table will be used as
    -- the total number of items across all PL/SQL tables.  Thus, if p_c001.count = 2 and
    -- p_c002.count = 10, only 2 members will be merged.  If p_c001 is null, an application
    -- error will be raised.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_c001              =  Array of first attribute values to be merged.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.  The count of
    --                            the p_c001 array will be used across all arrays.  If no values
    --                            are provided then no actions will be performed.
    --     p_c0XX              =  Attribute of NN attributes values to be merged.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --     p_seq               =  Identifies the sequence number of the collection to be merged.
    --     p_null_index        =  If the element identified by this value, for example 3 would be
    --                            p_c003, is null then treat this row as a null row.  In other
    --                            words tell the merge function to ignore this row.  This will result
    --                            in the null rows being removed from the collection.  The null
    --                            index works in conjunction with the null value.  If the value
    --                            of the p_cXXX argument is equal to the p_null_value then the
    --                            row will be treated as null.
    --     p_null_value        =  Used in conjunction with the p_null_index argument.  Identifies
    --                            the null value.  If used this value must not be null.  A typical
    --                            value for this argument is "0".
    --     p_init_query        =  If the collection does not exist then create the collection using
    --                            this query.
    --
    p_collection_name in varchar2,
    p_seq             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c001            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c002            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c003            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c004            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c005            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c006            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c007            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c008            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c009            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c010            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c011            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c012            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c013            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c014            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c015            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c016            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c017            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c018            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c019            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c020            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c021            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c022            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c023            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c024            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c025            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c026            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c027            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c028            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c029            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c030            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c031            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c032            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c033            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c034            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c035            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c036            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c037            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c038            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c039            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c040            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c041            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c042            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c043            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c044            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c045            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c046            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c047            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c048            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c049            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c050            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_null_index      in number   default 1,
    p_null_value      in varchar2 default null,
    p_init_query      in varchar2 default null)
    ;


procedure update_members (
    --
    -- Update the array of members for the given named collection.  If a collection does not exist
    -- with the specified name for the current user in the same session for the current Flow ID,
    -- an application error will be raised.  Any attribute value exceeding 4,000 bytes will be truncated
    -- to 4,000 bytes.  The count of elements in the p_seq PL/SQL table will be used as
    -- the total number of items across all PL/SQL tables.  Thus, if p_seq.count = 2 and
    -- p_c001.count = 10, only 2 members will be updated.  If p_seq is null, an application
    -- error will be raised.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_seq               =  Array of member sequence ID's to be updated.  The count
    --                            of the p_seq array will be used across all arrays.
    --     p_c001              =  Array of first attribute values to be updated.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --     p_c0XX              =  Attribute of NN attributes values to be updated.  Maximum length
    --                            can be 4,000 bytes.  The attribute value will be truncated
    --                            to 4,000 bytes if greater than this amount.
    --
    -- example(s):
    --     wwv_flow_collection.update_members( p_collection_name => 'Firearm', p_seq => l_seq_arr, p_c001 => l_arr1, p_c002 => l_arr2 );
    --
    p_collection_name in varchar2,
    p_seq             in wwv_flow_global.vc_arr2,
    p_c001            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c002            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c003            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c004            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c005            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c006            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c007            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c008            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c009            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c010            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c011            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c012            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c013            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c014            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c015            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c016            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c017            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c018            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c019            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c020            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c021            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c022            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c023            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c024            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c025            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c026            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c027            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c028            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c029            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c030            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c031            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c032            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c033            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c034            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c035            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c036            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c037            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c038            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c039            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c040            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c041            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c042            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c043            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c044            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c045            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c046            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c047            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c048            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c049            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_c050            in wwv_flow_global.vc_arr2 default empty_vc_arr)
    ;



procedure delete_member(
    --
    -- Delete the specified member in the given named collection.  If a collection
    -- does not exist with the specified name for the current user in the same session
    -- and for the current Flow ID, an application error will be raised.  If the member specified
    -- by sequence ID p_seq does not exist, an application error will be raised.
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_seq               =  Sequence ID of the collection member to be deleted.
    --
    -- example(s):
    --     wwv_flow_collection.delete_member( p_collection_name => 'Firearm', p_seq => '2' );
    --
    p_collection_name in varchar2,
    p_seq             in varchar2 )
    ;



procedure delete_members(
    --
    -- For a given collection, delete all members in the collection where the attribute
    -- specified by the attribute number equal the supplied value.  If a collection does not
    -- exist with the specified name for the current user in the same session for the
    -- current Flow ID, an application error will be raised.  If the attribute number specified
    -- is invalid or outside the range 1-50, and error will be raised.
    --
    -- Note...if the supplied value for p_attr_value is null, then all members of the named
    -- collection will be deleted where the attribute (specified by p_attr_number) is null
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_attr_number       =  Attribute number of the member attribute used to match
    --                            for the specified attribute value for deletion.  Valid values are
    --                            1 through 50.  Any number outside of this range will raise an error.
    --     p_attr_value        =  Attribute value of the member attribute used to match for deletion.
    --                            Maximum length can be 4,000 bytes.  The attribute value will be
    --                            truncated to 4,000 bytes if greater than this amount.
    --
    --
    -- example(s):
    --     wwv_flow_collection.delete_members( p_collection_name => 'Firearm', p_attr_number => '1', p_attr_value => 'Colt' );
    --
    --       will delete ALL members in the collection named 'Firearm' where attribute number 1 has a value of 'Colt'
    --
    p_collection_name in varchar2,
    p_attr_number     in varchar2,
    p_attr_value      in varchar2)
    ;


procedure move_member_up(
    --
    -- Adjust the sequence ID of specified member in the given named collection up by one,
    -- swapping sequence ID with the one it's replacing (2 becomes 3, 3 becomes 2).  If a collection
    -- does not exist with the specified name for the current user in the same session and for
    -- the current Flow ID, an application error will be raised.  If the member specified by
    -- sequence ID p_seq does not exist, an application error will be raised.  If the specified member
    -- is the highest sequence in the collection, an application error will NOT be returned.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_seq               =  Sequence ID of the collection member to be moved up by one.
    --
    -- example(s):
    --     wwv_flow_collection.move_member_up( p_collection_name => 'Firearm', p_seq => '2' );
    --
    p_collection_name in varchar2,
    p_seq             in number )
    ;


procedure move_member_down(
    --
    -- Adjust the sequence ID of specified member in the given named collection down by one,
    -- swapping sequence ID with the one it's replacing (3 becomes 2, 2 becomes 3).  If a collection
    -- does not exist with the specified name for the current user in the same session and
    -- for the current Flow ID, an application error will be raised.  If the member specified by
    -- sequence ID p_seq does not exist, an application error will be raised.  If the specified member
    -- is the lowest sequence in the collection, an application error will NOT be returned.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_seq               =  Sequence ID of the collection member to be moved down by one.
    --
    -- example(s):
    --     wwv_flow_collection.move_member_down( p_collection_name => 'Firearm', p_seq => '2' );
    --
    p_collection_name in varchar2,
    p_seq             in number )
    ;


procedure sort_members(
    --
    -- For given named collection, reorder the members by the column number specified by
    -- p_sort_on_column_number.  This will not only sort the collection by a particular column/attribute
    -- in the collection, but it will also reassign the sequence ID's of each member such
    -- that no gaps will exist.
    --
    p_collection_name       in varchar2,
    p_sort_on_column_number in number )
    ;


function collection_has_changed(
    --
    -- For given named collection, determine if the collection has changed since it was
    -- created or since the collection changed flag was reset
    --
    p_collection_name in varchar2 )
    return boolean
    ;


procedure reset_collection_changed(
    --
    -- For given named collection, reset the collection changed flag
    -- (mark it as not changed)
    --
    p_collection_name in varchar2 )
    ;


procedure reset_collection_changed_all
    --
    -- Reset the collection changed flag (mark as not changed)
    -- for all collections in the user's current session
    --
    ;

function get_member_md5(
    --
    -- Compute and return the message digest of the attributes for the member specified by
    -- the sequence ID.  This computation of message digest is equal to the computation
    -- performed natively by collections.  Thus, the result of this function could be
    -- compared to the MD5_ORIGINAL column of the view wwv_flow_collections.
    --
    -- If a collection does not exist with the specified name for the current user in the same
    -- session and for the current Flow ID, an application error will be raised.  If the member
    -- specified by sequence ID p_seq does not exist, an application error will be raised.
    --
    --
    -- Arguments:
    --     p_collection_name   =  Name of collection.  Maximum length can be
    --                            255 bytes.  Note that collection_names are case-insensitive,
    --                            as the collection name will be converted to upper case
    --     p_seq               =  Sequence ID of the collection member.
    --
    -- example(s):
    --     l_md5 := wwv_flow_collection.get_member_md5( p_collection_name => 'Firearm', p_seq => '2' );
    --
    p_collection_name in varchar2,
    p_seq             in number )
    return varchar2
    ;

end wwv_flow_collection;
/