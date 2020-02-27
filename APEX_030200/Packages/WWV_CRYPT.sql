CREATE OR REPLACE package wwv_crypt
as
    --
    -- Functions to encrypt and decrypt strings, raws, blobs and clobs.
    -- the algorithm used (single des, triple des with 2key or 3key) will
    -- be decided based on the key length
    --
    -- 8 byte key  = single des (56bit key)
    -- 16 byte key = triple des with 2 keys (112bit key)
    -- 24 byte key = triple des with 3 keys (168bit key)
    --
    -- the key may be passed in with each call OR it may
    -- optionally be set for the package by calling "setKey"
    -- one time.  setKey will take either a RAW or VARCHAR2
    -- input.  If you are en/decrypting Raw or BLOB data -- you
    -- must use a RAW key.  If you an en/decrypting string or CLOB
    -- data you must us a VARCHAR2 key.
    --
    -- In addition to providing a layer on top of encryption, this
    -- package provides access  to the md5 routines if installed.
    --
    -- Errors returned:
    -- in addition to the documented DBMS_OBFUSCATION_TOOLKIT errors
    -- which this package will simply propage, the following "new"
    -- errors may be visible:
    -- In 8.1.6, you may recieve any one of:
    -- PLS-00302: component 'MD5' must be declared
    -- PLS-00302: component 'DES3ENCRYPT' must be declared
    -- PLS-00302: component 'THREEKEYMODE' must be declared
    --
    -- You will get these errors if you attempt to use the 8.1.7
    -- functionality of DES3 encryption or MD5 hashing.
    --

    --
    -- You use the encryptString and decryptString to encrypt/decrypt
    -- any string, date, or number data upto 32k in size.
    --
    -- these functions may be used in SQL
    -- the KEY parameter is optional, if you have set a key via the
    -- SETKEY procedure below.
    --
    -- Note how we AVOID function overloading for the encrypt/decrypt
    -- routines.  We have an encryptString and an encryptRaw.  This is to
    -- make the signatures of the functions unambigous so we can call them
    -- from SQL.  If we attempted to overload these functions based on INPUT
    -- TYPE only, the runtime SQL engine cannot tell if we intended to call
    -- the VARCHAR2 function or the RAW function.
    --

    function encryptString( p_data in varchar2,
                            p_key  in varchar2 default NULL )
    return varchar2;

    function decryptString( p_data in varchar2,
                            p_key  in varchar2 default NULL )
    return varchar2;

    --
    -- These functions behave identically to the String routines above
    -- but work on RAW data upto 32k in size.
    --
    function encryptRaw( p_data in raw,
                         p_key  in raw default NULL ) return raw;

    function decryptRaw( p_data in raw,
                         p_key  in raw default NULL ) return raw;


    --
    -- These functions will encrypt/decrypt LOBS.  Since we are limited
    -- to 32k of data in the encryption routines, we use an algorithm
    -- that encrypts 32k chunks of the LOB so the resulting LOB is a
    -- series of encrypted strings.
    --
    -- The decrypt routines understand how the data was "packed" by
    -- the encrypt routines and will decrypt the 32k chunks.
    --
    function encryptLob( p_data in clob,
                         p_key  in varchar2 default NULL ) return clob;
    function encryptLob( p_data in blob,
                         p_key  in raw default NULL ) return blob;

    function decryptLob( p_data in clob,
                         p_key  in varchar2 default NULL ) return clob;
    function decryptLob( p_data in blob,
                         p_key  in raw default NULL ) return blob;

    --
    -- These subtypes make it easier to declare a return variable
    -- that can accept checksums.  They are not needed, you can
    -- assign the checksums to varchar2s or raws as you see fit
    --
    subtype checksum_str is varchar2(16);
    subtype checksum_raw is raw(16);


    --
    -- A set of functions to take a string or upto 32k in size
    -- or a LOB of any size and compute the md5 checksum of it.
    -- Notice we avoid overloading RAW and
    -- VARCHAR2 functions again for the same reason as encrypt
    -- and decrypt
    --
    function md5str( p_data in varchar2 ) return checksum_str;
    function md5raw( p_data in raw ) return checksum_raw;

    --
    -- Used to encapsulate the actual function being used. This is
    -- helpful when using multiple db versions.
    --
    function one_way_hash_str( p_data in varchar2 ) return checksum_str;
    function one_way_hash_raw( p_data in raw ) return checksum_str;


    -- The MD5LOB functions take the first 32k of the BLOB or CLOB
    -- and compute a checksum for them.
    function md5lob( p_data in clob ) return checksum_str;
    function md5lob( p_data in blob ) return checksum_raw;
    --
    -- an optional procedure.  You can set the key once and then
    -- not have to pass it in with each call.
    --
    procedure setKey( p_key in varchar2 );
end wwv_crypt;
/